//
//  RoomPriceView.swift
//  HotelApp
//
//  Created by Anton on 04.09.23.
//

import SwiftUI

struct RoomPriceView: View {
    
    let price: Int
    let pricePer: String
    let hotelViewModel: HotelViewModel
    
    var body: some View {
        HStack {
            Text("от \(hotelViewModel.formattedPrice(price)) ₽")
                .font(.system(size: 30).bold())
            Text(pricePer)
                .padding(.top, 7)
                .font(.system(size: 14))
                .lineLimit(1)
                .foregroundColor(Color(hex: "828796", alpha: 1))
        }
        .padding(.horizontal)
    }
}
