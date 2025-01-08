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
      
    var body: some View {
        NavigationStack{
            ZStack{
                VStack {
                    if model.orders.isEmpty{
                        Text("No Orders available!").accessibilityIdentifier("noOrdersText")
                    }
                    List(model.orders){ order in
                        OrderCellView(order: order)
                    }.listStyle(.plain)
                
                }.task {
                    isLoading = true
                    await populateOrders()
                    isLoading = false
                }
                .sheet(isPresented: $isPresented, content: {
                    AddOrder()
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add new Order"){
                            isPresented = true
                        }
                    }
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

