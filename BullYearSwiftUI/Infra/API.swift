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

struct API {
    private let client: NetworkClient

    func connect<Config: APIRequestConfiguration>(config: Config) -> AnyPublisher<Config.Response, Config.Failure> where Config.Failure: Swift.Error {
        fatalError()
    }

    private static func handle(data: Data, response urlResponse: URLResponse) throws -> Data {
        guard let response = urlResponse as? HTTPURLResponse else {
            throw Error.unknown(message: "Unexpected Response type \(urlResponse)")
        }

        switch response.statusCode {
        case 204:
            return Data()
        case 200...299:
            return data
        case 400...:
            throw Error.httpResponseError(
                statusCode: response.statusCode,
                reason: String(data: data, encoding: .utf8),
                description: response.debugDescription
            )
        case let code:
            throw Error.unknown(message: "Unsupport Code:\(code)")
        }
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
