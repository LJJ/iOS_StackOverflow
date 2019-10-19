//
//  Utilities.swift
//  StackOverflow
//
//  Created by Michael Lu on 10/18/19.
//  Copyright © 2019 Michael Lu. All rights reserved.
//

import Foundation
import Combine

func decode<T:Decodable>(_ data:Data) -> AnyPublisher<T,Error> {
    return Just(data)
        .decode(type: T.self, decoder: JSONDecoder())
    .eraseToAnyPublisher()
}
