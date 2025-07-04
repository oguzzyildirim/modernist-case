//
//  UIApplication+Ext.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 2.07.2025.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}
