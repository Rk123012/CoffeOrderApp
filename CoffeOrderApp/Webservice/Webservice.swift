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
    
    func getOrders() async throws -> [Order]{
                
        guard let url = URL(string: "https://island-bramble.glitch.me/test/orders") else {
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
    
}
