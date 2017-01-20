//
//  DFNetworkClient.swift
//  df-demo
//
//  Created by Chris Dzombak on 1/20/17.
//  Copyright © 2017 Chris Dzombak. All rights reserved.
//

import Foundation

final class DFNetworkClient {
    private let session: URLSession

    enum FrontingError: Error {
        case invalidURL
        case nonNetworkURL
    }

    init() {
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) throws -> URLSessionDataTask {
        return session.dataTask(with: try frontedRequest(from: request), completionHandler: completionHandler)
    }

    func frontedRequest(from request: URLRequest) throws -> URLRequest {
        guard let targetURL = request.url,
            let components = URLComponents(url: targetURL, resolvingAgainstBaseURL: false)
            else { throw FrontingError.invalidURL }

        var frontedRequest = request
        frontedRequest.setValue(components.host, forHTTPHeaderField: "Host")

        var frontedComponents = components
        frontedComponents.scheme = "https"
        frontedComponents.host = "www.google.com"
        guard let frontedURL = frontedComponents.url else { throw FrontingError.nonNetworkURL }

        frontedRequest.url = frontedURL
        return frontedRequest
    }
}
