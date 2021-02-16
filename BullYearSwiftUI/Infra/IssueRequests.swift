//
//  IssueRequests.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//

import Foundation

struct IssueListRequest: APIRequestConfiguration {
    typealias Failure = Error
    typealias Response = [Issue]
    let urlRequest: URLRequest

    init(page: Int = 1) {
        var request = URLRequest(url: URL(string: "https://api.github.com/repos/Carthage/Carthage/issues?filter=all&page=\(page)")!)
        request.setValue("", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        urlRequest = request
    }
}

struct IssueDetailRequest: APIRequestConfiguration {

    typealias Failure = Error
    typealias Response = Issue
    let urlRequest: URLRequest

    init(issueNumber: Int) {
        var request = URLRequest(url: URL(string: "https://api.github.com/repos/Carthage/Carthage/issues/\(issueNumber)")!)
        request.setValue("", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        urlRequest = request
    }
}
