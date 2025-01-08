//
//  ContentView.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 7/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var model : CoffeModel
    @State private var isLoading  : Bool = false
    
    
    func populateOrders() async{
        do{
            try await model.populateOrders()
        }catch let error{
            print(error)
        }
    }
    
    func placeOrder() async{
        do{
            let order = Order(name: "jony", coffeeName: "suo", total: 12.0, size: .large)
            try await model.placeOrder(order: order)
        }catch let error{
            print(error)     
        }
    }
      
    var body: some View {
        ZStack{
            VStack {
                if model.orders.isEmpty{
                    Text("No Orders available!").accessibilityIdentifier("noOrdersText")
                }
                List(model.orders){ order in
                    OrderCellView(order: order)
                }.task {
                    isLoading = true
                    await populateOrders()
                    isLoading = false
                }.listStyle(.plain)
            
            }
            if isLoading{ 
                ProgressView()
            }  
        }.task {
            await placeOrder()
        }
        
        .padding()
    }
}

#Preview {
    var config = Configuration()
    ContentView().environmentObject(CoffeModel(webservice: Webservice(baseUrl: config.environment.baseURL)))
}

