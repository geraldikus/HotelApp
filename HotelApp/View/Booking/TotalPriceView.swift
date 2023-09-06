//
//  TotalPriceView.swift
//  HotelApp
//
//  Created by Anton on 06.09.23.
//

import SwiftUI

struct TotalPriceView: View {
    var title: String
    var value: Double
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color(hex: "828796", alpha: 1))
            Spacer()
            Text("\(formattedPrice(value)) ₽")
                .fontWeight(title == "К оплате" ? .bold : .regular)
                .foregroundColor(title == "К оплате" ? Color(hex: "0D72FF", alpha: 1) : Color(.label))
                
        }
        .padding(.horizontal)
    }
    
    private func formattedPrice(_ price: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        return numberFormatter.string(from: NSNumber(value: price)) ?? "0"
    }
}
