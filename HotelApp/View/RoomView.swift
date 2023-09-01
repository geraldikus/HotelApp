//
//  RoomView.swift
//  HotelApp
//
//  Created by Anton on 01.09.23.
//

import SwiftUI

struct RoomView: View {
    
    @StateObject var viewModel = HotelViewModel()
    var colorBack = #colorLiteral(red: 0.9138661623, green: 0.9135121703, blue: 0.9266512394, alpha: 1)
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(.systemBackground))
                        .frame(height: 500)
                        .overlay(alignment: .top) {
                            Text(":LOS")
                        }
                        .padding(.top)
                        .edgesIgnoringSafeArea(.all)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(.systemBackground))
                        .frame(height: 500)
                        .overlay(alignment: .top) {
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
                            .background(Color.gray)
                            .frame(height: 250)
                            .cornerRadius(20)
                            .padding()
                        }
                        
                        //.edgesIgnoringSafeArea(.all)
                    
                }
                .background(Color(colorBack))
                .edgesIgnoringSafeArea(.all)
                
            }
            .navigationTitle("Hello")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetch()
        }
    }
}


struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
    }
}
