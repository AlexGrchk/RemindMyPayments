// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// ago
  public static let ago = L10n.tr("Localizable", "ago")
  /// Amount
  public static let amount = L10n.tr("Localizable", "amount")
  /// Australian dollar
  public static let aud = L10n.tr("Localizable", "aud")
  /// Bank account name
  public static let bankAccountName = L10n.tr("Localizable", "bankAccountName")
  /// Base currency
  public static let baseCurrency = L10n.tr("Localizable", "baseCurrency")
  /// Brazilian real
  public static let brl = L10n.tr("Localizable", "brl")
  /// Canadian dollar
  public static let cad = L10n.tr("Localizable", "cad")
  /// Calendar
  public static let calendar = L10n.tr("Localizable", "calendar")
  /// Cancel
  public static let cancel = L10n.tr("Localizable", "cancel")
  /// Swiss franc
  public static let chf = L10n.tr("Localizable", "chf")
  /// Close
  public static let close = L10n.tr("Localizable", "close")
  /// Renminbi
  public static let cny = L10n.tr("Localizable", "cny")
  /// Create
  public static let create = L10n.tr("Localizable", "create")
  /// Custom
  public static let custom = L10n.tr("Localizable", "custom")
  /// Czech koruna
  public static let czk = L10n.tr("Localizable", "czk")
  /// Date
  public static let date = L10n.tr("Localizable", "date")
  /// Day
  public static let day = L10n.tr("Localizable", "day")
  /// Days
  public static let days = L10n.tr("Localizable", "days")
  /// Delete
  public static let delete = L10n.tr("Localizable", "delete")
  /// Description
  public static let description = L10n.tr("Localizable", "description")
  /// Danish krone
  public static let dkk = L10n.tr("Localizable", "dkk")
  /// Done
  public static let done = L10n.tr("Localizable", "done")
  /// Don't forget to pay!
  public static let dontForgetToPay = L10n.tr("Localizable", "dontForgetToPay")
  /// Edit
  public static let edit = L10n.tr("Localizable", "edit")
  /// Euro
  public static let eur = L10n.tr("Localizable", "eur")
  /// Every [day] of month
  public static let everyDayOfMonth = L10n.tr("Localizable", "everyDayOfMonth")
  /// First day of month
  public static let firstDayOfMonth = L10n.tr("Localizable", "firstDayOfMonth")
  /// Sterling
  public static let gbp = L10n.tr("Localizable", "gbp")
  /// History
  public static let history = L10n.tr("Localizable", "history")
  /// Hong Kong dollar
  public static let hkd = L10n.tr("Localizable", "hkd")
  /// Hungarian forint
  public static let huf = L10n.tr("Localizable", "huf")
  /// Indonesian rupiah
  public static let idr = L10n.tr("Localizable", "idr")
  /// Indian rupee
  public static let inr = L10n.tr("Localizable", "inr")
  /// Japanese yen
  public static let jpy = L10n.tr("Localizable", "jpy")
  /// South Korean won
  public static let krw = L10n.tr("Localizable", "krw")
  /// Last day of month
  public static let lastDayOfMonth = L10n.tr("Localizable", "lastDayOfMonth")
  /// left
  public static let `left` = L10n.tr("Localizable", "left")
  /// Main
  public static let main = L10n.tr("Localizable", "main")
  /// Mark as not payed
  public static let markAsNotPayed = L10n.tr("Localizable", "markAsNotPayed")
  /// Mark as payed
  public static let markAsPayed = L10n.tr("Localizable", "markAsPayed")
  /// Mexican peso
  public static let mxn = L10n.tr("Localizable", "mxn")
  /// New payment
  public static let newPayment = L10n.tr("Localizable", "newPayment")
  /// Norwegian krone
  public static let nok = L10n.tr("Localizable", "nok")
  /// Not payed
  public static let notPayed = L10n.tr("Localizable", "notPayed")
  /// New Zealand dollar
  public static let nzd = L10n.tr("Localizable", "nzd")
  /// Payed on
  public static let payedOn = L10n.tr("Localizable", "payedOn")
  /// Payment details
  public static let paymentDetails = L10n.tr("Localizable", "paymentDetails")
  /// Please select day of month
  public static let pleaseSelectDayOfMonth = L10n.tr("Localizable", "pleaseSelectDayOfMonth")
  /// Polish zloty
  public static let pln = L10n.tr("Localizable", "pln")
  /// Hit + button to add new payment
  public static let pressPlussButton = L10n.tr("Localizable", "pressPlussButton")
  /// Russian ruble
  public static let rub = L10n.tr("Localizable", "rub")
  /// Swedish krona
  public static let sek = L10n.tr("Localizable", "sek")
  /// Settings
  public static let settings = L10n.tr("Localizable", "settings")
  /// Singapore dollar
  public static let sgd = L10n.tr("Localizable", "sgd")
  /// Test
  public static let test = L10n.tr("Localizable", "test")
  /// Thai baht
  public static let thb = L10n.tr("Localizable", "thb")
  /// Today
  public static let today = L10n.tr("Localizable", "today")
  /// Tomorrow
  public static let tomorrow = L10n.tr("Localizable", "tomorrow")
  /// Turkish lira
  public static let `try` = L10n.tr("Localizable", "try")
  /// New Taiwan dollar
  public static let twd = L10n.tr("Localizable", "twd")
  /// United States Dollar
  public static let usd = L10n.tr("Localizable", "usd")
  /// Value is required
  public static let valueIsRequired = L10n.tr("Localizable", "valueIsRequired")
  /// View details
  public static let viewDetails = L10n.tr("Localizable", "viewDetails")
  /// You don't have payments
  public static let youDontHavePayments = L10n.tr("Localizable", "youDontHavePayments")
  /// South African rand
  public static let zar = L10n.tr("Localizable", "zar")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
