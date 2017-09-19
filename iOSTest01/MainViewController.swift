//
//  ViewController.swift
//  iOSTest01
//
//  Created by Chace Teera on 18/09/2017.
//  Copyright © 2017 Beep!. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Record")
    let context = PersistenceService.context
    var records = [Record]()
    var record: Record!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    
    
    
    
    func getData() {
        
        
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordCell
        
        cell.nameLbl.text = records[indexPath.row].name
        cell.quantityLbl.text = "Quantity: \(String(records[indexPath.row].quantity))"
        cell.dateLbl.text = dateString(date: records[indexPath.row].date as! Date)
        
        return cell
    }
    
    // Swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // delete task
            let record = records[indexPath.row]
            RecordManager.shared.removeRecord(withUUID: record.uuid!)
            
            //animation
            records.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            getData()
        }
    }
    
    func dateString(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy, hh:mm"
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "recordDetail"){
            
            let cell = sender as? RecordCell
            let indexPath = tableView.indexPath(for: cell!)
            
            let item: Record
            item = self.records[indexPath!.row]
            
            let dvc = segue.destination as! RecordDetailViewController
            dvc.record = item
        }
    }
}

