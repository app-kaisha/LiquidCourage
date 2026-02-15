//
//  PillView.swift
//  LiquidCourage
//
//  Created by app-kaihatsusha on 15/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct PillView: View {
    
    var iconName: String? = "heart.fill"
    var emoji: String? = "🤙"
    var text: String = "Graduate Degree"
    
    var body: some View {
        HStack(spacing: 4.0) {
            if let iconName {
                Image(systemName: iconName)
            } else if let emoji {
                Text(emoji)
            }
            
            Text(text)
        }
        .font(.callout)
        .fontWeight(.medium)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .foregroundStyle(.appBlack)
        .background(.appLightYellow)
        .clipShape(RoundedRectangle(cornerRadius: 32))
    }
}

#Preview {
    VStack {
        PillView(iconName: "nil")
        PillView(iconName: "book", text: "Librarian")
        PillView(iconName: "wineglass", text: "Social")
    }
}
