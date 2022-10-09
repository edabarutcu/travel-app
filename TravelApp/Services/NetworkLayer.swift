//
//  NetworkLayer.swift
//  TravelApp
//
//  Created by eda on 1.10.2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import CryptoKit

class NetworkUtils{
    
    static let baseUrl = "https://api.test.hotelbeds.com"
    static let contentUri = "/hotel-content-api/1.0"
    static let apiKey = "8fc1a187f91287e2cf4da8d06cc83f2a"
    static let secret = "8a286ab870"
    static let upcomingHotelUrl = "{version}/hotels"
    static let nowPlayingHotelUrl = "now_playing"
    static let mediumImageUrl = "https://photos.hotelbeds.com/giata/original/"
    
    
    static func getHotels(cityCode:String,number:Int ,callBackFunc: @escaping ([Hotel])->()){
        let parameters: [String: Any] = [:]
        let headers: HTTPHeaders = getHeader()
        let url = baseUrl + contentUri
        
        AF.request(url + "/hotels?destinationCode=\(cityCode)&from=1&to=\(number)&useSecondaryLanguage=false&fields=name,code,description,countryCode,address,city,images", method:.get, parameters: parameters,encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: ContentDetails.self) { (response) in
                guard let response = response.value else { return }
                var hotelsArray : [Hotel] = []
                for item in response.hotels {
                    hotelsArray.append(item)
                }
                callBackFunc(hotelsArray)
            }
    }
    
    static func calculateXSignature() -> String {
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let inputString = apiKey + secret + String(timestamp)
        let inputData = Data(inputString.utf8)
        let hashed = SHA256.hash(data: inputData)
      //  print(hashed.description.components(separatedBy: ":")[1])
        
        return hashed.description.components(separatedBy: ":")[1]
    }
    
    static func getHeader() -> HTTPHeaders {
        return ["Accept":"application/json", "Api-key":apiKey, "Accept-Encoding":"gzip", "X-Signature":calculateXSignature()]
    }
    
    
    static func getFlightList (airLines:String){
        guard let url = URL(string: "http://api.aviationstack.com/v1/flights?access_key=59a65803206f1f113d452b837525c0cf&flight_status=scheduled&limit=50&airline_iata=\(airLines)") else { return }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            let jsonData = JSON(rawValue: json)
            
            for item in jsonData!["data"]{
                let flightData = FlightList(res: item.1)
                Helper.flightList.append(flightData)
            }
            print(Helper.flightList)
        }
        
        task.resume()
    }
}
