//
//  BookingView.swift
//  HotelApp
//
//  Created by Anton on 01.09.23.
//

import SwiftUI

struct BookingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = BookingViewModel()
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var isEditing: Bool = false
    var colorBack = #colorLiteral(red: 0.9138661623, green: 0.9135121703, blue: 0.9266512394, alpha: 1)
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    //MARK: - MainData
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(.systemBackground))
                        .frame(height: 130)
                        .overlay() {
                            VStack(alignment: .leading) {
                                HStack(spacing: 3) {
                                    Image("Star")
                                    Text("\(viewModel.bookingModel?.horating ?? 0) \(viewModel.bookingModel?.rating_name ?? "")")
                                        .foregroundColor(Color(hex: "FFA800", alpha: 1))
                                        .bold()
                                        .padding(.vertical, 5)
                                        .padding(.trailing, 10)
                                }
                                .background(Color(hex: "FFC700", alpha: 0.2))
                                .cornerRadius(5)
                                
                                Text(viewModel.bookingModel?.hotel_name ?? "")
                                    .padding(.bottom, 5)
                                Button {
                                    //
                                } label: {
                                    Text(viewModel.bookingModel?.hotel_adress ?? "")
                                        .frame(alignment: .leading)
                                        .font(.system(size: 14))
                                }
                                
                            }
                            .padding(.trailing, 40)
                        }
                    
                    //MARK: - BookingData
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 280)
                        .foregroundColor(Color(.systemBackground))
                        .overlay() {
                            VStack(spacing: 10) {
                                BookingDataView(name: "Вылет из", data: viewModel.bookingModel?.departure ?? "")
                                BookingDataView(name: "Страна, город", data: viewModel.bookingModel?.arrival_country ?? "")
                                BookingDataView(name: "Даты", data: "\(viewModel.bookingModel?.tour_date_start ?? "") - \(viewModel.bookingModel?.tour_date_stop ?? "")")
                                BookingDataView(name: "Кол-во ночей", data: "\(viewModel.bookingModel?.number_of_nights ?? 0) ночей")
                                BookingDataView(name: "Отель", data: viewModel.bookingModel?.hotel_name ?? "")
                                BookingDataView(name: "Номер", data: viewModel.bookingModel?.room ?? "")
                                BookingDataView(name: "Питание", data: viewModel.bookingModel?.nutrition ?? "")
                            }
                        }
                    
                    //MARK: - Customer Information
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 250)
                        .foregroundColor(Color(.systemBackground))
                        .overlay {
                            VStack(alignment: .leading) {
                                Text("Информация о покупателе")
                                    .font(.custom("SFProDisplay-Medium", size: 22))
                                
                                PhoneNumberView(phoneNumber: $phone)
                                EmailView(email: $email)
                                
                                Text("Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту.")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "828796", alpha: 1))
                            }
                            .padding(.horizontal)
                        }
                    RoundedRectangle(cornerRadius: 10)
                }
                .background(Color(colorBack))
                .edgesIgnoringSafeArea(.top)
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
        } .onAppear {
            viewModel.fetch()
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
