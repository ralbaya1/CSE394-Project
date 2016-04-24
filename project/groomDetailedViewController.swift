//
//  groomDetailedViewController.swift
//  project
//
//  Created by Raid on 4/23/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit

class groomDetailedViewController: UIViewController {
    
    var comment:String!
    
    @IBOutlet weak var com: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        com.text = comment
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
