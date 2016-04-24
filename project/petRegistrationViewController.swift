//
//  petRegistrationViewController.swift
//  project
//
//  Created by Raid on 4/18/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit
import CoreData

class petRegistrationViewController: UIViewController ,NSFetchedResultsControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var pName:String!
    var pImage:UIImage!
    
    @IBOutlet weak var petName: UITextField!
    
    @IBOutlet weak var petImage: UIImageView!
    
    @IBAction func selectPicture(sender: UIButton) {
        let photoPicker = UIImagePickerController ()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        // display image selection view
        self.presentViewController(photoPicker, animated: true, completion: nil)
        
    }
    
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    
    //var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
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
    
    
    
    
    @IBAction func save(sender: UIButton) {
        
        let fetchRequest = NSFetchRequest(entityName: "Pet")
        
        if  let fetchResults = (try? context.executeFetchRequest(fetchRequest)) as? [Pet]
        {
            // if there is a valid name it saves the attributes
            if let name = petName.text
            {
                let x = fetchResults.count
                // if the fetched is not empty update the image
                if x != 0 {
                    
                    let petInfo = fetchResults[0]
                    petInfo.name = name
                    //convert image to NSData then save to coredata
                    let imageNsdata = UIImagePNGRepresentation(petImage.image!)
                    petInfo.picture = imageNsdata!
                    do {
                        try context.save()
                    } catch _ {}
                    // then go back to different view
                    if let navController = self.navigationController
                    {
                        navController.popViewControllerAnimated(true)
                    }
                }
                    // if the coredata is empty then save as first time user and go back to homepage
                else
                {
                    let ent = NSEntityDescription.entityForName("Pet", inManagedObjectContext: self.context)
                    
                    let newItem = Pet(entity: ent!, insertIntoManagedObjectContext: self.context)
                    
                    newItem.name = name
                    //convert image to NSData then save to coredata
                    let imageData = UIImagePNGRepresentation(petImage.image!)
                    
                    newItem.picture = imageData!
                    
                    do {
                        try context.save()
                    } catch _ {
                    }
                    // after saving go to homepage
                    if let navController = self.navigationController
                    {
                        navController.popViewControllerAnimated(true)
                    }
                }
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //petName.text = pName
        //petImage.image = pImage
        
        //let calender = NSCalendar.currentCalendar()
        //print(calender)
        // Do any additional setup after loading the view, typically from a nib.
        //setup datacontroller
        //dataViewController = getFetchResultsController()
        // use data controller to fetch
        
        //dataViewController.delegate = self
        //do {
        //    try dataViewController.performFetch()
        //} catch _ {
        //}
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        picker .dismissViewControllerAnimated(true, completion: nil)
        petImage.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
    }
    
    /*override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     
     let dest: petRegistrationViewController =  segue.destinationViewController as! petRegistrationViewController
     dest.pName = petName.text
     dest.pImage = petImage.image
     
     }*/

}
