//
//  RecordDetailViewController.swift
//  iOSTest01
//
//  Created by Chace Teera on 19/09/2017.
//  Copyright © 2017 Beep!. All rights reserved.
//

import UIKit

struct RecordEdit {
    
    static var oldRecord: Record?
    
    static var name: String?
    static var quantity: Int?
    static var date: Date?
}

class RecordDetailViewController: UIViewController {
    
    // Mark: Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var quantityCount: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var record: Record!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.text = record.name
        quantityCount.text = String(record.quantity)
        stepper.value = Double(record.quantity)
        
    }
    
    func dismissView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "initialView") as! InitialViewController
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func stepper(_ sender: UIStepper) {
        quantityCount.text = String(Int(sender.value))
    }
    
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        
        let stringFromDate = Date().iso8601
        
        if let dateFromString = stringFromDate.dateFromISO8601 {
            
            RecordManager.shared.editRecords(withUUID: record.uuid!, name: nameField.text!, quantity: Int(quantityCount.text!)!, date: dateFromString, synched: false)
        }
        dismissView()
    }
}
