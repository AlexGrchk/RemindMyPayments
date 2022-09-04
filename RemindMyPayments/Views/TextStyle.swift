//
//  TextStyle.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 13.08.2022.
//

import SwiftUI


struct TextStyleModifier: ViewModifier {
    
    var size: CGFloat
    var weight: Font.Weight
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: self.size, weight: self.weight))
            .foregroundColor(self.color)
    }
}


extension View {
    
    func textStyle(size: CGFloat, weight: Font.Weight, color: Color) -> some View {
        self
            .modifier(TextStyleModifier(size: size, weight: weight, color: color))
    }
    
    func textStyle(size: CGFloat, weight: Font.Weight, color: UIColor) -> some View {
        self
            .modifier(TextStyleModifier(size: size, weight: weight, color: color.toSuiColor))
    }
    
}

extension UIColor {
    
    var toSuiColor: Color {
        return Color(self)
    }
    
}

