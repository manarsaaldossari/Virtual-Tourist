//
//  DataController.swift
//  VirtualTourist
//
//  Created by manar Aldossari on 07/06/1440 AH.
//  Copyright © 1440 MacBook Pro. All rights reserved.
//

import Foundation
import CoreData
class  DataController{
    
    let persistentContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    let backgroundContext:NSManagedObjectContext!
    
    //initlaizer
    init(modelName:String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        
        backgroundContext = persistentContainer.newBackgroundContext()
    }
    
    func configureContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autoSaveViewContext()
            self.configureContexts()
            completion?()
        }
    }
    
    func fetchPins(viewContext: NSManagedObjectContext)->[Pin]{
        let fetchRequest : NSFetchRequest<Pin> = Pin.fetchRequest()
        if let fetchedPins = try? viewContext.fetch(fetchRequest){
            return fetchedPins
        }
        
        return []
    }
}

extension DataController {
    func autoSaveViewContext(interval:TimeInterval = 30) {
        
        guard interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext(interval: interval)
        }
    }
}
