//
//  CoffeModel.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 7/1/25.
//

import Foundation

@MainActor
class CoffeModel: ObservableObject {
    
    let webservice : Webservice
    @Published private(set) var orders: [Order] = []
    
    init(webservice: Webservice) {
        self.webservice = webservice
    }
    
    
    func populateOrders() async throws {
        orders = try await webservice.getOrders()
    }
    
}
