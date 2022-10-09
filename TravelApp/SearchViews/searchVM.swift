//
//  searchVM.swift
//  TravelApp
//
//  Created by eda on 8.10.2022.
//

import Foundation
class SearchVM {
    let cityList = Helper.cityList
    var filteredFlights = Binder<[FlightList]>()
    var filteredHotels = Binder<[Hotel]>()
    var selectedItemNumber:Int = 0
    
// FIND SEARCH FLIGHT LIST
    func searchList (text:String) {
        var containCities : [FlightList] = []
        var filteredItem : [FlightList]?
        for item in cityList{
            if item[0].contains(text){
                filteredItem = Helper.flightList.filter({ $0.arrival_iata == item[1]})
                if filteredItem?.count != 0 {
                    for lastItem in filteredItem!{
                        containCities.append(lastItem)
                    }
                }
            }
        }
        filteredFlights.value = containCities
    }
    
    // FIND SELECTED FLIGHT ARRAY INDEX IN ALL FLIGHT LIST
    func findIndexNumber (index:Int){
        selectedItemNumber = 0
        for item in Helper.flightList{
            if item.code != filteredFlights.value?[index].code{
                selectedItemNumber+=1
            }else{
                break
            }
        }
    }
    
    // FIND SELECTED HOTEL ARRAY INDEX IN ALL HOTEL LIST

    func findHotelIndexNumber (index:Int){
        selectedItemNumber = 0
        Helper.hotelList?.append((filteredHotels.value?[index])!)
        for item in Helper.hotelList!{
            if item.code != filteredHotels.value?[index].code{
                selectedItemNumber+=1
            }else{
                print(selectedItemNumber)
                break
            }
        }
    }
    
    // FIND SEARCH HOTEL LIST

    func getHotelList (text:String){
        for item in cityList{
            if item[0].contains(text){
                NetworkUtils.getHotels(cityCode: item[1], number: 10) { hotels in
                    var hotelList:[Hotel] = []
                    for item in hotels{
                        hotelList.append(item)
                    }
                    self.filteredHotels.value = hotelList
                }
            }
        }
    }
}
