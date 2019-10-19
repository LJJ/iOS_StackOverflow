//
//  SearchQuestionModel.swift
//  StackOverflowDemo
//
//  Created by Michael Lu on 9/11/18.
//  Copyright © 2018 Michael Lu. All rights reserved.
//

import Foundation

struct SearchQuestionModel:Codable {
    let hasMore:Bool
    var questions:[QuestionModel]
    
    enum CodingKeys:String, CodingKey{
        case hasMore = "has_more", questions = "items"
    }
}

class QuestionModel:Codable, Identifiable {
    let owner:OwnerModel
    let title:String
    let answerCount:Int
    let questionID:Int
    
    enum CodingKeys:String, CodingKey{
        case owner, title
        case answerCount = "answer_count", questionID = "question_id"
    }
}

struct OwnerModel:Codable {
    let name:String
    let image:String
    
    enum CodingKeys:String, CodingKey{
        case name = "display_name", image = "profile_image"
    }
}
