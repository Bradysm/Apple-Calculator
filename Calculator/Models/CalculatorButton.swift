//
//  CalculatorButton.swift
//  Calculator
//
//  Created by brady murphy on 10/31/20.
//

import Foundation
import SwiftUI


enum CalculatorButton {
    /// Button types
    case zero, one, two, three, four, five, six, seven, eight, nine, decimal,
         divide, multiply, minus, plus, equals,
         ac, percentage, negation,
         na
    
    var symbol: String {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .divide:
            return "÷"
        case .multiply:
            return "×"
        case .minus:
            return "-"
        case .plus:
            return "+"
        case .equals:
            return "="
        case .ac:
            return "AC"
        case .percentage:
            return "%"
        case .negation:
            return "+/-"
        case .decimal:
            return "."
        case .na:
            return ""
        }
    }
}
 
// MARK: Boolean Properties
extension CalculatorButton {
    var isOperator: Bool {
        switch self {
        case .divide, .equals, .minus, .plus, .multiply:
            return true
        default:
            return false
        }
    }
    
    var isNumberButton: Bool {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return true
        default:
            return false
        }
    }
    
    var isNumberAction: Bool {
        switch self {
        case .ac, .percentage, .negation:
            return true
        default:
            return false
        }
    }
}

// MARK: Colors
extension CalculatorButton {
    /// returns the color of the button based on the type of button
    var backgroundColor: Color {
        switch self {
        case  .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color.gray.opacity(0.5)
        case .divide, .multiply, .minus, .plus, .equals:
            return .orange
        default:
            return .gray
        }
    }
    
    /// returns the color of the button if the button is selected
    var selectedBackgroundColor: Color {
        switch self {
        case .divide, .minus, .plus, .multiply:
            return .white
        default:
            return backgroundColor
        }
    }
    
    /// returns the color of the button based on the type of button
    var symbolColor: Color {
        switch self {
        case  .ac, .percentage, .negation:
            return Color.black.opacity(0.8)
        default:
            return .white
        }
    }
    
    /// returns the color of the symbol when the button is selected
    var selectedSymbolColor: Color {
        switch self {
        case .divide, .minus, .plus, .multiply:
            return .orange
        default:
            return symbolColor
        }
    }
}
