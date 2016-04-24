//
//  vetVisitViewController.swift
//  project
//
//  Created by Raid on 4/18/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit
import CoreData

class vetVisitViewController: UIViewController ,NSFetchedResultsControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var vetHistoryTable: UITableView!
    //a fetch variable
    @IBOutlet weak var addressField: UITextField!
    
    @IBOutlet weak var commentsField: UITextField!
    
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    var vet:Vet? = nil
    
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
        let fetchRequest = NSFetchRequest(entityName: "Vet")
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
        let cell = self.vetHistoryTable.dequeueReusableCellWithIdentifier("vetCell", forIndexPath: indexPath)
        let vetInfo = dataViewController.objectAtIndexPath(indexPath) as! Vet
        let comment = vetInfo.comment
        let visitDate = vetInfo.date
        let address = vetInfo.address
        
        //formating the date
        //var todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(visitDate!)
        
        // after assign tags to each label in text the labels are assigned
        let dateLabl = cell.contentView.viewWithTag(8) as! UILabel
        let addLbl = cell.contentView.viewWithTag(9) as! UILabel
        dateLabl.text = "\(DateInFormat)"
        addLbl.text = address

        
        return cell
        
    }
    
    // make table editable
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let record = dataViewController.objectAtIndexPath(indexPath) as! Vet
            context.deleteObject(record)
            do {
                try context.save()
            } catch _ {
            }
            
        }
    }
    
    // When save button is pressed the time the pet visited vet and the
    // comments are stored.
    
    @IBAction func onSaveVisitBtn(sender: AnyObject)
    {
 
        if let addr = self.addressField.text
        {
            let ent = NSEntityDescription.entityForName("Vet", inManagedObjectContext: self.context)
            
            let newItem = Vet(entity: ent!, insertIntoManagedObjectContext: self.context)
            
            newItem.address = addr
            newItem.comment = commentsField.text
            
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
    
    
    
    //reload tableview if data changed.
    func controllerDidChangeContent(controller: NSFetchedResultsController)
    {
        self.vetHistoryTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
