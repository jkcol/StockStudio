//
//  StockDetailView.swift
//  StockStudio
//

import SwiftUI

struct StockDetailView: View {
    let stock: Stock
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading) {
                    Text(stock.symbol)
                        .font(.title)
                        .bold()
                    Text(stock.name)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                // Price Info
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Current Price")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("$\(stock.currentPrice, specifier: "%.2f")")
                            .font(.title2)
                            .bold()
                    }
                    
                    HStack {
                        Text("Change")
                            .foregroundColor(.secondary)
                        Spacer()
                        HStack(spacing: 4) {
                            Image(systemName: stock.isPositive ? "arrow.up.right" : "arrow.down.right")
                            Text("$\(stock.change, specifier: "%.2f") (\(stock.changePercent, specifier: "%.2f")%)")
                        }
                        .foregroundColor(stock.isPositive ? .green : .red)
                    }
                    
                    HStack {
                        Text("Previous Close")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("$\(stock.previousClose, specifier: "%.2f")")
                    }
                    
                    HStack {
                        Text("Volume")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(stock.volume)")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Buy/Sell Buttons
                HStack(spacing: 15) {
                    Button(action: {
                        // Buy action - we'll implement later
                    }) {
                        Text("Buy")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        // Sell action - we'll implement later
                    }) {
                        Text("Sell")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationTitle(stock.symbol)
        .navigationBarTitleDisplayMode(.inline)
    }
}
