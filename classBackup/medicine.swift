//
//  medicine.swift
//  project
//
//  Created by Raid on 3/26/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import Foundation

class medicine {
    
    private var petId: Int = 0
    private var name: String = ""
    private var instruction: String = ""
    private var timeTaken: String = ""
    private var frequency: Double = 0
    
    func setId(id: Int)
    {
        petId = id
    }
    func getId() -> Int
    {
        return petId
    }
    func setName(medicineName: String)
    {
        name = medicineName
    }
    func getName() -> String
    {
        return name
    }
    func setInstruction(instr: String)
    {
        instruction = instr
    }
    func getInstruction() -> String
    {
        return instruction
    }
    func setTimeTaken(time: String)
    {
        timeTaken = time
    }
    func getTimeTaken() -> String
    {
        return timeTaken
    }
    func setFrequency(freq: Double)
    {
        frequency = freq
    }
    func getFrequency() -> Double
    {
        return frequency
    }
}