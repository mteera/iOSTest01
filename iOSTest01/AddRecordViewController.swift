//
//  AddRecordViewController.swift
//  iOSTest01
//
//  Created by Chace Teera on 19/09/2017.
//  Copyright © 2017 Beep!. All rights reserved.
//

import UIKit

class AddRecordViewController: UIViewController, UITextFieldDelegate {
    // Mark: Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var quantityCount: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self

        // Do any additional setup after loading the view.
    }

    @IBAction func stepperBtnTapped(_ sender: UIStepper) {
        quantityCount.text = String(Int16(sender.value))
    }

    @IBAction func saveBtnTapped(_ sender: Any) {
        
    }
    
    func goToInitialView() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "initialView") as! InitialViewController
        self.present(secondViewController, animated: true, completion: nil)
    }
}
