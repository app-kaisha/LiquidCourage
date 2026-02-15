//
//  ChatPreviewCell.swift
//  LiquidCourage
//
//  Created by app-kaihatsusha on 15/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct ChatPreviewCell: View {
    
    var imageName: String = Constants.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = false
    var user: User = User.mock
    var lastChatMessage: String? = "This is the last message and it might extend to mulitple lines."
    var isYourMove: Bool = true
    
    var body: some View {
        HStack(spacing: 15.0) {
            
            ProfileImageCell(
                imageName: imageName,
                percentageRemaining: percentageRemaining,
                hasNewMessage: hasNewMessage
            )
            
            VStack(alignment: .leading, spacing: 2.0) {
                HStack(alignment: .bottom, spacing: 0.0) {
                    Text(user.firstName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    if isYourMove {
                        Text("YOUR MOVE")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundStyle(.appBlack)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background {
                                Capsule()
                                    .fill(.appYellow.gradient)
                            }
                    }
                }
                if let lastChatMessage {
                    Text(lastChatMessage)
                        .font(.subheadline)
                        .foregroundStyle(.appGrey)
                        .lineLimit(1)
                        .padding(.trailing, 16)
                }
            }
        }
    }
}

#Preview {
    VStack {
        
        ChatPreviewCell()
        ChatPreviewCell()
        ChatPreviewCell(isYourMove: false)
        ChatPreviewCell()
    }
    .padding(.horizontal, 10)
}
