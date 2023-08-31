//
//  ContentView.swift
//  HotelApp
//
//  Created by Anton on 31.08.23.
//

import SwiftUI

struct HotelView: View {
    
    @StateObject var viewModel = HotelViewModel()
    
    let columns = [
           GridItem(.adaptive(minimum: 80))
       ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    //MARK: - Photos
                    
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
                    .padding(.horizontal)
                    
                    //MARK: - Rating
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                        
                            .foregroundColor(Color(hex: "FFC700", alpha: 0.2))
                            .frame(width: 149, height: 29)
                            .overlay {
                                HStack(spacing: 2) {
                                    Image("Star")
                                    Text("\(viewModel.hotelModel?.rating ?? 0) \((viewModel.hotelModel?.rating_name ?? ""))")
                                        .font(.custom("SFProDisplay-Medium", size: 16))
                                        .foregroundColor(Color(hex: "FFA800", alpha: 1))
                                }
                            }
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    //MARK: - Name and address
                    
                    Text(viewModel.hotelModel?.name ?? "Name")
                        .font(.custom("SFProDisplay-Medium", size: 22))
                        .padding(.leading)
                    
                    Button {
                        print("Adress tapped")
                    } label: {
                        Text(viewModel.hotelModel?.adress ?? "")
                            .font(.custom("SFProDisplay-Medium", size: 14))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                    
                    //MARK: - Price
                    
                    HStack {
                        Text("от \(viewModel.formattedPrice(viewModel.hotelModel?.minimal_price ?? 0)) ₽")
                            .font(.system(size: 30).bold())
                            .padding(.leading)
                        Text(viewModel.hotelModel?.price_for_it ?? "")
                            .padding(.top, 7)
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "828796", alpha: 1))
                    }
                    .padding(.top)
                    
                    //MARK: - Detailed information about the hotel
                    
                    Text("Об отеле")
                        .padding()
                        .font(.custom("SFProDisplay-Medium", size: 22))
                    
                    ForEach(viewModel.hotelModel?.about_the_hotel.peculiarities ?? [], id: \.self) { peculiarity in
                        Text(peculiarity)
                            .background(Color(hex: "FBFBFC", alpha: 1))
                            .font(.custom("SFProDisplay-Medium", size: 16))
                            .foregroundColor(Color(hex: "828796", alpha: 1))
                    }
                    .padding(.leading)
                    
                    Text(viewModel.hotelModel?.about_the_hotel.description ?? "")
                        .padding(.leading)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 185)
                        .padding()
                        .foregroundColor(Color(hex: "FBFBFC", alpha: 1))
                        .overlay {
                            VStack(spacing: 15) {
                                HStack {
                                    Image("happy")
                                        .frame(width: 24, height: 24)
                                    VStack(alignment: .leading) {
                                        Text("Удобства")
                                        Text("Самое необходимое")
                                    }
                                    Spacer()
                                    Image("arrow")
                                }
                                .padding(.horizontal, 30)
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(height: 1)
                                    .padding(.leading, 65)
                                    .padding(.trailing, 30)
                                    .foregroundColor(Color(hex: "828796", alpha: 1))
                                
                                HStack {
                                    Image("happy")
                                        .frame(width: 24, height: 24)
                                    VStack(alignment: .leading) {
                                        Text("Удобства")
                                        Text("Самое необходимое")
                                    }
                                    Spacer()
                                    Image("arrow")
                                }
                                .padding(.horizontal, 30)
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(height: 1)
                                    .padding(.leading, 65)
                                    .padding(.trailing, 30)
                                    .foregroundColor(Color(hex: "828796", alpha: 1))
                                
                                HStack {
                                    Image("happy")
                                        .frame(width: 24, height: 24)
                                    VStack(alignment: .leading) {
                                        Text("Удобства")
                                        Text("Самое необходимое")
                                    }
                                    Spacer()
                                    Image("arrow")
                                }
                                .padding(.horizontal, 30)
                            }
                        }
                    
                }
                .padding(.horizontal, 5)
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
