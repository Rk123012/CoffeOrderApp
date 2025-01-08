//
//  AddOrder.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 8/1/25.
//

import SwiftUI


class AddOrderErrors{
    
     var name : String = ""
     var coffeeName : String = ""
     var total : String = ""
}



struct AddOrderView: View {
    @EnvironmentObject private var model : CoffeModel
    @Environment(\.dismiss) private var dismiss
    @State private var name : String = ""
    @State private var coffeeName : String = ""
    @State private var total : String = ""
    @State private var size : CoffeSize = .small
    @State private var errors : AddOrderErrors = AddOrderErrors()
    
    
    
    var isValid : Bool{
        errors = AddOrderErrors()
        
        if name.isEmpty{
            errors.name = "Name is required"
        }
        if coffeeName.isEmpty{
            errors.coffeeName = "Coffee Name is required"
        }
        if total.isEmpty{
            errors.total = "Total is required"
        }else if !total.isNumber{
            errors.total = "Total must be number"
        }else{
            if Double(total) ?? 0 < 1{
                errors.total = "Total must be greater than or equal to 1"
            }
        }
        
        return errors.name.isEmpty && errors.coffeeName.isEmpty && errors.total.isEmpty
    }
    
    
    private func placeOrder() async {
        let order = Order(name: name, coffeeName: coffeeName, total: Double(total) ?? 0, size: size)
        do{
            try await model.placeOrder(order: order)
            dismiss()
        }catch let error{
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack{
            
            VStack{
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text(errors.name)
                    .labelsVisibility(errors.name.isEmpty ? .hidden : .visible)
                    .foregroundStyle(.red)
                    .font(.caption)
                    .leftAligned()
                
                
                
                TextField("Coffee Name", text: $coffeeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(errors.coffeeName)
                    .labelsVisibility(errors.coffeeName.isEmpty ? .hidden : .visible)
                    .foregroundStyle(.red)
                    .font(.caption)
                    .leftAligned()
                
                
                
                
                TextField("Total", text: $total)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text(errors.total)
                    .labelsVisibility(errors.total.isEmpty ? .hidden : .visible)
                    .foregroundStyle(.red)
                    .font(.caption)
                    .leftAligned()
                
                
                
                Picker("Select Size", selection: $size){
                    Text("Small").tag(CoffeSize.small)
                    Text("Medium").tag(CoffeSize.medium)
                    Text("Large").tag(CoffeSize.large)
                }.pickerStyle(.segmented)
                
                Spacer().frame(height: 20)
                
                Button("Add Order"){
                    if isValid{
                        Task{
                            await placeOrder()
                        }
                    }
                }.buttonStyle(.bordered)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                
                
                Spacer()
                
            }.padding(.horizontal, 20)
                .navigationTitle("Add Order")
            
        }
    }
}

#Preview {
    AddOrderView()
}
