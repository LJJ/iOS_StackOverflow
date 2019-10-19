//
//  AnswersModel.swift
//  StackOverflowDemo
//
//  Created by Michael Lu on 9/11/18.
//  Copyright © 2018 Michael Lu. All rights reserved.
//

import Foundation

struct AnswerListModel:Decodable {
    let hasMore:Bool
    let answers:[AnswerModel]
    
    enum CodingKeys:String, CodingKey{
        case hasMore = "has_more"
        case answers = "items"
    }
}

struct AnswerModel:Decodable {
    let owner:OwnerModel
    let body:String
    
    enum CodingKeys:String, CodingKey{
        case owner
        case body = "body_markdown"
    }
}
