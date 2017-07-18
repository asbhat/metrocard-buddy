//
//  FareTableCellViewController.swift
//  MetroCardBuddy
//
//  Created by Aditya Bhat on 11/29/16.
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

class FareTableCellViewController: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var rowPicker: UIPickerView!
    
    var rowPickerData = [[String]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.rowPicker.delegate = self
        self.rowPicker.dataSource = self
        
        rowPickerData = [
            ["At Least", "Exactly"],
            ["1", "2", "3", "4", "5"],
            ["Subway and Local Bus Fare: $2.75", "JFK AirTrain Fare: $5.00"]
        ]

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return rowPickerData.count  // # of columns
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rowPickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rowPickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("did Select: \(rowPickerData[component][row])")
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = view as? UILabel ?? UILabel()
        
        label.textColor = .blue
        label.textAlignment = .left
        label.font = UIFont(name: "system", size: 5)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        label.text = rowPickerData[component][row]
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0: return 80
        case 1: return 30
        case 2: return 125
        default: return 60
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        switch component {
        case 0: return 15
        case 1: return 15
        case 2: return 75
        default: return 30
        }
    }
}
