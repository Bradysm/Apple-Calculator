//
//  CalculatorButtonPanel.swift
//  Calculator
//
//  Created by brady murphy on 11/1/20.
//

import SwiftUI

extension CalculatorView {
    /// Button control pannel for calculator
    var calculatorButtonPanel: some View {
        // calculator buttons
        VStack {
            // top row
            HStack {
                Spacer()
                CalculatorButtonView(calculatorButton: .ac) {
                    self.viewModel.clearCalculator()
                }
                CalculatorButtonView(calculatorButton: .negation) {
                    self.viewModel.negate()
                }
                CalculatorButtonView(calculatorButton: .percentage) {
                    self.viewModel.percent()
                }
                CalculatorButtonView(calculatorButton: .divide, selectedButton: $viewModel.operatorSelected) {
                    self.viewModel.select(operator: .divide)
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                CalculatorButtonView(calculatorButton: .seven) {
                    self.viewModel.select(number: .seven)
                }
                CalculatorButtonView(calculatorButton: .eight) {
                    self.viewModel.select(number: .eight)
                }
                CalculatorButtonView(calculatorButton: .nine) {
                    self.viewModel.select(number: .nine)
                }
                CalculatorButtonView(calculatorButton: .multiply, selectedButton: $viewModel.operatorSelected) {
                    self.viewModel.select(operator: .multiply)
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                CalculatorButtonView(calculatorButton: .four) {
                    self.viewModel.select(number: .four)
                }
                CalculatorButtonView(calculatorButton: .five) {
                    self.viewModel.select(number: .five)
                }
                CalculatorButtonView(calculatorButton: .six) {
                    self.viewModel.select(number: .six)
                }
                CalculatorButtonView(calculatorButton: .minus, selectedButton: $viewModel.operatorSelected) {
                    self.viewModel.select(operator: .minus)
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                CalculatorButtonView(calculatorButton: .one) {
                    self.viewModel.select(number: .one)
                }
                CalculatorButtonView(calculatorButton: .two) {
                    self.viewModel.select(number: .two)
                }
                CalculatorButtonView(calculatorButton: .three) {
                    self.viewModel.select(number: .three)
                }
                CalculatorButtonView(calculatorButton: .plus, selectedButton: $viewModel.operatorSelected) {
                    self.viewModel.select(operator: .plus)
                }
                Spacer()
            }
            
            // bottom row
            HStack {
                Spacer()
                GeometryReader { rowGeo in
                    HStack {
                        CalculatorButtonView(calculatorButton: .zero) {
                            self.viewModel.select(number: .zero)
                        }
                        .frame(width: (rowGeo.size.width / 2) - 4)
                        CalculatorButtonView(calculatorButton: .decimal) {
                            self.viewModel.select(number: .decimal)
                        }
                        CalculatorButtonView(calculatorButton: .equals, selectedButton: $viewModel.operatorSelected) {
                            self.viewModel.select(operator: .equals)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
