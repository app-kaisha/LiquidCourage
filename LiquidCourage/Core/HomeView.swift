//
//  HomeView.swift
//  LiquidCourage
//
//  Created by app-kaihatsusha on 13/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State private var filters: [String] = ["Everyone", "Trending"]
    @AppStorage("home_filter") private var selectedFilter = "Everyone"
    
    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = 0
    @State private var currentSwipeOffset: CGFloat = 0
    @State private var cardOffsets: [Int : Bool] = [:] // userid : direction right = true
    
    var body: some View {
        ZStack {
            Color.appWhite
                .ignoresSafeArea()
            
            VStack(spacing: 12.0) {
                header
                
                FilterView(options: filters, selection: $selectedFilter)
                    .background(
                        Divider(), alignment: .bottom
                    )
                
                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in
                            
                            let isPrevious = (selectedIndex - 1) == index
                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index
                            
                            if isPrevious || isCurrent || isNext{
                                
                                let offsetValue = cardOffsets[user.id]
                                userProfileCell(user: user, index: index)
                                    .zIndex(Double(allUsers.count - index))
                                    .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                    
                    overlaySwipingIndictors
                        .zIndex(999)
                }
                .frame(maxHeight: .infinity)
                .padding(4)
                .animation(.smooth,value: cardOffsets)
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        
        guard allUsers.isEmpty else { return }
        
        do {
            allUsers = try await DatabaseHelper().getUsers()
        } catch {
            
        }
    }
    
    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUsers[index]
        cardOffsets[user.id] = isLike
        
        selectedIndex += 1
    }
    
    private func userProfileCell(user: User, index: Int) -> some View {
        
        CardView(
            user: user,
            onSuperLikePressed: nil,
            onXMarkPressed: { userDidSelect(index: index, isLike: false) },
            onCheckMarkPressed: { userDidSelect(index: index, isLike: true) },
            onSendAComplimentPressed: nil,
            onHideAndReportPressed: nil
        )
        .withDragGesture(
            .horizontal,
            minimumDistance: 50,
            resets: true,
            rotationMultiplier: 1.05,
            scaleMultiplier: 0.5,
            onChanged: { dragOffset in
                currentSwipeOffset = dragOffset.width
            },
            onEnded: { dragOffset in
                if dragOffset.width < -200 {
                    userDidSelect(index: index, isLike: false)
                } else if dragOffset.width > 200 {
                    userDidSelect(index: index, isLike: true)
                }
                
            }
        )
    }
    
    private var overlaySwipingIndictors: some View {
        
        ZStack {
            Circle()
                .fill(.appGrey.opacity(0.4))
                .overlay {
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: min(-currentSwipeOffset, 150))
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Circle()
                .fill(.appGrey.opacity(0.4))
                .overlay {
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: max(-currentSwipeOffset, -150))
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
        .animation(.smooth,value: currentSwipeOffset)
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
    HomeView()
}
