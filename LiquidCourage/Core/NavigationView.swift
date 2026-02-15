//
//  NavigationView.swift
//  LiquidCourage
//
//  Created by app-kaihatsusha on 15/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI


struct NavigationView: View {
    
    @State private var filters: [String] = ["Everyone", "Trending"]
    @AppStorage("home_filter") private var selectedFilter = "Everyone"
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color.appWhite
                    .ignoresSafeArea()
                
                VStack(spacing: 12.0) {
                    header
                    
                    FilterView(options: filters, selection: $selectedFilter)
                        .background( Divider(), alignment: .bottom )
                    
                    switch(selectedFilter) {
                    case "Everyone":
                        HomeView()
                    case "Trending":
                        ChatsView()
                    default:
                        HomeView()
                    }
                }
                .padding(8)
                .animation(.snappy, value: selectedFilter)
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
    }
    
    private var header: some View {
        HStack(spacing: 0.0) {
            HStack(spacing: 0.0) {
                Image(systemName: "line.horizontal.3")
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Text("LiquidCourage")
                .font(.title)
                .foregroundStyle(.appYellow)
                .frame(maxWidth: .infinity, alignment: .center)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            
            
            Image(systemName: "slider.horizontal.3")
                .background(.black.opacity(0.001))
                .onTapGesture {
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.appBlack)
    }
}

#Preview {
    NavigationView()
}
