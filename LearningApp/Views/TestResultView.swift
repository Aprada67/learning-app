//
//  TestResultView.swift
//  LearningApp
//
//  Created by Alberto Jesús Prada Parmera on 11/12/2023.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var numCorrect: Int
    
    var resultHeading: String {
        
        // prevent for crashing pct
        guard model.currentModule != nil else {
            return ""
        }
        
        let pct = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        
        if pct > 0.5 {
            return "Awesome"
        }
        else if pct > 0.2 {
            return "Doing great"
        }
        else {
            return "Keep learning"
        }
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Text(resultHeading)
                .font(.title)
            
            Spacer()
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0 ) question")
            
            Spacer()
            
            Button(action: {
                
                // Send the user back to the homeView
                model.currentTestSelected = nil
                
            }, label: {
                
                ZStack {
                    
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundStyle(Color.white)
                    
                }
                
            })
            
            Spacer()
        }
        
    }
}
