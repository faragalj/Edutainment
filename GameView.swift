//
//  GameView.swift
//  Edutainment
//
//  Created by Joseph Faragalla on 2020-07-23.
//  Copyright © 2020 Joseph Faragalla. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var qg: QuestionGenerator
    @State private var question = ""
    @State private var answer = 0
    @State private var userInput = ""
    @State private var score = 0
    
    @State private var questionsDisplayed = 0.0
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 30) {
                Text(question)
                TextField("Answer", text: $userInput)
                    .keyboardType(.numberPad)
                Button("Next") {
                    self.checkAnswer()
                }
                Text("Score: \(score)")
                Spacer()
            }
        }
        .onAppear(perform: generateQuestion)
    }
    //generates questions
    func generateQuestion() {
        if let randomQuestion = qg.timesTable.keys.randomElement() {
            question = "What is: \(randomQuestion)?"
            
            //there has at least one question in the array so it is okay to force unwrap
            answer = qg.timesTable[randomQuestion]!
        }
    }
    
    func checkAnswer() {
        
        //add to the questionsPlayed so far:
        questionsDisplayed += 1.0
        
        var userAnswer = Int(userInput) ?? 0
        
        //answer is correct
        if userAnswer == answer {
            
            //update score
            score += 1
            
            //clear the textbox
            userInput = ""
            
            //go to next question if they have not exceeded the amount they set
            if questionsDisplayed <= qg.numberOfQuestions {
                generateQuestion()
            }
            
            
        }
        else {
            //let them keep guessing, do nothing
        }
        
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(qg: QuestionGenerator())
    }
}
