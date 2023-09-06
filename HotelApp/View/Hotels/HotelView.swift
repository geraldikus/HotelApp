//
//  ContentView.swift
//  HotelApp
//
//  Created by Anton on 31.08.23.
//

import SwiftUI

struct HotelView: View {
    
    @StateObject var viewModel = HotelViewModel()
    var colorBack = #colorLiteral(red: 0.9138661623, green: 0.9135121703, blue: 0.9266512394, alpha: 1)
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    HotelMainInfoView()
                    HotelDetailsInfoView()
                    
                    NavigationLink(destination: RoomView().navigationBarBackButtonHidden(true)) {
                        Text("К выбору номера")
                            .foregroundColor(.white)
                    }
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "0D72FF", alpha: 1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .navigationBarBackButtonHidden(true)
                    
                }
                .background(Color(colorBack))
                .edgesIgnoringSafeArea(.top)
                
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
