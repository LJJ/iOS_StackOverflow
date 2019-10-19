//
//  NetworkAPI.swift
//  StackOverflowDemo
//
//  Created by Michael Lu on 9/11/18.
//  Copyright © 2018 Michael Lu. All rights reserved.
//

import Foundation

enum StackOverflowAPI:URLRequestConvertible, NetworkPaginationAPI  {
    
    case searchQuestion(title:String, page:Int, pageSize:Int)
    case answers(questionId:Int, page:Int, pageSize:Int)
    
    var baseURLStr: String {
        get {
            return "https://api.stackexchange.com/2.2"
        }
    }
    
    var path: String {
        get {
            switch self {
            case .searchQuestion:
                return "search"
            case .answers(let questionId, _ , _):
                return "questions/\(questionId)/answers"
            }
        }
    }
    
    var httpMethod: HTTPMethod {
        get {
            return HTTPMethod.get
        }
    }
    
    var parameters: [URLQueryItem] {
        var pars = [String:String]()
        switch self {
        case let .searchQuestion(title, page, pageSize):
            pars = ["order":"desc",
                    "sort":"activity",
                    "intitle":title,
                    "site":"stackoverflow",
                    "page":"\(page)",
                "pagesize":"\(pageSize)"]
        case let .answers(_ , page, pageSize):
            pars = [
                "order":"desc",
                "sort":"activity",
                "site":"stackoverflow",
                "page":"\(page)",
                "pagesize":"\(pageSize)",
                "filter":"!9Z(-wzftf"]
        }
        var items = [URLQueryItem]()
        for p in pars{
            items.append(URLQueryItem(name: p.key, value: p.value))
        }
        return items
    }
    
    mutating func nextPage() -> NetworkPaginationAPI {
        switch self {
        case let .searchQuestion(title , page, pageSize):
            self = .searchQuestion(title: title, page: page+1, pageSize: pageSize)
        case let .answers(questionId , page, pageSize):
            self = .answers(questionId: questionId, page: page+1, pageSize: pageSize)
        }
        return self
    }
    
    mutating func firstPage() -> NetworkPaginationAPI {
        switch self {
        case let .searchQuestion(title , _, pageSize):
            self = .searchQuestion(title: title, page: 0, pageSize: pageSize+1)
        case let .answers(questionId , _, pageSize):
            self = .answers(questionId: questionId, page: 0, pageSize: pageSize)
        }
        return self
    }
}
