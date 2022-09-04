//
//  FloatingTextField.swift
//  PaymentsReminder
//
//  Created by Oleksandr on 20.07.2022.
//

import SwiftUI


struct FloatingTextField: View {
    let title: String
    @Binding var text: String
    var isSecured: Bool = false
    var showDivider: Bool = true
    var topPadding: CGFloat = 15
    @State private var showAnimation: Bool = false

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(text.isEmpty ? Color(.placeholderText) : Assets.Colors.primary)
                    .offset(y: text.isEmpty ? 0 : -25)
                    .scaleEffect(text.isEmpty ? 1 : 0.75, anchor: .leading)
                    .animation(
                        .linear(duration: self.showAnimation ? 0.3 : 0.0)
                    )
                if self.isSecured {
                    SecureField("", text: self.$text)
                } else {
                    TextField("", text: self.$text)
                }
            }
            if self.showDivider {
                Divider()
            }
        }
        .padding(.top, self.topPadding)
        .onAppear {
            self.showAnimation = true
        }
    }
}
