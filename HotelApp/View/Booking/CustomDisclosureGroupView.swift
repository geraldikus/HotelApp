//
//  CustomDisclosureGroupView.swift
//  HotelApp
//
//  Created by Anton on 06.09.23.
//

import SwiftUI

struct CustomDisclosureGroupView<Content: View>: View {
    @State private var isExpanded: Bool = false
    var label: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(label)
                        .foregroundColor(.black)
                        .font(.custom("SFProDisplay-Medium", size: 22))
                    Spacer()
                    Image(isExpanded ? "upArrow" : "downArrow")
                        .foregroundColor(.blue)
                }
            }
            
            if isExpanded {
                content()
                    .cornerRadius(5)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}
