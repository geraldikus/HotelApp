//
//  RoomMoreInfoView.swift
//  HotelApp
//
//  Created by Anton on 04.09.23.
//

import SwiftUI

struct RoomMoreInfoView: View {
    var body: some View {
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
