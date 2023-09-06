//
//  WrappedLayoutRoom.swift
//  HotelApp
//
//  Created by Anton on 01.09.23.
//

import SwiftUI

struct WrappedLayoutRoom: View {
    
    var platforms: [String]
    @StateObject var viewModel: RoomViewModel
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .onAppear {
            viewModel.fetch()
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(platforms, id: \.self) { platform in
                self.item(for: platform)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if platform == self.platforms.last
                        {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if platform == self.platforms.last {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
    
    func item(for text: String) -> some View {
        Text(text)
            .background(Color(hex: "FBFBFC", alpha: 1))
            .cornerRadius(5)
            .font(.custom("SFProDisplay-Medium", size: 16))
            .foregroundColor(Color(hex: "828796", alpha: 1))
    }
}

