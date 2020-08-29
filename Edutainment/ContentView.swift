//
//  ContentView.swift
//  Edutainment
//
//  Created by Joseph Faragalla on 2020-07-20.
//  Copyright © 2020 Joseph Faragalla. All rights reserved.
//

import SwiftUI

class QuestionGenerator: ObservableObject {

    @Published var startOfRange = 1
    @Published var endOfRange = 12
    @Published var numberOfQuestions = 10.0
    
    var timesTable: [String : Int] {
        var table = [String : Int]()
        for n1 in startOfRange ... endOfRange {
            for n2 in startOfRange ... endOfRange {
                let question = "\(n1) x \(n2)"
                let answer = n1 * n2
                table[question] = answer
            }
        }
        return table
    }
    
}

struct ContentView: View {
    
    @ObservedObject var qg = QuestionGenerator()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Range")
                HStack {
                   
                    //properties are being changed here:
                    Stepper("From:  \(qg.startOfRange)", value: $qg.startOfRange)
                    Stepper("To:  \(qg.endOfRange)", value: $qg.endOfRange)
                }
                Text("Number of questions: \(Int(qg.numberOfQuestions))")
                
                //and here
                Slider(value: $qg.numberOfQuestions, in: 5 ... 50)
                .labelsHidden()
                Spacer()
                
                //link to gameView
                NavigationLink(destination: GameView(qg: qg)) {
                    Text("Start Game")
                }
                Button("Print table") {
                    print("First number \(self.qg.startOfRange)")
                    print("Second number: \(self.qg.endOfRange)")
                    print(self.qg.timesTable)
                }
                
                Spacer()
            }
        .navigationBarTitle("Math Fun")
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
