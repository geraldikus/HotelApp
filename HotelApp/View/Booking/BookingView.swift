//
//  BookingView.swift
//  HotelApp
//
//  Created by Anton on 01.09.23.
//

import SwiftUI

struct BookingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = BookingViewModel()
    
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
                                
                                PhoneNumberView(phoneNumber: viewModel.phone)
                                EmailView(email:viewModel.email)
                                
                                Text("Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту.")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "828796", alpha: 1))
                            }
                            .padding(.horizontal)
                        }
                    
                    CustomDisclosureGroup(label: "Первый турист") {
                        TouristTextField(name: "Имя", binding: viewModel.touristName)
                        TouristTextField(name: "Фамилия", binding: viewModel.touristLastName)
                        DateOfBirthView(name: "Дата рождения", binding: viewModel.dateOfBirth)
                        TouristTextField(name: "Гражданство", binding: viewModel.citizenship)
                        TouristTextField(name: "Номер загранпаспорта", binding: viewModel.passportNumber)
                        TouristTextField(name: "Срок действия загранпаспорта", binding: viewModel.passportExpirationDate)
                    }
                    CustomDisclosureGroup(label: "Второй турист") {
                        TouristTextField(name: "Имя", binding: viewModel.touristName)
                        TouristTextField(name: "Фамилия", binding: viewModel.touristLastName)
                        DateOfBirthView(name: "Дата рождения", binding: viewModel.dateOfBirth)
                        TouristTextField(name: "Гражданство", binding: viewModel.citizenship)
                        TouristTextField(name: "Номер загранпаспорта", binding: viewModel.passportNumber)
                        TouristTextField(name: "Срок действия загранпаспорта", binding: viewModel.passportExpirationDate)
                    }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.gray)
                        .frame(height: 60)
                        .overlay {
                            HStack {
                                Text("Добавить туриста")
                                    .font(.custom("SFProDisplay-Medium", size: 22))
                                Spacer()
                                Button {
                                    //
                                } label: {
                                    Image("plusIcon")
                                }
                            }
                            .padding(.horizontal)
                        }
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

struct CustomDisclosureGroup<Content: View>: View {
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
                    Image(systemName: isExpanded ? "chevron.up.circle" : "chevron.down.circle")
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


struct TouristTextField: View {
    var name: String
    
    @State var binding: String
    @State private var isEditing = false // Добавляем состояние для отслеживания ввода текста

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            if isEditing || !binding.isEmpty {
                Text(name)
                    .font(.caption)
                    .foregroundColor(Color(hex: "A9ABB7", alpha: 1))
            }

            TextField(name, text: $binding, onEditingChanged: { editing in
                isEditing = editing // Устанавливаем состояние в true, когда пользователь начинает/прекращает редактирование
            }, onCommit: {
                // Ваш код, который выполняется при завершении редактирования (нажатии "Return" на клавиатуре)
            })
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
        }
        .padding()
        .background(Color(hex: "F6F6F9", alpha: 1))
        .cornerRadius(10)
    }
}

struct DateOfBirthView: View {
    var name: String
    
    @State var binding: String
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            if isEditing || !binding.isEmpty {
                Text(name)
                    .font(.caption)
                    .foregroundColor(Color(hex: "A9ABB7", alpha: 1))
            }
            
            TextField("Дата рождения", text: $binding)
                .keyboardType(.numberPad)
                .onChange(of: binding, perform: { newValue in
                    if newValue.count == 2 {
                        binding += "."
                    } else if newValue.count == 5 {
                        binding += "."
                    } else if newValue.count > 10 {
                        binding.removeLast()
                    }
                })
        }
        .padding()
        .background(Color(hex: "F6F6F9", alpha: 1))
        .cornerRadius(10)
    }
}



struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
