//
//  AmountInputField.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import SwiftUI

struct AmountInputField: View {
    
    @Binding var text: String
    @Binding var currency: Currency
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(L10n.amount)
                .textStyle(size: 14, weight: .medium, color: Assets.Colors.primary)
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .stroke(Assets.Colors.primary)
                VStack {
                    HStack {
                        Spacer()
                        Menu {
                            ForEach(Currency.allCases, id: \.self) { item in
                                Button {
                                    self.currency = item
                                } label: {
                                    Text(item.name)
                                }
                            }
                        } label: {
                            HStack {
                                Text(self.currency.symbol)
                                    .textStyle(size: 11, weight: .regular, color: Assets.Colors.darkGray)
                                Assets.Images.arrowDown
                            }
                        }
                    }
                    .padding()
                    Spacer()
                }
                TextField("0.00", text: self.$text)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .textStyle(size: 42, weight: .regular, color: Assets.Colors.darkGray)
                    .padding(16)
            }
            .frame(height: 120)
        }
    }
    
}

