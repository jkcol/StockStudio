import Foundation

class APIService {
    static let shared = APIService()
    
    // Change this to your backend URL later
    // For now, we'll use a local development server
    private let baseURL = "http://localhost:8000/api"
    
    private init() {}
    
    // MARK: - Stock Data
    
    func fetchStock(symbol: String) async throws -> Stock {
        let url = URL(string: "\(baseURL)/stocks/\(symbol)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Stock.self, from: data)
    }
    
    func fetchMultipleStocks(symbols: [String]) async throws -> [Stock] {
        let symbolsString = symbols.joined(separator: ",")
        let url = URL(string: "\(baseURL)/stocks?symbols=\(symbolsString)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Stock].self, from: data)
    }
    
    // MARK: - User & Portfolio
    
    func fetchUser(userId: Int) async throws -> User {
        let url = URL(string: "\(baseURL)/users/\(userId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        return try decoder.decode(User.self, from: data)
    }
    
    func fetchPortfolio(userId: Int) async throws -> [Portfolio] {
        let url = URL(string: "\(baseURL)/portfolio/\(userId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        return try decoder.decode([Portfolio].self, from: data)
    }
    
    // MARK: - Trading
    
    func executeTrade(userId: Int, symbol: String, quantity: Int, type: TransactionType) async throws -> Transaction {
        let url = URL(string: "\(baseURL)/trade")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "user_id": userId,
            "symbol": symbol,
            "quantity": quantity,
            "type": type.rawValue
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.tradeFailed
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Transaction.self, from: data)
    }
    
    // MARK: - AI Predictions
    
    func getAIPrediction(symbol: String) async throws -> AIPrediction {
        let url = URL(string: "\(baseURL)/ai/predict/\(symbol)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        return try decoder.decode(AIPrediction.self, from: data)
    }
}

enum APIError: Error {
    case invalidResponse
    case tradeFailed
    case networkError
}

struct AIPrediction: Codable {
    let symbol: String
    let predictedPrice: Double
    let confidence: Double
    let sentiment: String
    let recommendation: String
}
