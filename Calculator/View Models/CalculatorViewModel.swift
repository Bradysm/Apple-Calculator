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

    /// No selection for operator
    @Published var operatorSelected = CalculatorButton.empty
    private var operatorToUse = CalculatorButton.empty
    
    private let MAX_DIGITS_ALLOWED = 9
    
    
    func select(operator binaryOperator: Operator) {
        assert(binaryOperator.isOperator)
        if binaryOperator == .equals {
            calculateResult()
        }
        withAnimation {
            operatorSelected = binaryOperator
        }
    }
    
    func select(number: NumberButton) {
        assert(number.isNumberButton)
        
        // if there is an operator selected then move the number over and remove teh operator from being selected
        if operatorSelected != .empty {
            enteredNumber = Double(numbersOnScreen) ?? 0.0
            operatorToUse = operatorSelected
            operatorSelected = .empty
            numbersOnScreen = (number == .decimal) ? "0." : number.symbol
        } else {
            withAnimation {
                // only allow more to be added if we aren't at max number
                guard numbersOnScreen.count < MAX_DIGITS_ALLOWED && !numbersOnScreen.contains("e") else {
                    return
                }
                
                // only add decimal if it's not entered already
                if number == .decimal {
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
    }
    
    /// Takes the percent of the entered number on the screen
    func percent() {
        let percentageValue = (Double(numbersOnScreen) ?? 0.0) / 100
        numbersOnScreen = String(NSNumber(value: percentageValue).stringValue)
        
        // display scientific notation if the
        if numbersOnScreen.count > MAX_DIGITS_ALLOWED {
            numbersOnScreen = percentageValue.scientificFormatted
        }
    }
    
    func negate() {
        let negation = (Double(numbersOnScreen) ?? 0.0) * -1
        numbersOnScreen = String(NSNumber(value: negation).stringValue)
        
        // display scientific notation if the
        if numbersOnScreen.count > MAX_DIGITS_ALLOWED {
            numbersOnScreen = negation.scientificFormatted
        }
    }
    
    /// function to be called when equals is selected
    private func calculateResult() {
        // make sure an operator is sleected
        guard operatorToUse != .empty else {
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
        
        // update the entered number to be the previous calculated value
        numbersOnScreen = String(NSNumber(value: calculatedValue).stringValue)
        
        // display scientific notation if the
        if numbersOnScreen.count > MAX_DIGITS_ALLOWED {
            numbersOnScreen = calculatedValue.scientificFormatted
        }
        
        enteredNumber = calculatedValue
        operatorToUse = .empty
    }
    
    func clearCalculator() {
        calculatedValue = 0.0
        enteredNumber = 0.0
        numbersOnScreen = "0"
        operatorSelected = .empty
    }
    
    var font: Font {
        let size: CGFloat = numbersOnScreen.count > 6 ? 56 : 96
        return .system(size: size, weight: .light, design: Font.Design.default)
    }
}


private extension Formatter {
    static let scientific: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.positiveFormat = "0.###E+0"
        formatter.exponentSymbol = "e"
        return formatter
    }()
}

extension Numeric {
    var scientificFormatted: String {
        return Formatter.scientific.string(for: self) ?? ""
    }
}
