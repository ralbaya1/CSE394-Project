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
    
    
    
    
    @IBAction func save(sender: UIButton) {
        
        let fetchRequest = NSFetchRequest(entityName: "Pet")
        
        if  let fetchResults = (try? context.executeFetchRequest(fetchRequest)) as? [Pet]
        {
            
            
            let x = fetchResults.count
            
            
            
            print(x)
            if x != 0 {
                
                let petInfo = fetchResults[0]
                petInfo.picture = petImage.image
                petInfo.name = petInfo.name
                
                petImage.image = UIImage(data: petInfo.picture!  as NSData)
                petName.text = petInfo.name
            }
            else
            {
                self.performSegueWithIdentifier("firstTimeUser", sender: nil)
            }
            
        }
        
        if let name = petName.text
        {
            let ent = NSEntityDescription.entityForName("Pet", inManagedObjectContext: self.context)
            
            let newItem = Pet(entity: ent!, insertIntoManagedObjectContext: self.context)
            
            newItem.name = name
            
            let imageData = UIImagePNGRepresentation(petImage.image!)
            
            newItem.picture = imageData
            
            do {
                try context.save()
            } catch _ {
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        petName.text = pName
        petImage.image = pImage
        
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
    
    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "edit"
        {
            let dest: petRegistrationViewController =  segue.destinationViewController as! petRegistrationViewController
            dest.pName = petName.text
            dest.pImage = petImage.image
            
        }
        
    }

}
