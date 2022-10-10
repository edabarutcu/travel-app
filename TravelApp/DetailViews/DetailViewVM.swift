//
//  DetailViewVM.swift
//  TravelApp
//
//  Created by eda on 3.10.2022.
//



import Foundation
import SwiftyJSON

class DetailViewVM:ObservableObject{
    
    var hotelsArray = Binder<[Hotel]> ()
    var flightArray = Binder<[FlightList]> ()

    
    func startApp (){
        flightArray.value = Helper.flightList
        hotelsArray.value = Helper.hotelList
    }


}
