//
//  exercise.swift
//  project
//
//  Created by Raid on 3/26/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import Foundation

class exercise {
    
    private var petId: Int = 0
    private var duration: String = ""
    private var time: String = ""
    private var description: String = ""

    func setId(id: Int)
    {
        petId = id
    }
    func getId() -> Int
    {
        return petId
    }
    func setDuration(dur: String)
    {
        duration = dur
    }
    func getDuration() -> String
    {
        return duration
    }
    func setTime(t: String)
    {
        time = t
    }
    func getTime() -> String
    {
        return time
    }
    func setDescription(desc: String)
    {
        description = desc
    }
    func getDescription() -> String
    {
        return description
    }
 
}