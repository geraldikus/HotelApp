//
//  RoomModel.swift
//  HotelApp
//
//  Created by Anton on 01.09.23.
//

import Foundation

struct RoomModel: Identifiable, Decodable {
    let id: Int
    let name: String
    let price: Int
    let price_per: String
    let peculiarities: [String]
    let image_urls: [String]
}

struct RoomListModel: Decodable {
    let rooms: [RoomModel]
}
