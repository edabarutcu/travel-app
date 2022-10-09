//
//  Models.swift
//  TravelApp
//
//  Created by eda on 8.10.2022.
//

import Foundation
import SwiftyJSON
// MARK: - ContentDetails
struct ContentDetails: Codable {
    let from, to: Int
    let hotels: [Hotel]
}

// MARK: - Hotel
struct Hotel: Codable {
    let code: Int
    let name, hotelDescription: City
    let countryCode: String
    let address: Address
    let city: City
    let images: [Image]?
    
    enum CodingKeys: String, CodingKey {
        case code, name
        case hotelDescription = "description"
        case countryCode, address, city, images
    }
}

// MARK: - Address
struct Address: Codable {
    let content, street, number: String?
}

// MARK: - City
struct City: Codable {
    let content: String
}

// MARK: - Image
struct Image: Codable {
    let imageTypeCode, path: String
    let order, visualOrder: Int
    let roomCode, roomType: String?
    let characteristicCode: String?
}


enum OpenTypes{
    case hotel
    case flight
}

// MARK: - FLIGHT MODEL

struct FlightList:Codable{
    
    var arrival : String = ""
    var departure : String = ""
    var arrival_date : String = ""
    var arrival_time : String = ""
    var departure_date : String = ""
    var departure_time : String = ""
    var arrival_iata : String = ""
    var code : Int = 0
    
    
    init (res: JSON){
    
        self.arrival = res["arrival"]["airport"].stringValue
        self.departure = res["departure"]["airport"].stringValue
        self.arrival_date = Helper.flightDateFormatter(dateStr: String(res["arrival"]["scheduled"].stringValue.prefix(19)))
        self.arrival_time = Helper.flightTimeDateFormatter(dateStr: String(res["arrival"]["scheduled"].stringValue.prefix(19)))
        self.departure_date = Helper.flightDateFormatter(dateStr: String(res["departure"]["scheduled"].stringValue.prefix(19)))
        self.departure_time = Helper.flightTimeDateFormatter(dateStr: String(res["departure"]["scheduled"].stringValue.prefix(19)))
        self.arrival_iata = res["arrival"]["iata"].stringValue
        self.code = res["flight"]["number"].intValue
    }
}

