//
//  ViewLocationModifier.swift
//  Calculator
//
//  Created by brady murphy on 11/1/20.
//

import Foundation
import SwiftUI



struct LocationViewModifier: ViewModifier {
    let verticalLocation: VerticalLocation
    let horizontalLocation: HorizontalLocation
    
    enum VerticalLocation {
        case centered, top, bottom
    }
    
    enum HorizontalLocation {
        case centered, leading, trailing
    }
    
    func body(content: Content) -> some View {
        HStack {
            if horizontalLocation == .trailing {
                Spacer()
            }
            VStack {
                if verticalLocation == .bottom {
                    Spacer()
                }
                content
                if verticalLocation == .top {
                    Spacer()
                }
            }
            if horizontalLocation == .leading {
                Spacer()
            }
        }
    }
}



extension View {
    func bottomTrailingView() -> some View {
        self.modifier(LocationViewModifier(verticalLocation: .bottom, horizontalLocation: .trailing))
    }
}
