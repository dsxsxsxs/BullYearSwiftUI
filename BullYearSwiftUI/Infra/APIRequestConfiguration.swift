//
//  APIRequestConfiguration.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//

import Foundation

protocol APIRequestConfiguration {
    associatedtype Response
    associatedtype Failure
    var urlRequest: URLRequest { get }
    func decode(from data: Data) throws -> Response
    func map(error: API.Error) -> Failure
}

extension APIRequestConfiguration where Response: Decodable {
    func decode(from data: Data) throws -> Response {
        try JSONDecoder().decode(Response.self, from: data)
    }
}

extension APIRequestConfiguration where Failure == Error {
    func map(error: API.Error) -> Failure {
        error
    }
}

