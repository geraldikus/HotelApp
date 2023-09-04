//
//  RoomView.swift
//  HotelApp
//
//  Created by Anton on 01.09.23.
//
import SwiftUI

struct RoomView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = RoomViewModel()
    @StateObject var hotelViewModel = HotelViewModel()
    
    var colorBack = #colorLiteral(red: 0.9138661623, green: 0.9135121703, blue: 0.9266512394, alpha: 1)
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                ForEach(viewModel.roomListModel?.rooms ?? [], id: \.id) { room in
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(.systemBackground))
                            .frame(height: 540)
                            .overlay(alignment: .top) {
                                
                                //MARK: - Photos
                                VStack(alignment: .leading) {
                                    RoomPhotosView(imageURLs: room.image_urls, loadedImages: viewModel.loadedImages)
                                    
                                    //MARK: - Name
                                    
                                    Text(room.name)
                                        .font(.custom("SFProDisplay-Medium", size: 22))
                                        .padding(.leading)
                                    
                                    //MARK: - Includes
                                    VStack {
                                        WrappedLayoutRoom(platforms: room.peculiarities, viewModel: RoomViewModel())
                                            .padding(.leading)
                                    }
                                    
                                    //MARK: - More Information
                                    
                                    RoomMoreInfoView()
                                    
                                    //MARK: - Price
                                    
                                    RoomPriceView(price: room.price, pricePer: room.price_per, hotelViewModel: hotelViewModel)
                                    
                                    //MARK: - Navigation
                                    
                                    NavigationLink(destination: BookingView().navigationBarBackButtonHidden(true)) {
                                        Text("Выбрать номер")
                                            .foregroundColor(.white)
                                    }
                                    .frame(height: 48)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(hex: "0D72FF", alpha: 1))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top)
                            .edgesIgnoringSafeArea(.all)
                        
                    }
                    .background(Color(colorBack))
                    .edgesIgnoringSafeArea(.all)
                }
                
                
            }
            .navigationTitle("Steigenberger Makadi")
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
        .onAppear {
            viewModel.fetch()
            hotelViewModel.fetch()
        }
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
    }
}

