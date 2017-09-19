//
//  RecordManager.swift
//  iOSTest01
//
//  Created by Chace Teera on 19/09/2017.
//  Copyright © 2017 Beep!. All rights reserved.
//

import Foundation
import CoreData


class RecordManager {
    
    static let shared = RecordManager()
    var record: Record!
    var records = [Record]()
    let context = PersistenceService.context
    let request = NSFetchRequest<Record>(entityName: "Record")
    
    func addRecord(name: String, quantity: Int, date: Date, synched: Bool, uuid: String) {
        
        let record = Record(context:context)
        record.name = name
        record.quantity = Int16(quantity)
        record.date = date as Date
        record.synched = synched
        record.uuid = uuid
        PersistenceService.saveContext()
    }
    
    func removeRecord(withUUID: String) {
        
        
        do {
            let searchResults = try context.fetch(request)
            
            for record in searchResults {
                
                if record.uuid == withUUID {
                    
                    // delete task
                    context.delete(record)
                }
            }
        } catch {
            print("Error with request: \(error.localizedDescription)")
        }
        PersistenceService.saveContext()
    }
    
    func editRecords(withUUID: String, name: String, quantity: Int, date: Date, synched: Bool) {
        
        do {
            let searchResults = try context.fetch(request)
            
            for record in searchResults {
                if record.uuid == withUUID {
                    
                    record.name = name
                    record.quantity = Int16(quantity)
                    record.synched = synched
                    record.date = date as Date
                    
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
        PersistenceService.saveContext()
    }
    
    func fetchRecord() -> [Record] {

        do {
            records = try context.fetch(Record.fetchRequest())

        } catch {
            print("Error fetching data from CoreData")
        }

        return records
    }
    
    
    
}
