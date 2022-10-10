//
//  DescriptionVM.swift
//  TravelApp
//
//  Created by eda on 4.10.2022.
//

import Foundation
import SwiftyJSON

class DescriptionVM:ObservableObject{
    var openType : OpenTypes?
    var trips:[CoreDataModel]?
    var isFavorite = false
    var selectedHotelIndex : Int?
    var buttonText = Binder<String>()
    var flightDescription = Binder<String>()
    var flightTitle = Binder<String>()
    
// STATUS ARRANGE FOR ALL SEGMENTS
    func setAssetStatus (){
        trips = CoreDataManager.shared.getAllTrips()
        if openType == .hotel{
            flightTitle.value = Helper.hotelList![selectedHotelIndex!].name.content
            
            if trips?.filter({ $0.code == Helper.hotelList![selectedHotelIndex!].code}).count == 1{
                isFavorite = true
                buttonText.value = "Remove Bookmarks"
                
            }else{
                isFavorite = false
                buttonText.value = "Add Bookmarks"
            }
        }else if openType == .flight{
            if trips?.filter({ $0.code == Helper.flightList[selectedHotelIndex!].code}).count == 1{
                isFavorite = true
                flightDescription.value = trips?[0].hotelDescription ?? ""
                flightTitle.value = trips?[0].name ?? ""
                buttonText.value = "Remove Bookmarks"
            }else{
                arrangeFlight()
                isFavorite = false
                buttonText.value = "Add Bookmarks"
            }
        }else{
            
            buttonText.value = "Remove Bookmarks"
            isFavorite = true
            flightDescription.value = trips?[selectedHotelIndex!].hotelDescription ?? ""
            flightTitle.value = trips?[selectedHotelIndex!].name ?? ""
            
        }
    }
    
// SAVE OR DELETE ITEMS
    func tappedAddFavorite(){
        if isFavorite == false{
            let cellVM : CoreDataModel?
            if openType == .hotel{
                cellVM = CoreDataModel(code: Helper.hotelList![selectedHotelIndex!].code, name: Helper.hotelList![selectedHotelIndex!].name.content, hotelDescription: Helper.hotelList![selectedHotelIndex!].hotelDescription.content, countryCode: "\(Helper.hotelList![selectedHotelIndex!].countryCode)", address: Helper.hotelList![selectedHotelIndex!].address.content ?? ""  , city: (Helper.hotelList![selectedHotelIndex!].city.content), images: Helper.hotelList![selectedHotelIndex!].images?[5].path ?? "")
            }else{
                cellVM = CoreDataModel(code: Helper.flightList[selectedHotelIndex!].code, name: Helper.flightList[selectedHotelIndex!].arrival, hotelDescription: flightDescription.value ?? "", countryCode: "", address: "" , city: "", images: "")
            }
            buttonText.value = "Remove Bookmarks"
            
            CoreDataManager.shared.insert(trip: cellVM!)
            isFavorite=true
        }else{
            CoreDataManager.shared.deleteCoreData()
            let newDatas = trips?.filter({ $0.name != flightTitle.value})
           // print(newDatas?.count)
            if newDatas?.count != 0{
                for item in newDatas!{
                    CoreDataManager.shared.insert(trip: item)
                }
                
            }
            buttonText.value = "Add Bookmarks"
            isFavorite=false
            
            
        }}
 
// SET FLIGHT DESCRIPTION  WITH FLIGHT OBJECT
    func arrangeFlight () {
        flightTitle.value = Helper.flightList[selectedHotelIndex!].arrival
        flightDescription.value = "Departure Airport : \(Helper.flightList[selectedHotelIndex!].departure) \nArrival Aiport : \(Helper.flightList[selectedHotelIndex!].arrival) \nDeparture Date : \(Helper.flightList[selectedHotelIndex!].departure_date) \nDeparture Time : \(Helper.flightList[selectedHotelIndex!].departure_time) \nArrival Date : \(Helper.flightList[selectedHotelIndex!].arrival_date) \nDeparture Time : \(Helper.flightList[selectedHotelIndex!].arrival_time)"
    }
}

