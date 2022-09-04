//
//  Collection + Extension.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 13.08.2022.
//

import Foundation

extension Collection {

    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
