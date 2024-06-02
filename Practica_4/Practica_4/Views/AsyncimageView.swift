//
//  AsyncimageView.swift
//  Practica 4
//
//  Created by Álvaro García ortiz on 21/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct AsyncimageView: View {
    var url: URL?
    var isGif: Bool
    
    @State private var isAnimating = true

    var body: some View {
        if isGif {
            AnimatedImage(url: url)
               
        } else {
            AsyncImage(url: url) { phase in
                if url == nil {
                    Color.white
                } else if let image = phase.image {
                    image.resizable()
                } else if phase.error != nil {
                    Color.green
                } else {
                    ProgressView()
                }
            }
        }
    }
}

