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
    @State private var isPresented : Bool = false
    
    func populateOrders() async{
        do{
            try await model.populateOrders()
        }catch let error{
            print(error)
        }
    }
    
    private func deleteOrder(_ indexSet : IndexSet) {
        indexSet.forEach { index in
            let order = model.orders[index]
            guard let orderId = order.id else { return }
            Task {
                do{
                    try await model.deleteOrder(orderId: orderId)
                }catch let error{
                    print(error)
                }  
            }
            
        }
    }
      
    var body: some View {
        NavigationStack{
            ZStack{
                VStack {
                    if model.orders.isEmpty{
                        Text("No Orders available!").accessibilityIdentifier("noOrdersText")
                    }
                
                    List{
                        ForEach(model.orders){ order in
                            ZStack{
                                OrderCellView(order: order)
                                NavigationLink(value: order.id){
                                }.opacity(0.0)
                            }
                            
                        }.onDelete(perform: deleteOrder)
                    }.listStyle(.plain)
                
                }.task {
                    isLoading = true
                    await populateOrders()
                    isLoading = false
                }
                .sheet(isPresented: $isPresented, content: {
                    AddOrderView()
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add new Order"){
                            isPresented = true
                        }
                    }
                }
                .navigationDestination(for: Int.self) { orderId in
                    OrderDetailsView(orderId: orderId)
                }
                if isLoading{
                    ProgressView()
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    var config = Configuration()  
    ContentView().environmentObject(CoffeModel(webservice: Webservice(baseUrl: config.environment.baseURL)))
}

