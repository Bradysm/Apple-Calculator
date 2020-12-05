//
//  CalculatorScreen.swift
//  Calculator
//
//  Created by brady murphy on 11/1/20.
//

import SwiftUI

extension CalculatorView {
    /// Displays the "sreen" of the calculator
    var calculatorScreen: some View {
        GeometryReader { screenGeo  in
            Text(viewModel.numbersOnScreen)
                .foregroundColor(.white)
                .lineLimit(1)
                .font(viewModel.font)
                .bottomTrailingView()
                .padding(.trailing, screenGeo.size.width / 16)
        }
    }
}
