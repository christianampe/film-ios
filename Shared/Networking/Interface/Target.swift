//
//  Target.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

// MARK: - Network Request Protocol
protocol Target {
    
    /// The target's base url.
    var baseURL: URL { get }
    
    /// The path to be appended to base url to form the full url.
    var paths: [String] { get }
    
    /// The http method used in the request.
    var method: String { get }
    
    /// The parameters to be appended to the full formed url.
    var parameters: [String: String] { get }
    
    /// The headers to be used in the request.
    var headers: [String: String] { get }
    
    /// The body to be used in the request.
    var body: Data? { get }
    
}

// MARK: - Default Implementation
extension Target {
    var paths: [String] {
        []
    }
    
    var method: String {
        "GET"
    }
    
    var parameters: [String: String] {
        [:]
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var body: Data? {
        nil
    }
}

// MARK: - Public Constructor
extension Target {
    
    /// URL request constructed from the object.
    func request() -> URLRequest {
        
        // construct url request from base url
        var urlRequest = URLRequest(url: baseURL)
        
        // add path to url request
        addPaths(paths, to: &urlRequest)
        
        // add url components
        addQueryParameters(parameters, to: &urlRequest)
        
        // add http method type
        addMethod(method, to: &urlRequest)
        
        // add headers to url request
        addHeaders(headers, to: &urlRequest)
        
        // return construct request
        return urlRequest
    }
}

// MARK: - Private Request Constructor Helpers
private extension Target {
    
    /// Appends the given paths to the request url.
    ///
    /// - Parameters:
    ///   - paths: URL endpoint paths to be added to the base url.
    ///   - request: Inout url request being constructed.
    func addPaths(_ paths: [String],
                  to request: inout URLRequest) {
        
        paths.forEach { request.url?.appendPathComponent($0) }
    }
    
    /// Encodes and appends the given request parameters to the request url.
    ///
    /// - Parameters:
    ///   - parameters: Parameters to be added to the url query.
    ///   - request: Inout url request being constructed.
    func addQueryParameters(_ parameters: [String: String],
                            to request: inout URLRequest) {
        
        guard let requestURL = request.url else {
            return
        }
        
        let items = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        var urlComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
        
        urlComponents?.queryItems = items
        
        request.url = urlComponents?.url
    }
    
    /// Adds the http method type to the request.
    ///
    /// - Parameters:
    ///   - method: HTTP method to be executed.
    ///   - request: Inout url request being constructed.
    func addMethod(_ method: String,
                   to request: inout URLRequest) {
        
        request.httpMethod = method
    }
    
    /// Adds given headers to the request.
    ///
    /// - Parameters:
    ///   - headers: Headers to be added to the http header field.
    ///   - request: Inout url request being constructed.
    func addHeaders(_ headers: [String: String],
                    to request: inout URLRequest) {
        
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
    }
}
