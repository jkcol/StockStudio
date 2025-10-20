//
//  Stock.swift
//  StockStudio
//

import Foundation

struct Stock: Codable, Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let currentPrice: Double
    let previousClose: Double
    let change: Double
    let changePercent: Double
    let volume: Int64
    let marketCap: Double?
    
    var isPositive: Bool {
        change >= 0
    }
    
    enum CodingKeys: String, CodingKey {
        case symbol, name
        case currentPrice = "current_price"
        case previousClose = "previous_close"
        case change
        case changePercent = "change_percent"
        case volume
        case marketCap = "market_cap"
    }
}

struct Portfolio: Codable, Identifiable {
    let id: Int
    let userId: Int
    let symbol: String
    var quantity: Int
    let avgCost: Double
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, quantity#imageLiteral(resourceName: "Screenshot 2025-10-19 at 7.20.07 PM.png")
        case userId = "user_id"
        case avgCost = "avg_cost"
    }
}

struct User: Codable {
    let id: Int
    let username: String
    var cashBalance: Double
    
    enum CodingKeys: String, CodingKey {
        case id, username
        case cashBalance = "cash_balance"
    }
}
