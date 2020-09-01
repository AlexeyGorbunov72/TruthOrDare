//
//  APIDatabase.swift
//  TruthOrDare
//
//  Created by Alexey on 30.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class APIDatabase: PacksManager{
    
    private func getLastIdPack(context: NSManagedObjectContext)-> Int16?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PackModel")
        fetchRequest.fetchLimit = 1
        let sort = NSSortDescriptor(key: #keyPath(PackModel.id), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        do {
            let pack = try context.fetch(fetchRequest)
            if pack.count > 0{
                return ((pack[0] as! PackModel).id as! Int16) + 1
            } else {
                return 0
            }
            
        } catch {
            print("Cannot fetch Expenses")
        }
        return nil
    }
    func getAllPacks(completionBlock: @escaping (Packs) -> Void){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PackModel")
        do {
            let packs = try context.fetch(fetchRequest)
            var packsToReturn = Packs(packs: [])
            packs.forEach{(pack) in
                if let pack = pack as? PackModel{
                    packsToReturn.packs.append(Pack(id: Int(pack.id),
                                                    title: pack.title!,
                                                    levelAction: pack.levelAction!,
                                                    levelTruth: pack.levelTruth!))
                }
            }
            completionBlock(packsToReturn)
            
        } catch {
            print("APIDatabase::getAllPacks - fails")
        }
    }
    func getPackContent(_ id: Int,completionBlock: @escaping (Tasks) -> Void){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        do{
            let tasks = try context.fetch(fetchRequest)
            var tasksToReturn = Tasks(pack: [])
            tasks.forEach{ (task) in
                if let task = task as? TaskModel{
                    tasksToReturn.pack.append(Task(levelOfHard: task.levelOfHard!,
                                                   content: task.content!,
                                                   isTruth: Int(task.isTruth)))
                }
            }
            completionBlock(tasksToReturn)
        } catch {
            print("APIDatabase::getPackContent - fails")
        }
    }
    func savePack(pack: Pack, tasks: [Task]){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let packModel = NSEntityDescription.entity(forEntityName: "PackModel", in: context)
        
        
        let newPack = NSManagedObject(entity: packModel!, insertInto: context)
        newPack.setValue(pack.title, forKey: "title")
        newPack.setValue(pack.levelAction, forKey: "levelAction")
        newPack.setValue(pack.levelTruth, forKey: "levelTruth")
        if let packId = getLastIdPack(context: context){
            newPack.setValue(packId, forKey: "id")
            saveTasks(tasks: tasks, packId: packId)
        }
        do {
           try context.save()
          } catch {
           print("APIDatabase::Failed saving")
        }
       
    }
    private func saveTasks(tasks: [Task], packId: Int16){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let taskModel = NSEntityDescription.entity(forEntityName: "TaskModel", in: context)
        
        tasks.forEach{(task) in
            
            let newTask = NSManagedObject(entity: taskModel!, insertInto: context)
            newTask.setValue(packId, forKey: "id")
            newTask.setValue(task.content, forKey: "content")
            newTask.setValue(task.levelOfHard, forKey: "levelOfHard")
            newTask.setValue(task.isTruth, forKey: "isTruth")
        }
    }
    
}


