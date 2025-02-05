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
    func placeOrder(order : Order) async throws {
        let placedOrder = try await webservice.placeOrder(order: order)
        if placedOrder.id != nil {
            orders.append(placedOrder)
        }
    }
    
    func deleteOrder(orderId : Int) async throws {
        let deletedOrder = try await webservice.deleteOrder(orderId: orderId)
        orders = orders.filter({$0.id != deletedOrder.id})
    }
    
    func updateOrder(order : Order) async throws {
        let updatedOrder = try await webservice.updateOrder(order: order)
        orders = orders.map({order.id == $0.id ? updatedOrder : $0})
    }
    
    func getOrder(orderId : Int) -> Order? {
        guard let order = orders.first(where: {$0.id == orderId}) else  {
            return nil
        }
        return order
    }
}
