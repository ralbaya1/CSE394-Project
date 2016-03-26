//
//  food.swift
//  project
//
//  Created by Raid on 3/26/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import Foundation

class food {
    
    private var petId: Int = 0
    private var type: String = ""
    private var timeEaten: String = ""
    private var quantity: Double = 0
    
    func setId(id: Int)
    {
        petId = id
    }
    func getId() -> Int
    {
        return petId
    }
    func setType(foodType: String)
    {
        type = foodType
    }
    func getType() -> String
    {
        return type
    }
    func setTime(time: String)
    {
        timeEaten = time
    }
    func getTime() -> String
    {
        return timeEaten
    }
    func setQuantity(quan: Double)
    {
        quantity = quan
    }
    func getQuantity() -> Double
    {
        return quantity
    }
}
