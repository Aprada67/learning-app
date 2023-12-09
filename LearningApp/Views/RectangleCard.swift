//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Alberto Jesús Prada Parmera on 05/12/2023.
//

import SwiftUI

struct RectangleCard: View {
    
    // Make color dinamic
    var color = Color.white
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            // Make color dinamic
            .foregroundStyle(color)
            .shadow(radius: 5)
    }
}

#Preview {
    RectangleCard()
}
