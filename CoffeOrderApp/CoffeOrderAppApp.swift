//
//  CoffeOrderAppApp.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 7/1/25.
//

import SwiftUI

@main
struct CoffeOrderAppApp: App {
    
    @StateObject private var model : CoffeModel
    
    init() {
        let webservice = Webservice()
        _model = StateObject(wrappedValue: CoffeModel(webservice: webservice))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
