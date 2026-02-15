//
//  PillGridView.swift
//  LiquidCourage
//
//  Created by app-kaihatsusha on 15/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI


struct UserInterest: Identifiable, Hashable {
    let id = UUID().uuidString
    var iconNme: String? = nil
    var emoji: String? = nil
    var text: String
}

struct PillGridView: View {
    
    var interests: [UserInterest] = User.mock.basics
    
    var body: some View {
        VStack(spacing: 8.0) {
            PillLayout(alignment: .leading, spacing: 8) {
                ForEach(interests, id:\.self) { interest in
                    PillView(
                        iconName: interest.iconNme,
                        emoji: interest.emoji,
                        text: interest.text
                    )
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 20.0) {
        PillGridView(interests: User.mock.basics)
        PillGridView(interests: User.mock.noInterests)
        PillGridView(interests: User.mock.interests)
        PillGridView(interests: User.mock.basics)
        
    }
}
