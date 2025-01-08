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



struct AddOrder: View {
    
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
    
    
    var body: some View {
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
                Text("Small").tag(CoffeSize.medium)
                Text("Small").tag(CoffeSize.large)
            }.pickerStyle(.segmented)
            
            Spacer().frame(height: 20)
            
            Button("Add Order"){
                if isValid{
                    
                }
            }.buttonStyle(.bordered)
                .background(Color.blue)
                .foregroundStyle(.white)
                .cornerRadius(10)
            
           
            Spacer()
            
        }.padding(.horizontal, 20)
        
        
    }
}

#Preview {
    AddOrder()
}
