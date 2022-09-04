//
//  PaymentStore.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import Foundation
import ComposableArchitecture


struct PaymentState: Equatable, Identifiable {
    
    var id: String {
        self.payment.id ?? ""
    }
    
    var payment: Payment
    
}


enum PaymentAction: Equatable {
    
}


struct PaymentEnvironment {
    
}


let paymentReducer = Reducer<PaymentState, PaymentAction, PaymentEnvironment> { state, action, environment in
    switch action {
        
    }
}
