//
//  foodViewController.swift
//  project
//
//  Created by Raid on 4/18/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit
import CoreData

class foodViewController: UIViewController ,NSFetchedResultsControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var foodType: UITextField!
    
    @IBOutlet weak var quantityValue: UITextField!
    
    @IBOutlet weak var foodTableView: UITableView!
    
    
    //a fetch variable
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    var food:Food? = nil
    
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
        let fetchRequest = NSFetchRequest(entityName: "Food")
        //sorted by date
        let sortDescripter = NSSortDescriptor(key: "time_Eaten", ascending: false)
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
        
    }
    
    //////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let calender = NSCalendar.currentCalendar()
        //print(calender)
        // Do any additional setup after loading the view, typically from a nib.
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
        let cell = self.foodTableView.dequeueReusableCellWithIdentifier("foodCell", forIndexPath: indexPath)
        let foodInfo = dataViewController.objectAtIndexPath(indexPath) as! Food
        let type = foodInfo.type
        let date = foodInfo.time_Eaten
        let quant = foodInfo.quantity
        
        //formating the date
        //var todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(date!)
        
        // after assign tags to each label in text the labels are assigned
        let dateLabl = cell.contentView.viewWithTag(4) as! UILabel
        let fType = cell.contentView.viewWithTag(3) as! UILabel
        
        
        dateLabl.text = "\(DateInFormat)"
        fType.text = type! + String(quant)
        
        return cell
        
    }
    
    // make table editable
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let record = dataViewController.objectAtIndexPath(indexPath) as! Food
            context.deleteObject(record)
            do {
                try context.save()
            } catch _ {
            }
            
        }
    }
    
    // When Feed button is pressed the time the pet is Feed and the
    // type and quantity are stored.

    @IBAction func feed(sender: UIButton) {
        if let fType = foodType.text
        {
            let ent = NSEntityDescription.entityForName("Food", inManagedObjectContext: self.context)
            
            let newItem = Food(entity: ent!, insertIntoManagedObjectContext: self.context)
            
            newItem.type = fType
            
            newItem.quantity = Int(quantityValue.text!)
            
            newItem.time_Eaten = NSDate()
            
            /*if let navController = self.navigationController {
             navController.popViewControllerAnimated(true)
             }*/
            do {
                try context.save()
            } catch _ {
            }
            
        }
        
    }
    
    
    
    //reload tableview if data changed.
    func controllerDidChangeContent(controller: NSFetchedResultsController)
    {
        self.foodTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
