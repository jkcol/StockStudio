//
//  ContentView.swift
//  StockStudio
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Market")
                .tabItem {
                    Label("Market", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            Text("Portfolio")
                .tabItem {
                    Label("Portfolio", systemImage: "briefcase")
                }
            
            Text("Simulate")
                .tabItem {
                    Label("Simulate", systemImage: "play.circle")
                }
            
            Text("AI")
                .tabItem {
                    Label("AI", systemImage: "brain")
                }
        }
    }
}

#Preview {
    ContentView()
}
