//
//  CardView.swift
//  LiquidCourage
//
//  Created by app-kaihatsusha on 13/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI


struct FrameReader: View {
    
    let coordinateSpace: CoordinateSpace
    let onChange: (_ frame: CGRect) -> Void
    
    init(coordinateSpace: CoordinateSpace, onChange: @escaping (_: CGRect) -> Void) {
        self.coordinateSpace = coordinateSpace
        self.onChange = onChange
    }
    
    var body: some View {
        GeometryReader { geo in
            Text("")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    onChange(geo.frame(in: coordinateSpace))
                }
                .onChange(of: geo.frame(in: coordinateSpace), {
                    onChange(geo.frame(in: coordinateSpace))
                })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension View {
    func readingFrame(coordinateSpace: CoordinateSpace = .global, onChange: @escaping (_: CGRect) -> ()) -> some View {
        background(FrameReader(coordinateSpace: coordinateSpace, onChange: onChange))
    }
}

struct CardView: View {
    
    var user: User = .mock
    var onSuperLikePressed: (() -> Void)? = nil
    var onXMarkPressed: (() -> Void)? = nil
    var onCheckMarkPressed: (() -> Void)? = nil
    var onSendAComplimentPressed: (() -> Void)? = nil
    var onHideAndReportPressed: (() -> Void)? = nil
    
    @State private var cardFrame: CGRect = .zero
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                headerCell
                    .frame(height: cardFrame.height)
                
                aboutMeSection
                    .padding(.vertical, 24)
                    .padding(.horizontal, 12)
                
                myInterestsSection
                    .padding(.horizontal, 12)
                    .padding(.bottom, 24)
                
                ForEach(user.images, id: \.self) { image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                }
                
                locationSection
                    .padding(.horizontal, 12)
                    .padding(.bottom, 24)
                
                footerSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                    .padding(.bottom, 60)
                
            }
        }
        .scrollIndicators(.hidden)
        .background(.backgroundYellow)
        .overlay (
            superLikeButton
                .padding(24)
                
            , alignment: .bottomTrailing
        )
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .readingFrame { frame in
            cardFrame = frame
        }
        
    }
    
    
    
    private func sectionTitle(title: String) -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.appGrey)
    }
    
    private var superLikeButton: some View {
        Image(systemName: "hexagon.fill")
            .foregroundStyle(.appYellow)
            .font(.system(size: 60))
            .overlay {
                Image(systemName: "star.fill")
                    .foregroundStyle(.appBlack)
                    .font(.system(size: 30, weight: .medium))
            }
            .onTapGesture {
                onSuperLikePressed?()
            }
    }
    
    private var footerSection: some View {
        VStack(spacing: 24.0) {
            HStack(spacing: 0.0){
                Circle()
                    .fill(.appYellow)
                    .overlay {
                        Image(systemName: "xmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onXMarkPressed?()
                    }
                Spacer(minLength: 0)
                Circle()
                    .fill(.appYellow)
                    .overlay {
                        Image(systemName: "checkmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onCheckMarkPressed?()
                    }
            }
            Text("Hide and Report")
                .font(.headline)
                .foregroundStyle(.appGrey)
                .padding(8)
                .background(.appBlack.opacity(0.001))
                .onTapGesture {
                    onHideAndReportPressed?()
                }
        }
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            HStack(spacing: 8.0) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s location'")
            }
            .foregroundStyle(.appGrey)
            .font(.body)
            .fontWeight(.medium)
            
            Text("10 miles away")
                .font(.headline)
                .foregroundStyle(.appBlack)
            
            PillView(iconName: nil, emoji: "🇬🇧", text: "Lives in England, UK")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var myInterestsSection: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            VStack(alignment: .leading, spacing: 8.0) {
                sectionTitle(title: "My Basics")
                PillGridView(interests: user.basics)
            }
            
            VStack(alignment: .leading, spacing: 8.0) {
                sectionTitle(title: "My Interests")
                PillGridView(interests: user.interests)
            }
        }
    }
    
    private var aboutMeSection: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            sectionTitle(title: "About Me")
            
            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.appBlack)
            
            HStack(spacing: 0.0) {
                HeartView()
                Text("Send a Compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding([.horizontal, .trailing], 8)
            .background(.appYellow)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .onTapGesture {
                onSendAComplimentPressed?()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    private var headerCell: some View {
        
        ZStack(alignment: .bottomLeading) {
            ImageLoaderView(urlString: user.image)
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing: 4.0) {
                    Image(systemName: "suitcase")
                    Text(user.work)
                }
                
                HStack(spacing: 4.0) {
                    Image(systemName: "graduationcap")
                    Text(user.education)
                }
                
                HeartView()
                    .onTapGesture {
                        
                    }
            }
            .padding(24)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.appWhite)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [
                        .appBlack.opacity(0),
                        .appBlack.opacity(0.6),
                        .appBlack.opacity(0.6),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
            
            
        }
    }
}

#Preview {
    CardView()
        .padding(.vertical, 40)
        .padding(.horizontal, 16)
}
