//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by brady murphy on 10/31/20.
//

import Foundation
import SwiftUI

final class CalculatorViewModel: ObservableObject {
    typealias Operator = CalculatorButton
    typealias NumberButton = CalculatorButton
    
    /// Calculated value to be shown if operator selected is equals
    @Published var calculatedValue = 0.0
    
    /// Previous entered number
    @Published var enteredNumber = 0.0
    
    /// Current number being typed on screen
    @Published var numbersOnScreen = "0"

    /// operator selected on the screen
    @Published var operatorSelected = CalculatorButton.na
    
    /// reperesnts the operator to use for the next calculation
    private var operatorToUse = CalculatorButton.na
    
    private let MAX_DIGITS_ALLOWED = 9
    
    
    /// function called when an operator is selected
    func select(operator binaryOperator: Operator) {
        assert(binaryOperator.isOperator)
        if binaryOperator == .equals {
            calculateResult()
        }
        withAnimation {
            operatorSelected = binaryOperator
        }
    }
    
    /// function called when a number button is selected
    /// this function will update the numbers shown on the screen
    func select(number: NumberButton) {
        assert(number.isNumberButton)
        
        // operator has been selected
        // move numberOnScreen to enteredNumber and add selected number to screen
        // update selected operator
        if operatorSelected != .na {
            enteredNumber = Double(numbersOnScreen) ?? 0.0
            setOperatorToUse(to: operatorSelected)
            numbersOnScreen = (number == .decimal) ? "0." : number.symbol
            return
        }
        
        // operator isn't selected, add the number to screen
        withAnimation {
            // only allow more to be added if we aren't at max number and not scientific notation
            guard numbersOnScreen.count < MAX_DIGITS_ALLOWED && !numbersOnScreen.contains("e") else {
                return
            }
            
            // only add decimal if it's not entered already
            if number == .decimal {
                // ensure there isn't a decimal already entered
                if  !numbersOnScreen.contains(number.symbol) {
                    numbersOnScreen.append(number.symbol)
                }
            } else if numbersOnScreen == "0" {
                numbersOnScreen = number.symbol
            } else {
                numbersOnScreen.append(number.symbol)
            }
        }
    }
    
    /// Takes the percent of the entered number on the screen
    func percent() {
        let percentageValue = (Double(numbersOnScreen) ?? 0.0) / 100
        updateNumbersOnScreen(to: percentageValue)
    }
    
    /// negates the entered number on the screen
    func negate() {
        let negatedNumberOnScreen = (Double(numbersOnScreen) ?? 0.0) * -1
        updateNumbersOnScreen(to: negatedNumberOnScreen)
    }
    
    /// clears the calculator to defaults
    func clearCalculator() {
        calculatedValue = 0.0
        enteredNumber = 0.0
        numbersOnScreen = "0"
        operatorSelected = .na
    }
    
    // MARK: - Helper functions
    /// function to be called when equals is selected
    private func calculateResult() {
        // make sure an operator is sleected to use
        guard operatorToUse != .na else {
            return
        }
        
        switch operatorToUse {
        case .plus:
            calculatedValue = enteredNumber + (Double(numbersOnScreen) ?? 0.0)
        case .minus:
            calculatedValue = enteredNumber - (Double(numbersOnScreen) ?? 1.0)
        case .divide:
            calculatedValue = enteredNumber / (Double(numbersOnScreen) ?? 1.0)
        case .multiply:
            calculatedValue = enteredNumber * (Double(numbersOnScreen) ?? 1.0)
        default:
            return
        }
        
        updateNumbersOnScreen(to: calculatedValue)
        
        // move the calculated number to the entered number
        enteredNumber = calculatedValue
        operatorToUse = .na
    }
   
    /// Updates the numbers on the screen to the given value
    /// if the value is too large, then it's displayed in scientific notation
    private func updateNumbersOnScreen(to value: Double) {
        // update the entered number to be the previous calculated value
        numbersOnScreen = String(NSNumber(value: value).stringValue)
        
        // display scientific notation if the number is too large to display
        if numbersOnScreen.count > MAX_DIGITS_ALLOWED {
            numbersOnScreen = value.scientificFormatted
        }
    }
    
    /// Sets the `operatorToUse` to the `selectedOperator` and updates the
    /// `operatorSelected` to empty
    private func setOperatorToUse(to selectedOperator: Operator) {
        operatorToUse = selectedOperator
        operatorSelected = .na
    }
    
    // MARK: - Font
    var font: Font {
        let size: CGFloat = numbersOnScreen.count > 6 ? 56 : 96
        return .system(size: size, weight: .light, design: Font.Design.default)
    }
}


// MARK: - Scientific Notation
private extension Formatter {
    static let scientific: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.positiveFormat = "0.###E+0"
        formatter.exponentSymbol = "e"
        return formatter
    }()
}

private extension Numeric {
    var scientificFormatted: String {
        return Formatter.scientific.string(for: self) ?? ""
    }
}
