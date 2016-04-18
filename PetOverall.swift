//
//  PetOverall.swift
//  project
//
//  Created by Tse on 4/14/16.
//  Copyright © 2016 Raid. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PetOverall
{
    private var medList :[Medicine]?
    private var exerciseList :[Exercise]?
    private var groomList:[Grooming]?
    private var vetList: [Vet]?
    private var foodList: [Food]?
    private var pet: Pet?
    
    
    init(med:Medicine, exer: Exercise, groom:Grooming, vet:Vet, food:Food, pet:Pet) {
        self.pet? = pet
        self.vetList?.append(vet)
        self.medList?.append(med)
        self.groomList?.append(groom)
        self.foodList?.append(food)
        self.exerciseList?.append(exer)
    }
    func setPet(p:Pet)
    {
        self.pet! = p
    }
    func getPet() -> Pet
    {
        return pet!
    }
    
    func addMedicine(medicine:Medicine)
    {
        self.medList?.append(medicine)
    }
    
    func addExercise(exercise:Exercise)
    {
        self.exerciseList?.append(exercise)
    }
    
    func addGrooming(groom:Grooming)
    {
        self.groomList?.append(groom)
    }
    
    func addVet(vet:Vet)
    {
        self.vetList?.append(vet)
    }
    
    func addFood(food:Food)
    {
        self.foodList?.append(food)
        
    }
    
    func saveMedicine(name:String, instruction:String) -> Bool
    {
        var saved:Bool = false
        let insertContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let ent = NSEntityDescription.entityForName("Medicine", inManagedObjectContext:insertContext)
        let newItem = Medicine(entity: ent!, insertIntoManagedObjectContext: insertContext)
        /*newItem.frequency  = selectedImage.description
        let imageData = UIImagePNGRepresentation(selectedImage.image!)
        
        newItem.picture = imageData!
        
        do {
            try self.insertContext?.save()
        } catch _ {
        }
        */
        
        
        return saved
    }
    
    func fetchPet()
    {
    
    
    }
    
}