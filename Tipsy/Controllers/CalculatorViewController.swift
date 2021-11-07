//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var tip: Float = 0.0
    var stringResult = ""
    
    //MARK: - IBOutlets
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    //MARK: - IBActions
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        if sender == zeroPctButton {
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            tip = 0.0
        } else if sender == tenPctButton {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
            tip = 0.1
        } else {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
            tip = 0.2
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let sum = Float(billTextField.text ?? "0") ?? 0
        let tips = sum * tip
        let split = Float(splitNumberLabel.text ?? "1") ?? 0
        let result = (sum + tips) / split
        stringResult = String(format: "%.2f", result)
        print(stringResult)
        
        performSegue(withIdentifier: "showResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let resultVC = segue.destination as! ResultsViewController
            resultVC.result = stringResult
            resultVC.tips = String(tip * 100)
            resultVC.people = splitNumberLabel.text ?? "Smth wrong"
            
        }
    }
}

