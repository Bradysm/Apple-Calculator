//
//  CalculatorView.swift
//  Calculator
//
//  Created by brady murphy on 10/31/20.
//

import SwiftUI

struct CalculatorView: View {
    @ObservedObject var viewModel = CalculatorViewModel()

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                calculatorScreen
                    .frame(height: geo.size.height / 3)
                calculatorButtonPanel
            }
        }
        .calculatorBackground()
    }
}

#if DEBUG
struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
#endif
