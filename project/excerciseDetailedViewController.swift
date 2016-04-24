//
//  excerciseDetailedViewController.swift
//  project
//
//  Created by Raid on 4/23/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit

class excerciseDetailedViewController: UIViewController {

    var dur:Int!
    var desc:String!
    
    @IBOutlet weak var duration: UILabel!

    @IBOutlet weak var descript: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        duration.text = String(dur!)
        descript.text = desc
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
