//
//  Binders.swift
//  TravelApp
//
//  Created by eda on 1.10.2022.
//

import Foundation
class Binder <T> {
    var value: T?{
        didSet{
            observer?(value)
        }
    }
    var observer:((T?)->())?
    func bind (observer:@escaping (T?)->()){
        self.observer = observer
    }
}
