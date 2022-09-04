//
//  SettingsScreen.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import SwiftUI
import ComposableArchitecture

struct SettingsScreen: View {
    
    let settingsStore: Store<SettingsState, SettingsAction>
    
    var body: some View {
        NavigationView {
            WithViewStore(self.settingsStore) { settingsStore in
                List {
                    Menu {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Button {
                                settingsStore.send(SettingsAction.saveDefaultCurrency(currency))
                            } label: {
                                Text(currency.name)
                            }
                        }
                    } label: {
                        HStack {
                            Text(L10n.baseCurrency)
                                .textStyle(size: 14, weight: .regular, color: Assets.Colors.darkGray)
                            Spacer()
                            Text(settingsStore.defaultCurrency.symbol)
                                .textStyle(size: 13, weight: .regular, color: Assets.Colors.darkGray)
                        }
                    }
                }
                .onAppear {
                    settingsStore.send(SettingsAction.loadDefaultCurrency)
                }
            }
            .navigationTitle(L10n.settings)
            
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen(settingsStore: .init(initialState: .init(), reducer: settingsReducer, environment: .init()))
    }
}
