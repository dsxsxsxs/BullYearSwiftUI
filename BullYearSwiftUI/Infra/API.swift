//
//  API.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//
import Foundation
import Combine

protocol NetworkClient {
    func execute(request: URLRequest) -> AnyPublisher<(Data, URLResponse), Error>
}

private struct URLSessionClient: NetworkClient {
    func execute(request: URLRequest) -> AnyPublisher<(Data, URLResponse), Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0 }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}

struct API {
    private let client: NetworkClient = URLSessionClient()

    func connect<Config: APIRequestConfiguration>(config: Config) -> AnyPublisher<Config.Response, Config.Failure> where Config.Failure: Swift.Error {
        client.execute(request: config.urlRequest)
            .mapError { Error.urlSessionError($0) }
            .tryMap {
                let data = try handle(data: $0, response: $1)
                do {
                    return try config.decode(from: data)
                } catch let error {
                    throw Error.decodingError(error)
                }
            }
            .mapError { config.map(error: $0 as! Error) }
            .eraseToAnyPublisher()
    }
}

private func handle(data: Data, response urlResponse: URLResponse) throws -> Data {
    guard let response = urlResponse as? HTTPURLResponse else {
        throw API.Error.unknown(message: "Unexpected Response type \(urlResponse)")
    }

    switch response.statusCode {
    case 204:
        return Data()
    case 200...299:
        return data
    case 400...:
        throw API.Error.httpResponseError(
            statusCode: response.statusCode,
            reason: String(data: data, encoding: .utf8),
            description: response.debugDescription
        )
    case let code:
        throw API.Error.unknown(message: "Unsupport Code:\(code)")
    }
}

extension API {
    enum Error: Swift.Error {
        case unknown(message: String?)
        case urlSessionError(Swift.Error)
        case httpResponseError(statusCode: Int, reason: String?, description: String?)
        case decodingError(Swift.Error)
    }
}
