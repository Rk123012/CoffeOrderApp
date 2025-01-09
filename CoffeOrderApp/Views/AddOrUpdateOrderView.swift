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



struct AddOrUpdateOrderView: View {
    @EnvironmentObject private var model : CoffeModel
    @Environment(\.dismiss) private var dismiss
    
    var orderId : Int? = nil
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
    
    func mapPreviousOrder(){
        if let id = orderId, let order = model.getOrder(orderId: id){
            self.name = order.name
            self.coffeeName = order.coffeeName
            self.total = String(order.total)
            self.size = order.size
        }
    }
    
    func saveOrUpdateOrder() async{
        if let _ = orderId{
            await updateOrder()
        }else{
            await placeOrder()
        }
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
    
    private func updateOrder() async{
        let editedOrder = Order(id: orderId ?? 0, name: name, coffeeName: coffeeName, total: Double(total) ?? 0, size: size)
        do{
            try await model.updateOrder(order: editedOrder)
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
                
                Button(orderId == nil ? "Add Order" : "Update Order"){
                    if isValid{
                        Task{
                            await saveOrUpdateOrder()
                        }
                    }
                }.buttonStyle(.bordered)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                
                
                Spacer()
                
            }.padding(.horizontal, 20)
                .navigationTitle(orderId != nil ? "Update Order" : "Add Order")
                .onAppear{
                    if let _ = orderId{
                        mapPreviousOrder()
                    }
                }
            
        }
    }
}

#Preview {
    AddOrUpdateOrderView()
}
