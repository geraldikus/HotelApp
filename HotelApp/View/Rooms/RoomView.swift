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
                            .frame(height: 540)
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
                                    
                                    //MARK: - Includes
                                    VStack {
                                        WrappedLayoutRoom(platforms: room.peculiarities, viewModel: RoomViewModel())
                                            .padding(.leading)
                                            
                                    }
                                    
                                    //MARK: - More Information
                                    
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
                                    
                                    //MARK: - Price
                                    
                                    HStack {
                                        Text("от \(hotelViewModel.formattedPrice(room.price)) ₽")
                                            .font(.system(size: 30).bold())
                                        Text(room.price_per)
                                            .padding(.top, 7)
                                            .font(.system(size: 14))
                                            .lineLimit(1)
                                            .foregroundColor(Color(hex: "828796", alpha: 1))
                                    }
                                    .padding(.horizontal)
                                    
                                    //MARK: - Navigation
                                    
                                    NavigationLink(destination: BookingView()) {
                                        Text("Выбрать номер")
                                            .foregroundColor(.white)
                                    }
                                    .frame(height: 48)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(hex: "0D72FF", alpha: 1))
                                    .cornerRadius(10)
                                    .padding(.horizontal)

                                    
                                }
                            }
                            .padding(.top)
                            .edgesIgnoringSafeArea(.all)
                        
                    }
                    .background(Color(colorBack))
                    .edgesIgnoringSafeArea(.all)
                }
                
                
            }
            .navigationTitle("Steigenberger Makadi")

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
