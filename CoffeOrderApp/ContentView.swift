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
    
    var body: some View {
        ZStack{
            VStack {
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
        }
        
        .padding()
    }
}

#Preview {
    ContentView().environmentObject(CoffeModel(webservice: Webservice()))
}

