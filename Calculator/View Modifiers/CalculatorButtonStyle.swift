//
//  CalculatorButtonStyle.swift
//  Calculator
//
//  Created by brady murphy on 11/1/20.
//

import SwiftUI


struct CalculatorButtonViewModifier: ViewModifier {
    let calculatorButton: CalculatorButton
    let buttonSelected: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(backgroundColor)
            .overlay(
                Text(calculatorButton.symbol)
                    .font(.system(size: 36, weight: .medium, design: .default))
                    .foregroundColor(buttonSelected ? calculatorButton.selectedSymbolColor :calculatorButton.symbolColor)
            )
    }
    
    var backgroundColor: Color {
        buttonSelected ? calculatorButton.selectedBackgroundColor :calculatorButton.backgroundColor
    }
}


extension View {
    func calculatorButtonStyle(button: CalculatorButton, buttonSelected: Bool) -> some View {
        self.modifier(CalculatorButtonViewModifier(calculatorButton: button, buttonSelected: buttonSelected))
    }
}
