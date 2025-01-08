//
//  String+Extensions.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 8/1/25.
//

import Foundation

extension String {
    var isNumber : Bool {
        return Double(self) != nil
    }
}
