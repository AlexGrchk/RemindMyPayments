//
//  PaymentCreationScreen.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import SwiftUI
import ComposableArchitecture

struct PaymentCreationScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    let paymentCreationStore: Store<PaymentCreationState, PaymentCreationAction>
    
    var body: some View {
        WithViewStore(self.paymentCreationStore) { viewStore in
            NavigationView {
                ScrollView {
                    VStack(spacing: 24) {
                        FloatingTextField(title: L10n.description, text: viewStore.binding(get: { state in
                            state.payment.name ?? ""
                        }, send: { state in
                                .changeName(state)
                        }))
                        AmountInputField(text: viewStore.binding(get: {
                            String(format: "%.2f", $0.amount)
                        }, send: {
                            .changeAmount($0)
                        }), currency: viewStore.binding(get: {
                            $0.payment.currencyObj
                        }, send: {
                            .changeCurrency($0)
                        }))
                        
                        BasicDropDown(title: L10n.date, value: viewStore.binding(get: { $0.selectedDateType }, send: { .dateTypeSelected($0) }), data: viewStore.dateTypes, id: \.self) { item in
                            Button {
                                viewStore.send(.dateTypeSelected(item))
                            } label: {
                                Text(item.title)
                            }
                        }
                        
                        if viewStore.selectedDateType == .custom {
                            VStack(alignment: .leading) {
                                Text(L10n.pleaseSelectDayOfMonth)
                                    .textStyle(size: 12, weight: .medium, color: Assets.Colors.primary)
                                Picker(L10n.pleaseSelectDayOfMonth, selection: viewStore.binding(
                                    get: { state in
                                        Int(state.payment.paymentDay) - 1
                                    },
                                    send: { .changePaymentDay(Int($0) + 1) })) {
                                    ForEach(1..<32) { day in
                                        Text(day.description)
                                    }
                                }
                                .pickerStyle(.wheel)
                            }
                        }
                        
                        FloatingTextField(title: L10n.bankAccountName, text: viewStore.binding(get: { $0.payment.bankAccountName ?? "" }, send: { .changeBankAccountName($0) }))
                        
                    }
                    .padding(.horizontal, 16)
                }
                .navigationTitle(L10n.newPayment)
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewStore.send(.done)
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text(L10n.done)
                        }
                        .disabled(viewStore.payment.name == nil || viewStore.payment.name?.isEmpty ?? true)
                    }
                }
                .onAppear {
                    viewStore.send(.update)
                }
                .onDisappear {
                    viewStore.send(.dismissing)
                }
            }
        }
    }
}

struct PaymentCreationScreen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCreationScreen(paymentCreationStore: .init(initialState: .init(payment: .init()), reducer: paymentCreationReducer, environment: .init(onDone: {})))
    }
}
