//
//  PaymentDetailsStore.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import Foundation
import ComposableArchitecture



struct PaymentDetailsState: Equatable {
    
    var payment: Payment
    
}


enum PaymentDetailsAction {
    
}

struct PaymentDetailsEnvironment {
    
}


let paymentDetailsReducer = Reducer<PaymentDetailsState, PaymentDetailsAction, PaymentDetailsEnvironment> { state, action, environment in
    switch action {
        
    }
}
