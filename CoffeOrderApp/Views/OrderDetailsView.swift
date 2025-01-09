//
//  OrderDetailsView.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 9/1/25.
//

import SwiftUI

struct OrderDetailsView: View {
    
    
    @EnvironmentObject private var coffeModel : CoffeModel
    
    let orderId : Int
    
    @Environment(\.dismiss) private var dismiss
    
    private func deleteOrder() async {
        do{
            try await coffeModel.deleteOrder(orderId: orderId)
        }catch let error{
            print(error)
        }
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            if let order = coffeModel.getOrder(orderId: orderId) {
                Text("Order Name : \(order.name)")
                    .font(.headline)
                
                Text("Order Id : \(orderId)")
                    
                
                Text("total : \(order.total)")
                
                Button("Delete", role: .destructive) {
                    Task {
                        await deleteOrder()
                        dismiss()
                    }
                }
                    
                
                Spacer()
            }
        }.leftAligned()
            .padding(.leading, 20)
    }
}

#Preview {
    var config = Configuration()
    OrderDetailsView(orderId: 3).environmentObject(CoffeModel(webservice: Webservice(baseUrl: config.environment.baseURL)))
}
