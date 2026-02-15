//
//  HeartView.swift
//  LiquidCourage
//
//  Created by app-kaihatsusha on 13/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct HeartView: View {
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.appYellow)
                .frame(width: 40, height: 40)
            
            Image(systemName: "bubble.fill")
                .foregroundStyle(.appBlack)
                .font(.system(size: 22))
                .offset(y: 2)
            
            Image(systemName: "heart.fill")
                .foregroundStyle(.appYellow)
                .font(.system(size: 10))
        }
        .onTapGesture {
            
        }
    }
}

#Preview {
    HeartView()
}
