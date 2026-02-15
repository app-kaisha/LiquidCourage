//
//  PillSelector.swift
//  LiquidCourage
//
//  Created by app-kaihatsusha on 15/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct PillSelector: View {
    
    @State private var tags: [String] = ["SiwftUI", "Swift", "Apple", "XCode", "App", "Flutter", "iPhone", "iPadOS", "macOS", "Macbook", "C", "C++"]
    
    @State private var selectedTags: [String] = []
    
    // Add matchecGeometry for selection of pill
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 0.0) {
            ScrollView(.horizontal) {
                HStack(spacing: 12.0) {
                    ForEach(selectedTags, id:\.self) { tag in
                        TagView(tag, .appGrey, "checkmark")
                            .matchedGeometryEffect(id: tag, in: animation)
                        // remove from selected list
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    selectedTags.removeAll(where: { $0 == tag })
                                }
                            }
                    }
                }
                .padding(.horizontal, 15)
                .frame(height: 35)
                .padding(.vertical, 15)
            }
            .scrollClipDisabled(true)
            .scrollIndicators(.hidden)
            .overlay(content: {
                if selectedTags.isEmpty {
                    Text("Select more than 3 tags.")
                        .font(.callout)
                        .foregroundStyle(.appGrey)
                }
            })
            .background(.appWhite)
            .zIndex(1)
            
            ScrollView(.vertical) {
                PillLayout(alignment: .leading, spacing: 10) {
                    ForEach(tags.filter { !selectedTags.contains($0) }, id:\.self) { tag in
                        TagView(tag, .appYellow, "plus")
                            .matchedGeometryEffect(id: tag, in: animation)
                            .onTapGesture {
                                // add to selection
                                withAnimation(.snappy) {
                                    selectedTags.insert(tag, at: 0)
                                }
                            }
                    }
                }
                .padding(15)
            }
            .scrollClipDisabled(true)
            .scrollIndicators(.hidden)
            .background(.appBlack.opacity(0.05))
            .zIndex(0)
            
            ZStack {
                Button(action: {}) {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.appWhite)
                        .background {
                            Capsule()
                                .fill(.appYellow.gradient)
                        }
                }
                .disabled(selectedTags.count < 3)
                .opacity(selectedTags.count < 3 ? 0.5: 1)
                .padding()
            }
            .background(.appWhite)
            .zIndex(2)
        }
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    func TagView(_ tag: String, _ colour: Color, _ icon: String) -> some View {
        HStack(spacing: 10.0){
            Text(tag)
                .font(.callout)
                .fontWeight(.semibold)
            
            Image(systemName: icon)
        }
        .frame(height: 35)
        .foregroundStyle(.appWhite)
        .padding(.horizontal, 15)
        .background {
            Capsule()
                .fill(colour.gradient)
        }
    }
}

#Preview {
    PillSelector()
}
