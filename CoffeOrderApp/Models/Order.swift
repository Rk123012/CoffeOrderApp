//
//  Order.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 7/1/25.
//


enum CoffeSize : String, Codable, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Order : Codable, Identifiable, Hashable {
    var id : Int?
    var name : String
    var coffeeName : String
    var total : Double
    var size : CoffeSize
}
