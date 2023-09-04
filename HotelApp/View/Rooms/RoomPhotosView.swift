//
//  RoomPhotosView.swift
//  HotelApp
//
//  Created by Anton on 04.09.23.
//

import SwiftUI

struct RoomPhotosView: View {
    
    let imageURLs: [String]
    let loadedImages: [(url: String, image: UIImage)]
    
    var body: some View {
        TabView {
            ForEach(imageURLs, id: \.self) { imageUrl in
                if let image = loadedImages.first(where: { $0.url == imageUrl })?.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                } else {
                    ProgressView()
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .background(Color.gray)
        .frame(height: 250)
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.top)
    }
}
