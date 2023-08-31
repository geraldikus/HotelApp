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
                VStack(alignment: .leading, spacing: 10) {
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
                    
                    HStack {
                        Text("от \(formattedPrice(viewModel.hotelModel?.minimal_price ?? 0)) ₽")
                            .font(.system(size: 30).bold())
                            .padding(.leading)
                        Text(viewModel.hotelModel?.price_for_it ?? "")
                            .padding(.top, 7)
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "828796", alpha: 1))
                    }
                    .padding(.top)
                        
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
    
    func formattedPrice(_ price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = " "
        numberFormatter.numberStyle = .decimal
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: price)) {
            return formattedNumber
        } else {
            return String(price)
        }
    }


}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HotelView()
    }
}
