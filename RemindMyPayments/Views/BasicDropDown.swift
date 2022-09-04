//
//  BasicDropDown.swift
//  PaymentsReminder
//
//  Created by Oleksandr on 20.07.2022.
//

import SwiftUI

struct BasicDropDown<Data, ID, Element, MenuView, Value>: View where Data: RandomAccessCollection, ID:Hashable, Element: Equatable, MenuView: View, Value: DropDownValue, Data.Index == Int, Data.Element == Element {
    
    var title: String
    @Binding var value: Value
    var data: [Element]
    var id: KeyPath<Element, ID>
    var content: (Element) -> MenuView
    
    init(title: String, value: Binding<Value>, data: Data, id: KeyPath<Element, ID>, @ViewBuilder content: @escaping (Element) -> MenuView) {
        self.data = Array(data)
        self.id = id
        self.content = content
        self.title = title
        self._value = value
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.title)
                .textStyle(size: 11, weight: .regular, color: Assets.Colors.primary)
            Menu {
                ForEach(self.data, id: self.id) { item in
                    self.content(item)
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Assets.Colors.palePrimary)
                    HStack {
                        Text(self.value.dropDownValue)
                            .textStyle(size: 14, weight: .regular, color: Assets.Colors.darkGray)
                        Spacer()
                        Assets.Images.arrowDown
                            .resizable()
                            .scaledToFill()
                            .frame(width: 12, height: 12)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                }
                .frame(height: 36)
            }

            
        }
    }
    
}

extension UIImage {
    
    var toSuiImage: Image {
        Image(uiImage: self)
    }
    
}

public protocol DropDownValue {
    var dropDownValue: String { get }
}
