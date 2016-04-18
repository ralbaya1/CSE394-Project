//
//  pet.swift
//  project
//
//  Created by Raid on 3/26/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import Foundation

class pet {
    private var id: Int = 0
    private var name: String = ""
    
    init(petId: Int, petName: String)
    {
        id = petId
        name = petName
    }
    
    func setId(petId: Int)
    {
        id = petId
    }
    
    func getId()-> Int
    {
        return id
    }
    
    func setName (petName: String)
    {
        name = petName
    }
    
    func getName() -> String
    {
        return name
    }
    
}