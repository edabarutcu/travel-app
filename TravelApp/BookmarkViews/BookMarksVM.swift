//
//  BookMarksVM.swift
//  TravelApp
//
//  Created by eda on 7.10.2022.
//

import Foundation
import SwiftyJSON

class BookMarksVM:ObservableObject{
    
    var selectedHotelIndex : Int = 0
    var trips = Binder<[CoreDataModel]>()
    
    func setAssetStatus (){
        trips.value = CoreDataManager.shared.getAllTrips()
    }
    
    func findSelectedNumberOfItem (index:Int){
        var indexnum = 0
        for item in Helper.hotelList!{
            if item.code == trips.value?[index].code{
                selectedHotelIndex=indexnum
            }else{
                indexnum+=1
            }
            
        }
    }
}
