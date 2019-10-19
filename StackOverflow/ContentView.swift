//
//  ContentView.swift
//  StackOverflow
//
//  Created by Michael Lu on 10/14/19.
//  Copyright © 2019 Michael Lu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = QuestionsViewModel("swift")
    
    var body: some View {
        VStack{
            TextField("Search", text: $viewModel.question)
            List(viewModel.questionsList) { q in
                Text(q.title)
            }
        }
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
