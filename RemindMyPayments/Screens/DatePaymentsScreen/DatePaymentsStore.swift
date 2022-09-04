//
//  DatePaymentsStore.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import Foundation
import ComposableArchitecture


struct DatePaymentsState: Equatable {
    
    var date: Date
    var payments: [Payment]
    
}



enum DatePaymentsAction {
    
}

struct DatePaymentsEnvironment {
    
}

let datePaymentsReducer = Reducer<DatePaymentsState, DatePaymentsAction, DatePaymentsEnvironment> { state, action, environment in
    switch action {
        
    }
}
