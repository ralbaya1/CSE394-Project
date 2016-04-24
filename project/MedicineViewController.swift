//
//  MedicineViewController.swift
//  project
//
//  Created by Tse on 4/23/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import CoreData
import UIKit

class MedicineViewController: UIViewController,NSFetchedResultsControllerDelegate,UINavigationControllerDelegate
{
    @IBOutlet weak var medicineHistoryTable: UITableView!
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    @IBOutlet weak var instructionField: UITextField!
    @IBOutlet weak var freqField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    var medicine:Medicine? = nil
    
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
        let fetchRequest = NSFetchRequest(entityName: "Medicine")
        //sorted by date
        let sortDescripter = NSSortDescriptor(key: "timeTaken", ascending: false)
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
        let cell = self.medicineHistoryTable.dequeueReusableCellWithIdentifier("medicineCell", forIndexPath: indexPath)
        let medicineInfo = dataViewController.objectAtIndexPath(indexPath) as! Medicine
        let inst = medicineInfo.instruction
        let freq = medicineInfo.frequency
        let time = medicineInfo.timeTaken
        let name = medicineInfo.name
        
        //formating the date
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(time!)
        
        // after assign tags to each label in text the labels are assigned
        let nameLbl = cell.contentView.viewWithTag(20) as! UILabel
        let timeLabel = cell.contentView.viewWithTag(30) as! UILabel
        timeLabel.text = "\(DateInFormat)"
        nameLbl.text = name!
        
        
        return cell
        
    }
    
    // make table editable
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    //delete the cell that is swiped left
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let record = dataViewController.objectAtIndexPath(indexPath) as! Medicine
            context.deleteObject(record)
            do {
                try context.save()
            } catch _ {
            }
            
        }
    }
    
    
    @IBAction func onAddMedButton(sender: AnyObject)
    {

        if let name = nameField.text
        {
            let ent = NSEntityDescription.entityForName("Medicine", inManagedObjectContext: self.context)
            
            let newItem = Medicine(entity: ent!, insertIntoManagedObjectContext: self.context)
            
            newItem.name = name
            
            newItem.timeTaken = NSDate()
            newItem.frequency = Int(freqField.text!)
            newItem.instruction = instructionField.text!
            print("\(newItem.frequency!)")
            
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
        self.medicineHistoryTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
