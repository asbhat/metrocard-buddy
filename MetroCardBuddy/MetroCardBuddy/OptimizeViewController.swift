//
//  OptimizeViewController.swift
//  MetroCardBuddy
//
//  Created by Aditya Bhat on 11/12/16.
//  Copyright © 2016-2017 Aditya Bhat. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

class OptimizeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currentBalanceTextField: UITextField!
    private let currentBalanceDollarFormatter = NumberFormatter()
    
    var currentBalanceValue: NSNumber {
        get {
            currentBalanceDollarFormatter.numberStyle = .currency
            return currentBalanceDollarFormatter.number(from: currentBalanceTextField.text!) ?? NSNumber(value: Double(currentBalanceTextField.text!) ?? 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addDoneButtonTo(textField: currentBalanceTextField)
        self.currentBalanceTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addDoneButtonTo(textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textField.inputAccessoryView = keyboardToolbar
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        // proper dollar format
        let dollarExpression = "^\\$?[0-9,]*([.][0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: dollarExpression)
        let matches = regex.matches(in: newText, range: NSRange(location: 0, length: newText.characters.count))
        
        guard matches.count > 0 else { return false }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {

        guard textField.text != "" else { return }
        
        let dollarValue = currentBalanceValue
        
        textField.text = currentBalanceDollarFormatter.string(from: dollarValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idAddMoney" {
            let destinationVC = segue.destination as! AddMoneyViewController
            
            let fareModel = FareCalculatorModel()
            
            // TODO - fix this to be dynamic
            destinationVC.moneyToAddValue = fareModel.calculateMoneyToAddToCard(startingBalance: Double(currentBalanceValue), idealAmount: 0, baseFare: 2.75)
        }
    }
}

