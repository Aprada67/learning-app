//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Alberto Jesús Prada Parmera on 21/11/2023.
//

import SwiftUI

@main
struct LearningAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
