//
//  Currency.swift
//  PaymentsReminder
//
//  Created by Oleksandr on 21.07.2022.
//

import Foundation


enum Currency: String, CaseIterable {
    case usd
    case eur
    case jpy
    case gbp
    case aud
    case cad
    case chf
    case cny
    case hkd
    case nzd
    case sek
    case krw
    case sgd
    case nok
    case mxn
    case inr
    case rub
    case zar
    case tury
    case brl
    case twd
    case dkk
    case pln
    case thb
    case idr
    case huf
    case czk
    
    var name: String {
        switch self {
        case .usd:
            return L10n.usd
        case .eur:
            return L10n.eur
        case .jpy:
            return L10n.jpy
        case .gbp:
            return L10n.gbp
        case .aud:
            return L10n.aud
        case .cad:
            return L10n.cad
        case .chf:
            return L10n.chf
        case .cny:
            return L10n.cny
        case .hkd:
            return L10n.hkd
        case .nzd:
            return L10n.nzd
        case .sek:
            return L10n.sek
        case .krw:
            return L10n.krw
        case .sgd:
            return L10n.sgd
        case .nok:
            return L10n.nok
        case .mxn:
            return L10n.mxn
        case .inr:
            return L10n.inr
        case .rub:
            return L10n.rub
        case .zar:
            return L10n.zar
        case .tury:
            return L10n.try
        case .brl:
            return L10n.brl
        case .twd:
            return L10n.twd
        case .dkk:
            return L10n.dkk
        case .pln:
            return L10n.pln
        case .thb:
            return L10n.thb
        case .idr:
            return L10n.idr
        case .huf:
            return L10n.huf
        case .czk:
            return L10n.czk
        }
    }
    
    var symbol: String {
        switch self {
        case .usd:
            return "US$"
        case .eur:
            return "€"
        case .jpy:
            return "¥"
        case .gbp:
            return "£"
        case .aud:
            return "A$"
        case .cad:
            return "C$"
        case .chf:
            return "CHF"
        case .cny:
            return "元"
        case .hkd:
            return "HK$"
        case .nzd:
            return "NZ$"
        case .sek:
            return "kr"
        case .krw:
            return "₩"
        case .sgd:
            return "S$"
        case .nok:
            return "kr"
        case .mxn:
            return "$"
        case .inr:
            return "₹"
        case .rub:
            return "₽"
        case .zar:
            return "R"
        case .tury:
            return "₺"
        case .brl:
            return "R$"
        case .twd:
            return "NT$"
        case .dkk:
            return "kr"
        case .pln:
            return "zł"
        case .thb:
            return "฿"
        case .idr:
            return "Rp"
        case .huf:
            return "Ft"
        case .czk:
            return "Kč"
        }
    }
    
    
}
