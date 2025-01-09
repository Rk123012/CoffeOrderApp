//
//  OrderCellView.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 7/1/25.
//

import SwiftUI

struct OrderCellView: View {
    let order: Order
    var body: some View {
        HStack{
            
            VStack(alignment: .leading){
                Text("\(order.id ?? 0). \(order.name)").accessibilityIdentifier("orderNameText")
                    .bold()

                Text("\(order.coffeeName) (\(order.size.rawValue))").accessibilityIdentifier("orderCoffeeNameAndSizeText")
                    .opacity(0.5)
                    
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .accessibilityIdentifier("coffeePriceText")
        }
    }
}

#Preview {
    OrderCellView(order: Order(name: "jds", coffeeName: "dasd", total: 22.0, size: .large))
}
