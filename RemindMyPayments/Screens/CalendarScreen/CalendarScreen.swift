//
//  CalendarScreen.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 13.08.2022.
//

import SwiftUI
import ComposableArchitecture


struct CalendarScreen: View {
    @Environment(\.calendar) var calendar
    let store: Store<CalendarState, CalendarAction>
    
    var body: some View {
        
        WithViewStore(self.store) { calendarStore in
            NavigationView {
                VStack {
                    List {
                        CalendarView(interval: .init()) { date in
                            VStack(spacing: 1) {
                                Text("30")
                                    .hidden()
                                    .padding(8)
                                    .frame(height: 25)
                                    .cornerRadius(4)
                                    .padding(4)
                                    .background(Calendar.current.isDate(date, equalTo: Date(), toGranularity: .day) ? .blue.opacity(0.5) : .clear)
                                    .clipShape(Circle())
                                    .overlay(
                                        Text(String(self.calendar.component(.day, from: date)))
                                            .foregroundColor(Color.black)
                                    )
                                if calendarStore.state.hasPayment(on: date) {
                                    Circle()
                                        .fill(.gray)
                                        .frame(width: 3, height: 3)
                                } else {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 3, height: 3)
                                }
                            }
                            .background(.white)
                            .onTapGesture {
                                if calendarStore.state.hasPayment(on: date) {
                                    calendarStore.send(CalendarAction.calendarDateSelected(date))
                                }
                            }
                            
                        }
                        if calendarStore.payments.isEmpty {
                            HStack {
                                Spacer()
                                VStack(alignment: .center, spacing: 12) {
                                    Text(L10n.youDontHavePayments)
                                        .textStyle(size: 15, weight: .semibold, color: Assets.Colors.darkGray)
                                    Text(L10n.pressPlussButton)
                                        .textStyle(size: 14, weight: .regular, color: Assets.Colors.darkGray)
                                }
                                Spacer()
                            }
                        } else {
                            ForEach(Array(calendarStore.payments.enumerated()), id: \.element.id) { index, payment in
                                Menu {
                                    Button {
                                        calendarStore.send(CalendarAction.markPayment(index: index))
                                    } label: {
                                        Image(systemName: !payment.isPayedThisMonth ? "checkmark.circle" : "xmark.circle")
                                        Text(payment.isPayedThisMonth ? L10n.markAsNotPayed : L10n.markAsPayed)
                                    }
                                    Button {
                                        calendarStore.send(CalendarAction.viewDetails(index: index))
                                    } label: {
                                        Image(systemName: "eye")
                                        Text(L10n.viewDetails)
                                    }
                                    Button {
                                        calendarStore.send(CalendarAction.editPayment(index: index))
                                    } label: {
                                        Image(systemName: "pencil")
                                        Text(L10n.edit)
                                    }
                                } label: {
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
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        calendarStore.send(CalendarAction.removePayment(index: index))
                                    } label: {
                                        Text(L10n.delete)
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                    }
                    .onAppear {
                        calendarStore.send(CalendarAction.loadPayments)
                        print("Calendar unit month: \(NSCalendar.Unit.month)")
                    }
                    .halfSheet(showSheet: calendarStore.binding(get: { state in
                        state.selectedCalendarDate != nil
                    }, send: { _ in CalendarAction.calendarDateSelected(nil) })) {
                        DatePaymentsScreen(store: .init(initialState: DatePaymentsState(date: calendarStore.selectedCalendarDate ?? Date(),
                                                                                        payments: calendarStore.state.payments(on:
                                                                                                calendarStore.selectedCalendarDate ?? Date())),
                                                        reducer: datePaymentsReducer,
                                                        environment: DatePaymentsEnvironment()))
                    } onEnd: {
                        calendarStore.send(CalendarAction.calendarDateSelected(nil))
                    }
                    .sheet(isPresented: calendarStore.binding(get: { state in
                        state.showSettings
                    }, send: { state in
                        CalendarAction.toggleSettings
                    })) {
                        SettingsScreen(settingsStore: .init(initialState: SettingsState(), reducer: settingsReducer, environment: SettingsEnvironment()))
                    }
                    .sheet(isPresented: calendarStore.binding(get: { $0.showNewPayment }, send: {
                        _ in .closeAddNew
                    })) {
                        PaymentCreationScreen(paymentCreationStore:
                                .init(initialState: PaymentCreationState(payment: PersistenceClient.createEmptyPayment()),
                                      reducer: paymentCreationReducer,
                                      environment: PaymentCreationEnvironment(onDone: { calendarStore.send(CalendarAction.loadPayments)
                                        })))
                    }
                    .sheet(isPresented: calendarStore.binding(get: { $0.selectedEditPayment != nil }, send: { _ in .closeAddNew })) {
                        PaymentCreationScreen(paymentCreationStore:
                                .init(initialState: PaymentCreationState(payment: calendarStore.selectedEditPayment ?? .init(), isNew: false),
                                      reducer: paymentCreationReducer,
                                      environment: PaymentCreationEnvironment(onDone: { calendarStore.send(CalendarAction.loadPayments)
                                        })))
                    }
                    .sheet(isPresented: calendarStore.binding(get: { $0.selectedDetailsPayment != nil }, send: { _ in .viewDetails(index: -1) })) {
                        PaymentDetailsScreen(store: .init(initialState: PaymentDetailsState(payment: calendarStore.selectedDetailsPayment ?? .init()), reducer: paymentDetailsReducer, environment: PaymentDetailsEnvironment()))
                    }
                }
                .navigationTitle(L10n.calendar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            calendarStore.send(CalendarAction.toggleSettings)
                        } label: {
                            Label("Open Settings", systemImage: "gearshape")
                        }

                    }
                    ToolbarItem {
                        Button(action: {
                            calendarStore.send(CalendarAction.toggleAddNew)
                        }) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }

        }
        
    }
}

struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen(store: .init(initialState: CalendarState(), reducer: calendarReducer, environment: CalendarEnvironment()))
    }
}



