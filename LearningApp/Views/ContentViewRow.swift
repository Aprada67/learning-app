//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by Alberto Jesús Prada Parmera on 29/11/2023.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var body: some View {
        
        let lessons = model.currentModule!.content.lessons[index]
        
        // Lesson Card
        ZStack (alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .frame(height: 66)
            
            HStack (spacing: 30) {
                
                Text(String(index + 1))
                    .bold()
                
                VStack (alignment: .leading) {
                    
                    Text(lessons.title)
                        .bold()
                    Text(lessons.duration)
                    
                }
                
            }
            .padding()
        }
        .padding(.bottom, 5)
    }
}
