//
//  PaymentDetailsScreen.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import SwiftUI
import ComposableArchitecture

struct PaymentDetailsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    let store: Store<PaymentDetailsState, PaymentDetailsAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    PaymentDetailCell(title: L10n.description, value: viewStore.payment.name?.asStringOrNil ?? "-")
                    PaymentDetailCell(title: L10n.amount, value: "\(viewStore.payment.amountStr) \(viewStore.payment.currencyObj.symbol)")
                    PaymentDetailCell(title: L10n.date, value: L10n.everyDayOfMonth.replacingOccurrences(of: "[day]", with: viewStore.payment.paymentDay.description))
                    PaymentDetailCell(title: L10n.bankAccountName, value: viewStore.payment.bankAccountName?.asStringOrNil ?? "-")
                }
                .navigationTitle(L10n.paymentDetails)
                .toolbar {
                    ToolbarItem {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text(L10n.close)
                        }
                    }
                }
            }
        }
    }
}


struct PaymentDetailCell: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.title)
                .textStyle(size: 14, weight: .medium, color: Assets.Colors.darkGray)
            Text(self.value)
                .textStyle(size: 14, weight: .regular, color: Assets.Colors.darkGray)
        }
    }
    
}
