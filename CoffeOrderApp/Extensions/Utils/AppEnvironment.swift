//
//  AppEnvironment.swift
//  CoffeOrderApp
//
//  Created by Rezaul Karim on 7/1/25.
//

import Foundation


enum Endpoints{
    case allOrders
    
    var path : String {
        switch self {
            case .allOrders: return "/test/orders"
        }
    }
}

struct Configuration{
    lazy var  environment: AppEnvironment = {
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return .dev
        }
        if env == "TEST"{
            return AppEnvironment.test
        }
        return .dev
    }()
}

enum AppEnvironment : String{
    case dev
    case test
    
    var baseURL: URL{
        switch self{
        case .dev: return URL(string: "https://island-bramble.glitch.me")!
        case .test: return URL(string: "https://island-bramble.glitch.me")!
        }
    }
    
}
