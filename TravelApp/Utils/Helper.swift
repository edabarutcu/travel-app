//
//  Helper.swift
//  TravelApp
//
//  Created by eda on 4.10.2022.
//

import Foundation
import UIKit
class Helper{
    static var hotelList : [Hotel]?
    static var flightList : [FlightList] = []
    
    // FOR DETECT CITIES IATA CODES
    static var cityList = [["zonguldak Çaycuma Havalimanı"  ,  "ONQ"],["van Ferit Melen Havalimanı"  ,  "VAN"],["sinop Havalimanı"  ,  "NOP"],["uşak Havalimanı"  ,  "USQ"],["trabzon Havalimanı"  ,  "TZX"],["tekirdağ Çorlu Havalimanı"  ,  "TEQ"],["şanlıurfa GAP Havalimanı"  ,  "GNY"],["sivas Nuri Demirağ Havalimanı"  ,  "VAS"],["samsun Çarşamba Havalimanı"  ,  "SZF"],["ordu Giresun Havalimanı"  ,  "OGU"],["nevşehir Kapadokya Havalimanı"  ,  "NAV"],["muğla Milas-Bodrum Havalimanı"  ,  "BJV"],["muğla Dalaman Havalimanı"  ,  "DLM"],["malatya Havalimanı"  ,  "MLX"],["kütahya Zafer Havalimanı"  ,  "KZR"],["konya Havalimanı"  ,  "KYA"],["kocaeli Cengiz Topel Havalimanı"  ,  "KCO"],["kayseri Havalimanı"  ,  "ASR"],["kars Harakani Havalimanı"  ,  "KSY"],["istanbul Sabiha Gökçen Havalimanı"  ,  "SAW"],["izmir Adnan Menderes Havalimanı"  ,  "ADB"],["istanbul Havalimanı"  ,  "IST"],["ısparta Süleyman Demirel Havalimanı"  ,  "ISE"],["hatay Havalimanı"  ,  "HTY"],["gaziantep Havalimanı"  ,  "GZT"],["eskişehir Hasan Polatkan Havalimanı"  ,  "AOE"],["erzurum Havalimanı"  ,  "ERZ"],["elazığ Havalimanı"  ,  "EZS"],["diyarbakır Havalimanı"  ,  "DIY"],["denizli Çardak Havalimanı"  ,  "DNZ"],["çanakkale Havalimanı"  ,  "CKZ"],["bursa Yenişehir Havalimanı"  ,  "YEI"],["balıkesir Kocaseyit Havalimanı"  ,  "EDO"],["antalya Havalimanı"  ,  "AYT"],["alanya Gazipaşa Havalimanı"  ,  "GZP"],["ankara Esenboğa Havalimanı"  ,  "ESB"],["adana Havalimanı"  ,  "ADA"]]
    
    
    // DATE FORMATTERS
    static func flightDateFormatter(dateStr:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"
        
        let date: Date? = dateFormatterGet.date(from: dateStr)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
        
    }
    
    static func flightTimeDateFormatter(dateStr:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        
        let date: Date? = dateFormatterGet.date(from: dateStr)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
        
    }
}


extension UIView{
    
    func activityStartAnimating() {
        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        let backgroundView = currentWindow?.viewWithTag(475647) ?? UIView()
        if backgroundView != currentWindow?.viewWithTag(475647) {
            backgroundView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            backgroundView.tag = 475647
            var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = .gray
            activityIndicator.color = .white
            activityIndicator.startAnimating()
            activityIndicator.style = .whiteLarge
            self.isUserInteractionEnabled = false
            backgroundView.addSubview(activityIndicator)
            if let cwindow = currentWindow {
                cwindow.addSubview(backgroundView)
            }
        }
    }
    
    func activityStopAnimating() {
        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        if let cWindow = currentWindow {
            if let background = cWindow.viewWithTag(475647){
                background.removeFromSuperview()
            }
            self.isUserInteractionEnabled = true
        }
    }
}
