//
//  ContentView.swift
//  HotelApp
//
//  Created by Anton on 31.08.23.
//

import SwiftUI

struct HotelView: View {
    
    @StateObject var viewModel = HotelViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if let hotel = viewModel.hotelModel {
                        TabView {
                            ForEach(hotel.image_urls, id: \.self) { imageUrl in
                                if let image = viewModel.loadedImages.first(where: { $0.url == imageUrl })?.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 400, height: 250)
                                        .cornerRadius(10)
                                        
                                } else {
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        .frame(height: 250)
                        .frame(maxWidth: .infinity - 100)
                        .background(Color.gray)
                        .cornerRadius(20)
                    }
                }
            }
            .navigationTitle("Отель")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetch()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HotelView()
    }
}


//TabView {
//    ForEach(0..<2) { index in
//        Image("Image01") // Замените на свои изображения
//            .resizable()
//            .scaledToFit()
//        Image("Image02")
//            .resizable()
//            .scaledToFit()
//    }
//}
//.tabViewStyle(PageTabViewStyle()) // Этот стиль делает перелистывание
//.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
