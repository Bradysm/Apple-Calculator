//
//  CalculatorBackground.swift
//  Calculator
//
//  Created by brady murphy on 11/1/20.
//

import Foundation
import SwiftUI


struct CalculatorBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            // background color
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            // main view
            content
                .padding(.bottom)
        }
    }
}


extension View {
    // sets the calculator background
    func calculatorBackground() -> some View {
        self.modifier(CalculatorBackground())
    }
}
