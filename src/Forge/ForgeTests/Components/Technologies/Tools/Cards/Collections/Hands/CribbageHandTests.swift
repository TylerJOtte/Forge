//=============================================================================//
//                                                                             //
//  CribbageHandTests.swift                                                    //
//  Forge                                                                      //
//                                                                             //
//  Created by Tyler J. Otte on 4/29/21.                                       //
//-----------------------------------------------------------------------------//
//                                                                             //
// This source file is part of the Forge framework project.                    //
//                                                                             //
// Copyright (c) 2021, Tyler J. Otte.                                          //
// Licensed under the GNU Affero General Public License v3.0.                  //
//                                                                             //
// See https://github.com/TylerJOtte/forge/LICENSE.txt for more details.       //
//=============================================================================//

import XCTest
@testable import Forge

/// Unit tests for a`CribbageHand`.
class CribbageHandTests: XCTestCase {
    
    //=========================================================================//
    //                             Initialization                              //
    //=========================================================================//

    /// Tests that creating a `CribbageHand` with a `Joker` throws a
    /// `FeatureError.jokersNotAllowed Error`.
    func test_init_withJoker_throwsError() throws {

        // Given
        let fiveOfDiamonds = try Five(of: .diamonds)
        let fiveOfClubs = try Five(of: .clubs)
        let fiveOfSpades = try Five(of: .spades)
        let joker = try Joker()
        let cutCard = try Five()
        let cards = [fiveOfDiamonds, fiveOfClubs, fiveOfSpades, joker]
        let expected = FeatureError.jokersNotAllowed
        
        // When
        XCTAssertThrowsError(try CribbageHand(with: cards, and: cutCard)) {
            error in
            
            // Then
            XCTAssertEqual(expected, error as? FeatureError)
        }
    }
    
    /// Tests that creating a `CribbageHand` with a `Joker`as the cut `Card` throws a
    /// `FeatureError.jokersNotAllowed Error`.
    func test_init_withJokerCutCard_throwsError() throws {

        // Given
        let jackOfHearts = try Jack()
        let fiveOfDiamonds = try Five(of: .diamonds)
        let fiveOfClubs = try Five(of: .clubs)
        let fiveOfSpades = try Five(of: .spades)
        let cutCard = try Joker()
        let cards = [jackOfHearts, fiveOfDiamonds, fiveOfClubs, fiveOfSpades]
        let expected = FeatureError.jokersNotAllowed
        
        // When
        XCTAssertThrowsError(try CribbageHand(with: cards, and: cutCard)) {
            error in
            
            // Then
            XCTAssertEqual(expected, error as? FeatureError)
        }
    }
}
