//
//  UIView+Extensions.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 8/1/25.
//

import Foundation
import SwiftUI

extension View {

 func leftAligned() -> some View {
        return HStack{
            self
            Spacer()
        }
    }
}
