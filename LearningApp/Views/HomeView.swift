//
//  ContentView.swift
//  LearningApp
//
//  Created by Alberto Jesús Prada Parmera on 21/11/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(model.modules) { module in
                            
                            VStack (spacing: 20) {
                                
                                NavigationLink(
                                    destination:
                                        ContentView()
                                        .onAppear(perform: {
                                            model.beginMoudule(module.id)
                                        }),
                                    tag: module.id,
                                    selection: $model.currentContentSelected) {
                                        
                                        HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                        
                                    }
                                
                                NavigationLink(
                                    destination:
                                        TestView()
                                        .onAppear(perform: {
                                            model.beginTest(module.id)
                                        }),
                                    tag: module.id,
                                    selection: $model.currentTestSelected) {
                                        
                                        // Test card
                                        HomeViewRow(image: module.test.image, title: "Learn \(module.category)", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                                    }
                                
                                // There is a bug in iOS 14th that when you have more than 1 navigationLink, wehn you click on it, it'll take you back to the home view.
                                // To fix this error We have to create an empity NavigationLink
                                
                                NavigationLink(destination: EmptyView()) {
                                    EmptyView()
                                }
                                
                            }
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
            }
            .navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    HomeView()
        .environmentObject(ContentModel())
}
