//
//  NumberFormatter+Extensions.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 7/1/25.
//

import Foundation

extension NumberFormatter{
    
    static var currency : NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "bn_BD")
        return formatter
    }
}
