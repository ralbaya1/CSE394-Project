//
//  medicineDetailedViewController.swift
//  project
//
//  Created by Raid on 4/23/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit

class medicineDetailedViewController: UIViewController {
    
    var medName:String!
    var frequency:Int!
    var instruction:String!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var freq: UILabel!
    
    @IBOutlet weak var instr: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        name.text = medName
        freq.text = String(frequency)
        instr.text = instruction
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
