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
    @StateObject var viewModel = BookingViewModel()
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var isEditing: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    //MARK: - MainData
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(.systemBackground))
                        .frame(height: 120)
                        .overlay() {
                            VStack(alignment: .leading) {
                                HStack(spacing: 3) {
                                    Image("Star")
//                                        .padding(.leading, 10)
                                    Text("\(viewModel.bookingModel?.horating ?? 0) \(viewModel.bookingModel?.rating_name ?? "")")
                                        .foregroundColor(Color(hex: "FFA800", alpha: 1))
                                        .bold()
                                        .padding(.vertical, 5)
                                        .padding(.trailing, 10)
                                }
                                .background(Color(hex: "FFC700", alpha: 0.2))
                                .cornerRadius(5)
                                
                                Text(viewModel.bookingModel?.hotel_name ?? "")
                                Button {
                                    //
                                } label: {
                                    Text(viewModel.bookingModel?.hotel_adress ?? "")
                                        .frame(alignment: .leading)
                                        .font(.system(size: 14))
                                }

                            }
                          //  .background(Color.white)
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
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 250)
                        .foregroundColor(Color(.systemBackground))
                        .overlay {
                            VStack(alignment: .leading) {
                                Text("Информация о покупателе")
                                    .font(.custom("SFProDisplay-Medium", size: 22))
                                VStack(alignment: .leading, spacing: 1) {
                                        
                                    PhoneNumberView(phoneNumber: $phone)
                                        
                                }
                                .padding()
                                .background(Color(hex: "F6F6F9", alpha: 1))
                                .cornerRadius(10)
                                
                                VStack(alignment: .leading, spacing: 1) {
                                        
                                    EmailView(email: $email)
                                        
                                }
                                .padding()
                                .background(Color(hex: "F6F6F9", alpha: 1))
                                .cornerRadius(10)
                                
                                Text("Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту.")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "828796", alpha: 1))
                                
                            }
                            .padding(.horizontal)
                        }
                    
                    RoundedRectangle(cornerRadius: 10)
                }
                .background(Color(colorBack))
                .edgesIgnoringSafeArea(.all)
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

struct PhoneNumberView: View {
    @Binding var phoneNumber: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 1) {
            Text("Номер телефона")
                .font(.caption)
                .foregroundColor(Color(hex: "A9ABB7", alpha: 1))
            TextField("+7(000) 000-00-00", text: $phoneNumber)
                
                .keyboardType(.numberPad)
                .onChange(of: phoneNumber, perform: { newValue in
                    if newValue.count == 1 && newValue != "+" {
                        phoneNumber = "+7(" + phoneNumber
                    } else if newValue.count == 7 {
                        phoneNumber.insert(")", at: phoneNumber.index(phoneNumber.startIndex, offsetBy: 6))
                    } else if newValue.count == 10 {
                        phoneNumber.insert("-", at: phoneNumber.index(phoneNumber.startIndex, offsetBy: 10))
                    } else if newValue.count == 13 {
                        phoneNumber.insert("-", at: phoneNumber.index(phoneNumber.startIndex, offsetBy: 13))
                    } else if newValue.count > 16 {
                        phoneNumber.removeLast()
                    }
                })
        }
    }
}


struct EmailView: View {
    @Binding var email: String
    @State private var isEmailValid = true
    @State private var errorMessage = ""

    var body: some View {
        
        VStack(alignment: .leading, spacing: 1) {
            Text("Email")
                .font(.caption)
                .foregroundColor(Color(hex: "A9ABB7", alpha: 1))
            
            TextField("Email", text: $email, onCommit: {
                // Проверяем валидность после завершения ввода
                validateEmail()
            })
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .onChange(of: email, perform: { newValue in
                // Сбрасываем флаг ошибки и сообщение об ошибке при изменении текста
                isEmailValid = true
                errorMessage = ""
            })
            .overlay(
                Text(errorMessage)
                    .foregroundColor(.red)
                    .opacity(isEmailValid ? 0 : 1)
                    .padding(.bottom, 40)
            )
        }
    }
    
     func validateEmail() {
        if !isValidEmail(email) {
            errorMessage = "Email введен неверно"
            isEmailValid = false
        } else {
            isEmailValid = true
            errorMessage = ""
        }
    }

    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}





struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
