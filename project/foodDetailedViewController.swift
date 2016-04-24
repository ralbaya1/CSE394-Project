//
//  foodDetailedViewController.swift
//  project
//
//  Created by Raid on 4/23/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit


class foodDetailedViewController: UIViewController {
    
    var fType:String!
    var quan:Int!
    

    @IBOutlet weak var foodType: UILabel!

    @IBOutlet weak var quantity: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        foodType.text = fType
        quantity.text = String(quan) + " Cups"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
