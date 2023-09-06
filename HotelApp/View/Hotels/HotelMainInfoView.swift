//
//  HotelBlock1.swift
//  HotelApp
//
//  Created by Anton on 01.09.23.
//

import SwiftUI

struct HotelMainInfoView: View {
    @StateObject var viewModel = HotelViewModel()
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color(.systemBackground))
            .frame(height: 450)
            .overlay(alignment: .top) {
                
                VStack {
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
                    .padding(.top)
                    
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
                    
                    //MARK: - Name
                    
                    Text(viewModel.hotelModel?.name ?? "Name")
                        .font(.custom("SFProDisplay-Medium", size: 22))
                        .padding(.horizontal)
                    
                    Button {
                        print("Adress tapped")
                    } label: {
                        Text(viewModel.hotelModel?.adress ?? "")
                            .font(.custom("SFProDisplay-Medium", size: 14))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 5)
                    
                    
                    //MARK: - Price
                    
                    HStack {
                        Text("от \(viewModel.formattedPrice(viewModel.hotelModel?.minimal_price ?? 0)) ₽")
                            .font(.system(size: 30).bold())
                        Text(viewModel.hotelModel?.price_for_it ?? "")
                            .padding(.top, 7)
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "828796", alpha: 1))
                    }
                    .padding(.horizontal)
                }
                
            }
            .onAppear {
                viewModel.fetch()
            }
    }
}

struct HotelBlock1_Previews: PreviewProvider {
    static var previews: some View {
        HotelMainInfoView()
    }
}
