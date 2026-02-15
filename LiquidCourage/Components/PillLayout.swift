//
//  PillLayout.swift
//  LiquidCourage
//
//  Created by app-kaihatsusha on 15/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct PillLayout: Layout {
    
    var alignment: Alignment = .leading
    var spacing: CGFloat = 10
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        
        let maxWidth = proposal.width ?? 0
        var height: CGFloat = 0
        let rows = makeRows(maxWidth, proposal, subviews)
        
        for (index, row) in rows.enumerated() {
            // find maxHeight in each row and add to view total height
            if index == (rows.count - 1) {
                // last row needs no spacing
                height += row.maxHeight(proposal)
            } else {
                height += row.maxHeight(proposal) + spacing
            }
            
        }
        
        return .init(width: maxWidth, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // place views
        var origin = bounds.origin
        let maxWidth = bounds.width
        
        
        let rows = makeRows(maxWidth, proposal, subviews)
        
        for row in rows {
            // change origin based on alignment preference passed in
            let leading: CGFloat = bounds.maxX - maxWidth // account for any padding at upper view
            let trailing = bounds.maxX - (row.reduce(CGFloat.zero) { partialResult, view in
                let width = view.sizeThatFits(proposal).width
                
                if view == row.last {
                    // no spacing
                    return partialResult + width
                }
                // with spacing
                return partialResult + width + spacing
            })
            let centre = (trailing + leading) / 2
            
            // reset origin x to 0 for each row
            origin.x = (alignment == .leading ? leading: alignment == .trailing ? trailing : centre)
            
            for view in row {
                let viewSize = view.sizeThatFits(proposal)
                view.place(at: origin, proposal: proposal)
                // update origin
                origin.x += (viewSize.width + spacing)
            }
            
            // Update origin y
            origin.y += (row.maxHeight(proposal) + spacing)
        }
    }
    
    // make rows based on available size
    func makeRows(_ maxWidth: CGFloat, _ proposal: ProposedViewSize, _ subViews: Subviews) -> [[LayoutSubviews.Element]] {
        
        var row: [LayoutSubviews.Element] = []
        var rows: [[LayoutSubviews.Element]] = []
        
        var origin: CGPoint = CGRect.zero.origin
        
        for  view in subViews {
            let viewSize = view.sizeThatFits(proposal)
            
            if (origin.x + viewSize.width + spacing) > maxWidth {
                rows.append(row)
                row.removeAll()
                // reset x origin
                origin.x = 0
                row.append(view)
                // update origin
                origin.x += (viewSize.width + spacing)
                
            } else {
                // add item into same row
                row.append(view)
                // update origin
                origin.x += (viewSize.width + spacing)
            }
        }
        // check for row overflow
        if !row.isEmpty {
            rows.append(row)
            row.removeAll()
        }
        return rows
    }
}

extension [LayoutSubviews.Element] {
    func maxHeight(_ proposal: ProposedViewSize) -> CGFloat {
        return self.compactMap { view in
            return view.sizeThatFits(proposal).height
        }.max() ?? 0
    }
}

#Preview {
    PillSelector()
}
