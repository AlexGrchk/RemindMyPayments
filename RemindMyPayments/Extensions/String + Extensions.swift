//
//  String + Extensions.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import Foundation


extension String {
    
    var asStringOrNil: String? {
        return self.isEmpty ? nil : self
    }
    
}
