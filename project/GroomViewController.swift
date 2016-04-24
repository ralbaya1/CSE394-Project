//
//  GroomViewController.swift
//  project
//
//  Created by Tse on 4/16/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit
import CoreData

class GroomViewController: UIViewController ,NSFetchedResultsControllerDelegate,UINavigationControllerDelegate {
    //////////
    @IBOutlet weak var groomTableView: UITableView!
    
    @IBOutlet weak var groomingCommentsText: UITextField!
    
    //a fetch variable
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    var grooming:Grooming? = nil
    
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
        let fetchRequest = NSFetchRequest(entityName: "Grooming")
        //sorted by date
        let sortDescripter = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
        
    }
    
    //////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setup datacontroller
        dataViewController = getFetchResultsController()
        // use data controller to fetch
        
        dataViewController.delegate = self
        do {
            try dataViewController.performFetch()
        } catch _ {
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections  = dataViewController.sections?.count
        return numberOfSections!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = dataViewController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.groomTableView.dequeueReusableCellWithIdentifier("groomCell", forIndexPath: indexPath)
        let groomingInfo = dataViewController.objectAtIndexPath(indexPath) as! Grooming
        let comment = groomingInfo.comment
        let groomDate = groomingInfo.date
        
        //formating the date
        //var todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(groomDate!)
        
        // after assign tags to each label in text the labels are assigned
        let dateLabl = cell.contentView.viewWithTag(2) as! UILabel
        //let commLbl = cell.contentView.viewWithTag(1) as! UILabel
        dateLabl.text = "\(DateInFormat)"
        //commLbl.text = comment
        //dateLabl.text = "\(groomDate)"
        //commLbl.text = comment
    
        return cell
        
    }
    
    // make table editable
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let record = dataViewController.objectAtIndexPath(indexPath) as! Grooming
            context.deleteObject(record)
            do {
                try context.save()
            } catch _ {
            }
            
        }
    }
   
    // When groom button is pressed the time the pet is groomed and the 
    // comments are stored.
    @IBAction func onGroomButton(sender: UIButton)
    {
        if let comment = groomingCommentsText.text
        {
            let ent = NSEntityDescription.entityForName("Grooming", inManagedObjectContext: self.context)
            
            let newItem = Grooming(entity: ent!, insertIntoManagedObjectContext: self.context)
            
            newItem.comment = comment
            
            newItem.date = NSDate()
            
            do {
                try context.save()
            } catch _ {
            }
            // pop the view and go back to activities pages after saving
            
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }

        }
        
    }
    
    
    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let dest: groomDetailedViewController =  segue.destinationViewController as! groomDetailedViewController
        let indexPath = groomTableView.indexPathForCell(sender as! UITableViewCell)
        let cell = dataViewController.objectAtIndexPath(indexPath!) as! Grooming
        
        dest.comment = cell.comment

        
        
    }
    

    //reload tableview if data changed.
    func controllerDidChangeContent(controller: NSFetchedResultsController)
    {
        self.groomTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

