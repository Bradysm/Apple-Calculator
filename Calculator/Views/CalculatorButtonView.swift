//
//  CalculatorButtonView.swift
//  Calculator
//
//  Created by brady murphy on 10/31/20.
//

import SwiftUI

struct CalculatorButtonView: View {
    // injected in
    let calculatorButton: CalculatorButton
    @Binding var selectedButton: CalculatorButton
    let action: () -> Void
    
    init(calculatorButton: CalculatorButton,
         selectedButton: Binding<CalculatorButton> = .constant(.na),
         action: @escaping () -> Void) {
        self.calculatorButton = calculatorButton
        self._selectedButton = selectedButton
        self.action = action
    }
    
    var body: some View {
        GeometryReader { geo in
            Button(action: action) {
                VStack {
                    switch calculatorButton {
                    case .zero:
                        Capsule()
                    default:
                        Circle()
                    }
                }
                .calculatorButtonStyle(button: calculatorButton, buttonSelected: buttonSelected)
            }
        }
    }
    
    /// Returns true if the button is selected
    var buttonSelected: Bool {
        calculatorButton == selectedButton
    }
}

#if DEBUG
struct CalculatorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonView(calculatorButton: .equals, selectedButton: .constant(.equals)) {
            print("Executing action")
        }
    }
}
#endif
