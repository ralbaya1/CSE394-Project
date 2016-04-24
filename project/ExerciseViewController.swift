//
//  ExerciseViewController.swift
//  project
//
//  Created by Tse on 4/23/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import UIKit
import CoreData

class ExerciseViewController: UIViewController,NSFetchedResultsControllerDelegate,UINavigationControllerDelegate
{
    
    @IBOutlet weak var exerciseHistoryTable: UITableView!
    
    @IBOutlet weak var durationField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    var exercise:Exercise? = nil
    
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
        let fetchRequest = NSFetchRequest(entityName: "Exercise")
        //sorted by date
        let sortDescripter = NSSortDescriptor(key: "time", ascending: false)
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
        let cell = self.exerciseHistoryTable.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath)
        let exerciseInfo = dataViewController.objectAtIndexPath(indexPath) as! Exercise
        //let duration = exerciseInfo.duration
        //let desc = exerciseInfo.discription
        let time = exerciseInfo.time
        
        //formating the date
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(time!)
        
        // after assign tags to each label in text the labels are assigned
        //let descLabel = cell.contentView.viewWithTag(5) as! UILabel
        let timeLabel = cell.contentView.viewWithTag(5) as! UILabel
        timeLabel.text = "\(DateInFormat)"
        //descLabel.text = desc!
   
        
        return cell
        
    }
    
    // make table editable
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    //delete the cell that is swiped left
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let record = dataViewController.objectAtIndexPath(indexPath) as! Exercise
            context.deleteObject(record)
            do {
                try context.save()
            } catch _ {
            }
            
        }
    }
    
    
    @IBAction func onAddExerciseButton(sender: AnyObject)
    {
        if let description1 = descriptionField.text
        {
            let ent = NSEntityDescription.entityForName("Exercise", inManagedObjectContext: self.context)
            
            let newItem = Exercise(entity: ent!, insertIntoManagedObjectContext: self.context)
            
            newItem.discription = description1
            
            newItem.time = NSDate()
            newItem.duration = Int(durationField.text!)
            print("\(newItem.duration!)")
            
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
        
        let dest: excerciseDetailedViewController =  segue.destinationViewController as! excerciseDetailedViewController
        let indexPath = exerciseHistoryTable.indexPathForCell(sender as! UITableViewCell)
        let cell = dataViewController.objectAtIndexPath(indexPath!) as! Exercise
        
        dest.dur = Int(cell.duration!)
        dest.desc = cell.discription
        
    }
    
    
    //reload tableview if data changed.
    func controllerDidChangeContent(controller: NSFetchedResultsController)
    {
        self.exerciseHistoryTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
