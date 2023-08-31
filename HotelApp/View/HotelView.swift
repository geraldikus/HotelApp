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
                VStack(spacing: 10) {
                    TabView {
                        ForEach(viewModel.hotelModel?.image_urls ?? [], id: \.self) { imageUrl in
                            if let image = viewModel.loadedImages.first(where: { $0.url == imageUrl })?.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 250)
                            } else {
                                ProgressView()
                            }
                        }
                        .padding()
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .frame(height: 250)
                    .cornerRadius(20)
                    
                    Text(viewModel.hotelModel?.name ?? "Name")
                        .font(.custom("SFProDisplay-Medium", size: 22))
                        
                }
                .padding(.horizontal)
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
