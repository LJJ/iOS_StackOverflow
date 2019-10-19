//
//  NetworkManager.swift
//  StackOverflowDemo
//
//  Created by Michael Lu on 9/11/18.
//  Copyright © 2018 Michael Lu. All rights reserved.
//

import Foundation
import Combine

enum NetworkError: Error {
    
    case responseStatus(_ des:String = "response code != 200")
    case responseType(_ des:String = "invalid response")
    case responseDataFormat(_ des:String = "data format is wrong")
}

struct NetworkManager {
    var session:URLSession
    
    static let shared = NetworkManager()
    
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration:config)
    }
    
    func send<T>(request:URLRequest) -> AnyPublisher<T, Error> where T:Decodable {
        return session.dataTaskPublisher(for: request)
            .mapError{NetworkError.responseType($0.localizedDescription)}
            .flatMap(maxPublishers: .max(1)){decode($0.data)}
            .eraseToAnyPublisher()
    }
}
