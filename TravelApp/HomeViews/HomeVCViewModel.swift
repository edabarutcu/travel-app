//
//  HomeVCViewModel.swift
//  TravelApp
//
//  Created by eda on 1.10.2022.
//


import Foundation
import SwiftyJSON
import UIKit

class ViewControllerViewModel:ObservableObject{
    
    var dialog = ["Beautiful Alley Scene in Old Town in Europe at Sunset","The Ultimate Guide to Shopping for Travel"]
    var title = ["EXPERIENCE","SHOPPING"]
    var photos = [UIImage(named: "homeImage-1"),UIImage(named: "homeImage-2")]

    func startApp () {
        NetworkUtils.getFlightList(airLines: "PC")
        NetworkUtils.getFlightList(airLines: "TK")
    }
    
    func callServices (){
        NetworkUtils.getHotels(cityCode: "ABC", number: 50, callBackFunc: callback)
    }
    
    func callback (res:[Hotel]) {
        
        Helper.hotelList = res
    }
}


