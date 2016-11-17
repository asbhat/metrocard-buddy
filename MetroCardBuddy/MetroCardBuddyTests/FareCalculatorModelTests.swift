//
//  FareCalculatorModelTests.swift
//  MetroCardBuddy
//
//  Created by Aditya Bhat on 11/13/16.
//  Copyright © 2016 Aditya Bhat. All rights reserved.
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

import XCTest
@testable import MetroCardBuddy

class FareCalculatorModelTests: XCTestCase {
    
    let fareCalculator = FareCalculatorModel()
    
    func testExactMoneyToAdd() {
        let idealIsPerfect = fareCalculator.calculateMoneyToAddToCard(startingBalance: 0, idealAmount: 55, baseFare: 2.75)
        XCTAssertEqual(idealIsPerfect, 49.55)
    }
    
    func testPerfectStartingBalance() {
        let fare = fareCalculator.calculateMoneyToAddToCard(startingBalance: 2.75, idealAmount: 55, baseFare: 2.75)
        XCTAssertEqual(fare, 49.55)
    }
    
    func testStartingBalanceExactMoney() {
        let almostPerfect = fareCalculator.calculateMoneyToAddToCard(startingBalance: 0.50, idealAmount: 55, baseFare: 2.75)
        XCTAssertEqual(almostPerfect, 49.10)
    }
    
    func testStartingBalance() {
        let closestFare = fareCalculator.calculateMoneyToAddToCard(startingBalance: 0.51, idealAmount: 55, baseFare: 2.75)
        XCTAssertEqual(closestFare, 59)
    }
    
    func testNoIdeal() {
        let fare = fareCalculator.calculateMoneyToAddToCard(startingBalance: 0, idealAmount: 0, baseFare: 2.75)
        XCTAssertEqual(fare, 22.30)
    }
    
}
