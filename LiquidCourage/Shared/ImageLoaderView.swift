//
//  ImageLoaderView.swift
//  SharedAssets
//
//  Created by app-kaihatsusha on 13/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct ImageLoaderView: View {
    
    var urlString: String = Constants.randomImage
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                AsyncImage(url: URL(string: urlString)) { phase in
                    if let image = phase.image {
                        // valid image
                        image
                            .resizable()
                            .aspectRatio(contentMode: resizingMode)
                            .allowsHitTesting(false)
                    } else if phase.error != nil {
                        // error - null returned
                        Image(systemName: "questionmark.square.dashed")
                            .resizable()
                            .scaledToFit()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 8, x: 5, y: 5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            }
                    } else {
                        ProgressView()
                            .tint(.red)
                            .scaleEffect(4)
                    }
                }
            }
            .clipped()
        
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical, 60)
}

extension ImageLoaderView {
    
    
}
