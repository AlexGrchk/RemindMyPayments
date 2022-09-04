//
//  DatePaymentsScreen.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import SwiftUI
import ComposableArchitecture

struct DatePaymentsScreen: View {
    
    let store: Store<DatePaymentsState, DatePaymentsAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List(Array(viewStore.payments.enumerated()), id: \.element.id) { index, item in
                    PaymentCell(payment: item)
                }
                .navigationTitle(viewStore.date.toString(format: "MMMM d"))
            }
        }
    }
}

struct DatePaymentsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DatePaymentsScreen(store: .init(initialState: .init(date: Date(), payments: []), reducer: datePaymentsReducer, environment: .init()))
    }
}

struct PaymentCell: View {
    
    var payment: Payment
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(payment.name ?? "")
                    .textStyle(size: 14, weight: .medium, color: Assets.Colors.darkGray)
                Text(payment.daysToPaymentStr)
                    .textStyle(size: 14, weight: .regular, color: Assets.Colors.darkGray)
            }
            Spacer()
            Text(payment.amountCurrency)
                .textStyle(size: 14, weight: .regular, color: Assets.Colors.darkGray)
            if payment.isPayedThisMonth {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.green)
            } else {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.red)
            }
        }
    }
    
}
