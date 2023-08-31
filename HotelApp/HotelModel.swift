//
//  HotelModel.swift
//  HotelApp
//
//  Created by Anton on 31.08.23.
//

import Foundation

struct Hotel: Codable {
    let id: Int
    let name: String
    let adress: String
    let minimal_price: Int
    let price_for_it: String
    let rating: Int
    let rating_name: String
    let image_urls: [String]
    let about_the_hotel: AboutHotel
}

struct AboutHotel: Codable {
    let description: String
    let peculiarities: [String]
}
