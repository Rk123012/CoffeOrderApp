//
//  Webservice.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 7/1/25.
//

import Foundation


enum NetworkError: Error {
    case badUrl
    case badRequest
    case decodingError
}

class Webservice {
    
    private var baseUrl : URL

    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func getOrders() async throws -> [Order]{
                
        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseUrl) else {
            throw NetworkError.badUrl
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)

        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else{
            throw NetworkError.decodingError
        }
        return orders
        
        
    }
    
    func placeOrder(order : Order) async throws -> Order{
        guard let url = URL(string: Endpoints.placeOrder.path, relativeTo: baseUrl) else {
            throw NetworkError.badUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let order = try? JSONDecoder().decode(Order.self, from: data) else{
            throw NetworkError.decodingError
        }
        return order
    }
    
    func deleteOrder(orderId : Int) async throws -> Order{
        guard let url = URL(string: Endpoints.deleteOrder(orderId).path, relativeTo: baseUrl) else {
            throw NetworkError.badUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let order = try? JSONDecoder().decode(Order.self, from: data) else{
            throw NetworkError.decodingError
        }
        return order
    }
    
    func updateOrder(order : Order) async throws -> Order{
        guard let orderId = order.id else {
            throw NetworkError.badRequest
        }
        guard let url = URL(string: Endpoints.updateOrder(orderId).path, relativeTo: baseUrl) else {
            throw NetworkError.badUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let updatedOrder = try? JSONDecoder().decode(Order.self, from: data) else{
            throw NetworkError.decodingError
        }
        return updatedOrder
    }
    
}
