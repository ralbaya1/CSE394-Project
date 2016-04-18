//
//  grooming.swift
//  project
//
//  Created by Raid on 3/26/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import Foundation

class grooming {
    
    private var petId: Int = 0
    private var date: String = ""
    private var comment: String = ""
    
    func setId(id: Int)
    {
        petId = id
    }
    func getId() -> Int
    {
        return petId
    }
    func setDate(groomDate: String)
    {
        date = groomDate
    }
    func getDate() -> String
    {
        return date
    }
    func setComment(comm: String)
    {
        comment = comm
    }
    func getComment() -> String
    {
        return comment
    }

    
}