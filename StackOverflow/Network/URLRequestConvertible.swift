//
//  URLConvertible.swift
//  StackOverflowDemo
//
//  Created by Michael Lu on 9/11/18.
//  Copyright © 2018 Michael Lu. All rights reserved.
//

import Foundation
import Combine

enum HTTPMethod:String {
    case get = "GET"
}


protocol NetworkAPI {
    var baseURLStr:String {get}
    var path:String {get}
    var httpMethod:HTTPMethod {get}
    var parameters:[URLQueryItem] {get}
}

protocol NetworkPaginationAPI {
    mutating func nextPage() -> NetworkPaginationAPI
    mutating func firstPage() -> NetworkPaginationAPI
}


protocol URLRequestConvertible:NetworkAPI {
     func asURLRequest() -> URLRequest
     func send<T>() -> AnyPublisher<T,Error> where T:Decodable
}


extension URLRequestConvertible {
    func asURLRequest() -> URLRequest{
        var components = URLComponents(string: baseURLStr+"/"+path)!
        components.queryItems = parameters
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func send<T>() -> AnyPublisher<T,Error> where T:Decodable{
        return NetworkManager.shared.send(request: asURLRequest())
    }
}
