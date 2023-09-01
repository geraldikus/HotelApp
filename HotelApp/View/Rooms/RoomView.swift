//
//  RoomView.swift
//  HotelApp
//
//  Created by Anton on 01.09.23.
//

import SwiftUI

struct RoomView: View {
    
    @StateObject var viewModel = RoomViewModel()
    @StateObject var hotelViewModel = HotelViewModel()
    
    var colorBack = #colorLiteral(red: 0.9138661623, green: 0.9135121703, blue: 0.9266512394, alpha: 1)
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                ForEach(viewModel.roomListModel?.rooms ?? [], id: \.id) { room in
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(.systemBackground))
                            .frame(height: 500)
                            .overlay(alignment: .top) {
                                
                                //MARK: - Photos
                                VStack(alignment: .leading) {
                                    TabView {
                                        ForEach(room.image_urls, id: \.self) { imageUrl in
                                            if let image = viewModel.loadedImages.first(where: { $0.url == imageUrl })?.image {
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
                                    
                                    //MARK: - Name
                                    
                                    Text(room.name)
                                        .font(.custom("SFProDisplay-Medium", size: 22))
                                        .padding(.leading)
                                    
                                    Button {
                                        
                                    } label: {
                                        HStack {
                                            Text("Подробнее о номере")
                                            Image("blueArrow")
                                        }
                                        .padding(.horizontal, 5)
                                            
                                    }
                                    .frame(height: 29)
                                    .background(Color(hex: "0D72FF", alpha: 0.1))
                                    .cornerRadius(5)
                                    .padding(.leading)
                                    

                                    
                                }
                            }
                            .padding(.top)
                            .edgesIgnoringSafeArea(.all)
                        
                    }
                    .background(Color(colorBack))
                    .edgesIgnoringSafeArea(.all)
                }
                
                
            }
            .navigationTitle("Hotel name")

            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetch()
            hotelViewModel.fetch()
        }
    }
}


struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
    }
}
