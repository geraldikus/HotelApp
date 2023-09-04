//
//  BookingDataView.swift
//  HotelApp
//
//  Created by Anton on 04.09.23.
//

import SwiftUI

struct BookingDataView: View {
    
    var name: String
    var data: String
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.fixed(150), alignment: .topLeading),
            GridItem(.flexible(), alignment: .topLeading)
        ]) {
            Text(name)
                .foregroundColor(Color(hex: "828796", alpha: 1))
            Text(data)
        }
        .padding(.horizontal)
    }
}
