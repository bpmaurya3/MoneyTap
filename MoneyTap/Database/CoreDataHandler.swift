//
//  CoreDataHandler.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/24/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler {
    class func getContext() -> NSManagedObjectContext{
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        return appdelegate.persistentContainer.viewContext
    }
}
