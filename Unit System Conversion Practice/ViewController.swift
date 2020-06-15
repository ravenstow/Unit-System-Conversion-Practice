//
//  ViewController.swift
//  Unit System Conversion Practice
//
//  Created by susanne on 2020/6/12.
//  Copyright © 2020 Mike Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    var inMetricMode: Bool!
    
    @IBOutlet var lengthDescription: UILabel!
    @IBOutlet var lengthTextField: UITextField!
    @IBOutlet var widthDescription: UILabel!
    @IBOutlet var widthTextField: UITextField!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var metricButton: UIButton!
    @IBOutlet var imperialButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        resultLabel.layer.cornerRadius = 10.0
        metricButton.layer.cornerRadius = 5.0
        imperialButton.layer.cornerRadius = 5.0
        inMetricMode = true
    }

    // Disable Keyboard from screen when tapped elsewhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0) {
            self.view.endEditing(true)
        }
    }
    
    // Texfield touched to edit, pop-up input Reminder
    @IBAction func textFieldsEditBegan(_ sender: UITextField) {
        performSegue(withIdentifier: "popoverSegue", sender: sender)
    }
    
    // Whenver Edit has been changed, update result as possible
    @IBAction func textFieldsEditChanged(_ sender: UITextField) {
        
        // Checking Numeric inputs, DO NOTHING if either is INVALID
        guard let lengthInput = lengthTextField.text,
        let length = Double(lengthInput),
        let widthInput = widthTextField.text,
            let width = Double(widthInput) else { return }
        
        let area = areaCalculation(by: length, and: width)
        
        // Show Result in Metric Mode
        if inMetricMode == true {
            summaryLabel.text = "You entered dimensions of" + "\n" +
            "\(length) meters by \(width) meters"
            
            let result = convertMeterToFootBySquare(with: area)
            resultLabel.text = "The area is" + "\n"
            + String(result) + " in feet"
            
        // Show Result in Imperial Mode
        } else {
            summaryLabel.text = "You entered dimensions of" + "\n" +
            "\(length) feet by \(width) feet"
            
            let result = convertFootToMeterBySquare(with: area)
            resultLabel.text = "The area is" + "\n"
            + String(result) + " in meters"
        }
    }
    
    @IBAction func textFieldsEditEnd(_ sender: UITextField) {
        // Checking Numeric Inputs
        if let lengthInput = lengthTextField.text,
            let length = Double(lengthInput),
            let widthInput = widthTextField.text,
            let width = Double(widthInput) {
            let area = areaCalculation(by: length, and: width)
            
            // Show Result in Metric Mode
            if inMetricMode == true {
                summaryLabel.text = "You entered dimensions of" + "\n" +
                "\(length) meters by \(width) meters"
                
                let result = convertMeterToFootBySquare(with: area)
                resultLabel.text = "The area is" + "\n"
                + String(result) + " in feet"
                
            // Show Result in Imperial Mode
            } else {
                summaryLabel.text = "You entered dimensions of" + "\n" +
                "\(length) feet by \(width) feet"
                
                let result = convertFootToMeterBySquare(with: area)
                resultLabel.text = "The area is" + "\n"
                + String(result) + " in meters"
            }
            
            // If either input is INVALID
        } else {
            performSegue(withIdentifier: "popoverSegue", sender: sender)
            
            // Shaking animation on Result Label
            UIView.animate(withDuration: 0.1, animations: {
                self.resultLabel.transform = CGAffineTransform(translationX: 5, y: 0)
            }) { (_) in
                self.resultLabel.transform = CGAffineTransform.identity
            }
        }
    }

    @IBAction func metricButtonTapped(_ sender: UIButton) {
        // Checking Numeric Inputs
        if let lengthInput = lengthTextField.text,
            let length = Double(lengthInput),
            let widthInput = widthTextField.text,
            let width = Double(widthInput) {
            let area = areaCalculation(by: length, and: width)
            
        // Do NOTHING if it's already in Metric Mode
        if inMetricMode == true {
            return
            
            // Switching to Metric Mode
        } else {
            inMetricMode = true
            lengthDescription.text = "The length of the square in meters?"
            widthDescription.text = "The width of the square in meters?"
            summaryLabel.text = "You entered dimensions of" + "\n" +
            "\(length) meters by \(width) meters"
            
            let result = convertMeterToFootBySquare(with: area)
            resultLabel.text = "The area is" + "\n"
            + String(result) + " in feet"
        }
            
            // Input has invalid value, only switching interface
        } else {
            
            // Do NOTHING if it's already in Metric Mode
            if inMetricMode == true {
                return
                
                // Switching to Metric Mode
            } else {
                inMetricMode = true
                lengthDescription.text = "The length of the square in meters?"
                widthDescription.text = "The width of the square in meters?"
                return
            }
        }
    }
    
    @IBAction func imperialButtonTapped(_ sender: UIButton) {
        // Checking Numeric Inputs
        if let lengthInput = lengthTextField.text,
            let length = Double(lengthInput),
            let widthInput = widthTextField.text,
            let width = Double(widthInput) {
            let area = areaCalculation(by: length, and: width)
            
            // Switching to Imperial Mode
            if inMetricMode == true {
                inMetricMode = false
                lengthDescription.text = "The length of the square in foot?"
                widthDescription.text = "The width of the square in foot?"
                summaryLabel.text = "You entered dimensions of" + "\n" +
                "\(length) feet by \(width) feet"
            
                let result = convertFootToMeterBySquare(with: area)
                resultLabel.text = "The area is" + "\n" + String(result) + " in meters"
        
                // Do NOTHING if it's already in Imperial Mode
            } else {
                return
            }
            
        // Input has invalid value, only switching interface
        } else {
            // Switching to Metric Mode
            if inMetricMode == true {
                inMetricMode = false
                lengthDescription.text = "The length of the square in feet?"
                widthDescription.text = "The width of the square in feet?"
                return
                
                // Do NOTHING if it's already in Imperial Mode
            } else {
                return
            }
        }
    }
    
    // MARK: - TOOLS
   
    func convertMeterToFootBySquare (with input: Double) -> Double {
        return input / 0.09290304
    }
    
    func convertFootToMeterBySquare (with input: Double) -> Double{
        return input / 10.7639
    }
    
    func areaCalculation (by a: Double, and b: Double) -> Double {
        return a * b
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: - NAVIGATIONS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let popoverControl = segue.destination.popoverPresentationController
        
        if sender is UITextField {
            popoverControl?.sourceRect = (sender as! UITextField).bounds
        }
        popoverControl?.delegate = self
        adaptivePresentationStyle(for: popoverControl!)
    }
}


