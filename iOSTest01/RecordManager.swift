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
    
    func addRecord(name: String, uuid: String) {
        
        let record = Record(context:context)
        record.name = name
        record.record_id = uuid
        records.append(record)
        PersistenceService.saveContext()
    }
    
    func removeRecord(withUUID: String) {
        
        
        do {
            let searchResults = try context.fetch(request)
            
            for record in searchResults {
                
                if record.record_id == withUUID {
                    
                    // delete task
                    context.delete(record)
                }
            }
        } catch {
            print("Error with request: \(error.localizedDescription)")
        }
        PersistenceService.saveContext()
    }
    
    func editRecords(withUUID: String, name: String) {
        
        do {
            let searchResults = try context.fetch(request)
            
            for record in searchResults {
                if record.record_id == withUUID {
                    
                    record.name = name
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
    
    func sendRecordToServer() -> [Record] {
        
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName:"Record")
        fetchRequest.resultType = .dictionaryResultType
        do {
            let records = try context.fetch(fetchRequest)
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: records, options: []) {
                // jsonData is a byte sequence, to view it you would need to convert to string
                print(String(bytes: jsonData, encoding: String.Encoding.utf8))
                
                let URL_SAVE_DATA = URL(string: "http://localhost/api/postdata.php")
                let request = NSMutableURLRequest(url: URL_SAVE_DATA!)
                
                request.httpMethod = "POST"
                request.httpBody = jsonData
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    
                    guard let data = data, error == nil else {
                        // check for fundamental networking error
                        print("error=\(String(describing: error?.localizedDescription))")
                        return
                    }
                    
                    let responseString = String(data: data, encoding: .utf8)
                    print("responseString = \(String(describing: responseString))")
                }
                task.resume()
            }
            
        } catch {
            print("Error fetching data from CoreData")
        }
        return records
    }
    
    
    
}
