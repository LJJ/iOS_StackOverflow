//
//  QuestionsViewModel.swift
//  StackOverflowDemo
//
//  Created by Michael Lu on 10/12/19.
//  Copyright © 2019 Michael Lu. All rights reserved.
//

import Foundation
import Combine


class QuestionsViewModel:ObservableObject {
    @Published var question:String
    var questionsList = [QuestionModel]()
    
    fileprivate var searchModel:SearchQuestionModel?
    fileprivate var searchAPI:StackOverflowAPI!
    @objc dynamic var isLoading = false
    @objc dynamic var questionCount = 0
    private var disposables = Set<AnyCancellable>()
    
    var s:AnyCancellable!
    
    init(_ question:String) {
        self.question = question
        
        s = $question
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.global())
        .sink(receiveValue: search(_:))
    }
    
    func search(_ query:String) {
        searchAPI = StackOverflowAPI.searchQuestion(title: query, page: 1, pageSize: 20)
        requestFirstPage()
    }
}

extension QuestionsViewModel{
    var numberOfQuestions: Int {
        return searchModel?.questions.count ?? 0
    }
    
    typealias QuestionInfo = (title:String, ownerName:String, answerCount:String, ownerImage:URL?)
    
    func questionInfo(at index: Int) -> QuestionInfo {
        let q = searchModel!.questions[index]
        return (q.title, q.owner.name,"\(q.answerCount)",URL(string: q.owner.image))
    }
    
    func requestFirstPage() {
        fetchQuestions(true)
    }
    
    func requestNextPage() {
        if !searchModel!.hasMore {
            return
        }
        _ = searchAPI.nextPage()
        fetchQuestions(false)
    }
    
    private func fetchQuestions(_ needRefresh:Bool){
        searchAPI.send().receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let err):
                    print(err)
                case .finished:
                    print("finished")
                }
            }) { [weak self] (search:SearchQuestionModel) in
                guard let self = self else{return}
                if needRefresh {self.questionsList = search.questions}
                else {self.questionsList.append(contentsOf: search.questions)}
        }.store(in: &disposables)
    }
}
