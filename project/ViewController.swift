//
//  ViewController.swift
//  project
//
//  Created by Raid on 3/25/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,NSFetchedResultsControllerDelegate {
    var name:String!
    var pImage:UIImage!
    
    @IBOutlet weak var petName: UILabel!
    
    @IBOutlet weak var petImage: UIImageView!
    
    
    //a fetch variable
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func getFetchResultsController() -> NSFetchedResultsController
    {
        dataViewController = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return dataViewController
    }
    
    //method to fetch from the coredata
    func listFetchRequest() -> NSFetchRequest
    {
        //identified entity to fetch
        let fetchRequest = NSFetchRequest(entityName: "Pet")
        
        return fetchRequest
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let fetchRequest = NSFetchRequest(entityName: "Pet")
        
        if  let fetchResults = (try? context.executeFetchRequest(fetchRequest)) as? [Pet]
        {
            
            
            let x = fetchResults.count
            if x != 0 {
                
                let petInfo = fetchResults[0]
                self.petImage.image = UIImage(data: petInfo.picture!  as NSData)
                self.petName.text = petInfo.name
                
                petImage.image = UIImage(data: petInfo.picture!  as NSData)
                petName.text = petInfo.name
            }
            else
            {
                self.performSegueWithIdentifier("firstTime", sender: nil)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
        
        if segue.identifier == "firstTime"
        {
            let dest: petRegistrationViewController =  segue.destinationViewController as! petRegistrationViewController
            dest.pName = petName.text
            dest.pImage = petImage.image
            
        }
        
        if segue.identifier == "edit"
        {
            let dest: petRegistrationViewController =  segue.destinationViewController as! petRegistrationViewController
            dest.pName = petName.text
            dest.pImage = petImage.image
            
        }
        
    }
    
    
}
