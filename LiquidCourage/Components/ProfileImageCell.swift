//
//  ProfileImageCell.swift
//  LiquidCourage
//
//  Created by app-kaihatsusha on 15/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct ProfileImageCell: View {
    
    var imageName: String = Constants.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    
    var body: some View {
        ZStack {
            
            Circle()
                .stroke(.appGrey, lineWidth: 2)
            Circle()
                .trim(from: 0, to: percentageRemaining)
                .stroke(.appYellow, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-90))
                .scaleEffect(x: -1, y: 1, anchor: .center)
            
            ImageLoaderView(urlString: imageName)
                .scaledToFill()
                .clipShape(Circle())
                .padding(5)
            
        }
        .frame(width: 75, height: 75)
        .overlay (
            ZStack {
                if hasNewMessage {
                    Circle()
                        .fill(.appWhite)
                    Circle()
                        .fill(.appYellow)
                        .padding(4)
                }
            }
            .frame(width: 24, height: 24)
            .offset(x: 2, y: 2)
            ,alignment: .bottomTrailing
        )
    }
}


#Preview {
    VStack {
        ProfileImageCell()
        ProfileImageCell(percentageRemaining: 1)
        ProfileImageCell(percentageRemaining: 0)
        ProfileImageCell(hasNewMessage: false)
    }
}

#Preview("fits", traits: .sizeThatFitsLayout) {
    ProfileImageCell()
}

#Preview("fixed", traits: .fixedLayout(width: 150, height: 150)) {
    ProfileImageCell()
}


