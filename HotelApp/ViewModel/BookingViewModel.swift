//
//  BookingViewModel.swift
//  HotelApp
//
//  Created by Anton on 04.09.23.
//

import SwiftUI

class BookingViewModel: ObservableObject {
    @Published var bookingModel: BookingModel?
    @Published var tourists: [Tourist] = [Tourist()]
    
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var touristName: String = ""
    @Published var touristLastName: String = ""
    @Published var dateOfBirth: String = ""
    @Published var citizenship: String = ""
    @Published var passportNumber: String = ""
    @Published var passportExpirationDate: String = ""

    
    var totalCost: Int? {
        return (bookingModel?.tour_price ?? 0) +
               (bookingModel?.fuel_charge ?? 0) +
               (bookingModel?.service_charge ?? 0)
    }

    
    func fetch() {
        guard let url = URL(string: "https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let booking = try JSONDecoder().decode(BookingModel.self, from: data)
                DispatchQueue.main.async {
                    self?.bookingModel = booking
                }
            } catch {
                print("Error in Do/Catch: \(error)")
            }
        }
        task.resume()
    }
    
//    func areTouristsDataFilled() -> Bool {
//        for tourist in tourists {
//            if tourist.isDataEmpty {
//                return false
//            }
//        }
//        return true
//    }
    
//    func touristDataField() -> Bool {
//        if touristName.isEmpty, touristLastName.isEmpty, dateOfBirth.isEmpty, citizenship.isEmpty,
//           passportNumber.isEmpty, passportExpirationDate.isEmpty {
//            return false
//        } else {
//            return true
//        }
//    }
    
    func touristDataField() -> Bool {
        for tourist in tourists {
            if tourist.isDataEmpty {
                return false
            }
        }
        return true
    }

}
