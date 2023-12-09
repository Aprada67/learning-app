//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Alberto Jesús Prada Parmera on 30/11/2023.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        
        /* Para obtener las url de los medias que queremos utilizar,
         deben tener un host, uns forma de hacerlo gratis es subiendolas
         a un repositorio de github */
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            
            // Only show video if we get a valid url
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            // TODO: Description
            CodeTextView()
            
            // Show next lesson button only, only if there is a next lesson
            if model.hasNextLesson() {
                
                Button(action: {
                    // Advance the lesson
                    model.nextLesson()
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundStyle(.white)
                            .bold()
                        	
                    }
                })
                
            }
            else {
                
                // Show the cmplete button instead
                Button(action: {
                    // Take the user back to the homeView
                    model.currentContentSelected = nil
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        
                        Text("Completed")
                            .foregroundStyle(.white)
                            .bold()
                            
                    }
                })
                
            }
            
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
    }
}
