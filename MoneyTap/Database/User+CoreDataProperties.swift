//
//  User+CoreDataProperties.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/24/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var pageid: Int64
    @NSManaged public var url: String?

}
