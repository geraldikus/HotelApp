//
//  PayedView.swift
//  HotelApp
//
//  Created by Anton on 05.09.23.
//

import SwiftUI

struct PayedView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let orderNumber: String = {
        let randomOrderNumber = String(format: "№%06d", Int.random(in: 1...999999))
        return randomOrderNumber
    }()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Circle()
                        .frame(width: 94)
                        .foregroundColor(Color(hex: "F6F6F9", alpha: 1))
                        .overlay {
                            Text("🎉")
                                .font((.system(size: 45)))
                        }
                    
                    Text("Ваш заказ принят в работу")
                        .font(.custom("SFProDisplay-Medium", size: 22))
                    
                    Text("Подтверждение заказа \(orderNumber) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
                        .padding(10)
                        .font((.system(size: 16)))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: "828796", alpha: 1))
                }
                .navigationTitle("Заказ оплачен")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading:
                                        Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                })
                )
                
                VStack {
                    Spacer()
                    Divider()
                    NavigationLink(destination: HotelView().navigationBarBackButtonHidden(true)) {
                        Text("Супер!")
                            .foregroundColor(.white)
                    }
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "0D72FF", alpha: 1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct PayedView_Previews: PreviewProvider {
    static var previews: some View {
        PayedView()
    }
}
