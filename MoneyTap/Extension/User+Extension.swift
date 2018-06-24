//
//  User+Extension.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/24/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import Foundation
import CoreData

extension User {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    class func saveObject(image: String, name: String, desc: String, pageid: Int64, url: String) -> Bool{
        
        let context = CoreDataHandler.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(image, forKey: "image")
        manageObject.setValue(name, forKey: "name")
        manageObject.setValue(desc, forKey: "desc")
        manageObject.setValue(pageid, forKey: "pageid")
        manageObject.setValue(url, forKey: "url")
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func fetchObject() -> [User]? {
        let context = CoreDataHandler.getContext()
        var user: [User]? = nil
        
        do {
            user = try context.fetch(User.fetchRequest())
            return user
        } catch {
            return user
        }
    }
    
    class func updateObject(pageid: Int64, url: String) -> Bool{
        let context = CoreDataHandler.getContext()
        do {
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.predicate = NSPredicate(format: "pageid == %d", pageid)
            let user: User = try context.fetch(request)[0]
            
            user.url = url
            
            do {
                try context.save()
                return true
            }
        } catch {
            return false
        }
    }
    
    class func fetchObject(pageid: Int64) -> User? {
        let context = CoreDataHandler.getContext()
        var user: User? = nil
        
        do {
            let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            userFetch.fetchLimit = 1
            userFetch.predicate = NSPredicate(format: "pageid = %d", pageid)
            user = try (context.fetch(userFetch).first as? User)
            return user
        } catch {
            return user
        }
    }
    
    class func deleteRecords() -> Bool {
        let context = CoreDataHandler.getContext()
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            return true
        } catch {
            print ("There was an error")
            return false
        }
    }
}
