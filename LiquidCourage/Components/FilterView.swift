//
//  FilterView.swift
//  LiquidCourage
//
//  Created by app-kaihatsusha on 13/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    
    var options: [String] = ["Everyone", "Trending"]
    
    @Binding var selection: String
    @Namespace private var namespace
    
    var body: some View {
        HStack(alignment: .top, spacing: 32.0) {
            ForEach(options, id: \.self) { option in
                VStack(spacing: 8.0) {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    if selection == option {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                    }
                    
                }
                .padding(.top, 8)
                .background(.black.opacity(0.001))
                .foregroundStyle(selection == option ? .appBlack: .appGrey)
                .onTapGesture {
                    selection = option
                }
            }
        }
        .animation(.smooth, value: selection)
    }
}

fileprivate struct FilterViewPreview: View {
    
    var options: [String] = ["Everyone", "Trending"]
    @State private var selection = "Everyone"
    
    var body: some View {
        FilterView(options: options, selection: $selection)
    }
}

#Preview {
    FilterViewPreview()
        .padding()
}
