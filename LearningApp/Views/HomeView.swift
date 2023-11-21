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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    HomeView()
        .environmentObject(ContentModel())
}
