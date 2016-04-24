//
//  vetVisitDetailedViewController.swift
//  project
//
//  Created by Raid on 4/23/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit

class vetVisitDetailedViewController: UIViewController {
    
    
    var add:String!
    var com:String!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var comment: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        address.text = add
        comment.text = com
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
