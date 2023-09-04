//
//  BookingView.swift
//  HotelApp
//
//  Created by Anton on 01.09.23.
//

import SwiftUI

struct BookingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var colorBack = #colorLiteral(red: 0.9138661623, green: 0.9135121703, blue: 0.9266512394, alpha: 1)
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(.systemBackground))
                        .frame(height: 200)
                        .overlay {
                            VStack(alignment: .leading) {
                                
                            }
                        }
                }
            }
            .navigationTitle("Бронирование")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            })
            )
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
