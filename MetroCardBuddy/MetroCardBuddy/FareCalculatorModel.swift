//
//  FareCalculatorModel.swift
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

import Foundation

class FareCalculatorModel {
    
    // http://web.mta.info/nyct/fare/FaresatAGlance.htm
    // 11% bonus added when you buy or add $5.50 or more to your MetroCard®
    
    private let minimumFareForBonus = 5.50
    private let reducedFareModifier = 0.5
    private let bonusPercentage = 0.11
    private let smallestDollarIncrement = 0.05
    
    private var fares = [
        "Subway and Local Bus Fare" : 2.75,
        "30-Day Unlimited MetroCard" : 116.50,
        "7-Day Unlimited MetroCard" : 31.00,
        "Express Bus Fare" : 6.50,
        "7-Day Express Bus" : 57.25,  // No reduced fare option for this one?
        "JFK AirTrain Fare" : 5.00
    ]
    
    func calculateMoneyToAddToCard(startingBalance: Double, idealAmount: Double, baseFare: Double) -> Double? {
        
        let targetCentsToAdd = max( round( ((idealAmount - startingBalance) * 100) / (1 + bonusPercentage) ), 0)
        if targetCentsToAdd > 0 && targetCentsToAdd.remainder(dividingBy: smallestDollarIncrement * 100) == 0 {
            return targetCentsToAdd / 100
        }
        
        let minimum = Int(max(minimumFareForBonus * 100, targetCentsToAdd))  // TODO fix this later
        let maximum = Int(min(fares["30-Day Unlimited MetroCard"]! * 100, targetCentsToAdd + baseFare * 100 * 9))  // TODO fix this
        
        for i in minimum...maximum where i % Int(smallestDollarIncrement * 100) == 0 {
            let totalCentsWithBonus = round(Double(i) * (1 + bonusPercentage)) + startingBalance * 100
            let totalCentsForAdditionalRides = totalCentsWithBonus - idealAmount * 100
            
            if totalCentsForAdditionalRides.remainder(dividingBy: baseFare * 100) == 0 {
                return Double(i) / 100
            }
        }
        
        return nil
    }
    
}
