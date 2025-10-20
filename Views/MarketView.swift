import SwiftUI

struct MarketView: View {
    @EnvironmentObject var appState: AppState
    @State private var stocks: [Stock] = []
    @State private var isLoading = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                if isLoading {
                    ProgressView()
                } else {
                    ForEach(stocks) { stock in
                        NavigationLink(destination: StockDetailView(stock: stock)) {
                            StockRowView(stock: stock)
                        }
                    }
                }
            }
            .navigationTitle("Market")
            .searchable(text: $searchText)
            .refreshable {
                await loadStocks()
            }
            .task {
                await loadStocks()
            }
        }
    }
    
    func loadStocks() async {
        isLoading = true
        do {
            stocks = try await APIService.shared.fetchMultipleStocks(symbols: appState.watchlist)
        } catch {
            print("Error loading stocks: \(error)")
        }
        isLoading = false
    }
}

struct StockRowView: View {
    let stock: Stock
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.symbol)
                    .font(.headline)
                Text(stock.name)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("$\(stock.currentPrice, specifier: "%.2f")")
                    .font(.headline)
                
                HStack(spacing: 4) {
                    Image(systemName: stock.isPositive ? "arrow.up.right" : "arrow.down.right")
                    Text("\(stock.changePercent, specifier: "%.2f")%")
                }
                .font(.caption)
                .foregroundColor(stock.isPositive ? .green : .red)
            }
        }
        .padding(.vertical, 4)
    }
}
