//
//  vetVisit.swift
//  project
//
//  Created by Raid on 3/26/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import Foundation

class vetVisit {
    
    private var petId: Int = 0
    private var date: String = ""
    private var address: String = ""
    private var comment: String = ""
    
    func setId(id: Int)
    {
        petId = id
    }
    func getId() -> Int
    {
        return petId
    }
    func setDate(visitDate: String)
    {
        date = visitDate
    }
    func getDate() -> String
    {
        return date
    }
    func setAddress(add: String)
    {
        address = add
    }
    func getAddress() -> String
    {
        return address
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