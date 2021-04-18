//=============================================================================//
//                                                                             //
//  KindTests.swift                                                            //
//  Forge                                                                      //
//                                                                             //
//  Created by Tyler J. Otte on 4/18/21.                                       //
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
import SwiftUI
@testable import Forge

/// Unit tests for a `DoubleDoubleRun HandRank`.
class KindTests: XCTestCase {
    
    //=========================================================================//
    //                             Initialization                              //
    //=========================================================================//
    
    //-------------------------------------------------------------------------//
    //                            Insufficient Cards                           //
    //-------------------------------------------------------------------------//
    
    /// Tests that creating a `Kind` with less than two`PlayingCards` throws an
    /// `ElementsError.insufficientElements Error`.
    func test_init_withInsufficientCards_throwsError() throws {

        // Given
        let rank1 = Rank.ace
        let color = Color.black
        let symbol = Symbol.clover
        let suit = Suit(color, symbol)
        let card = PlayingCard(rank1, of: suit)!
        let cards = [card]
        let expected = ElementsError.insufficientElements
        
        // When
        XCTAssertThrowsError(try Kind(of: cards)) { error in
            
            // Then
            XCTAssertEqual(expected, error as? ElementsError)
        }
    }
    
    //-------------------------------------------------------------------------//
    //                             Multiple Ranks                              //
    //-------------------------------------------------------------------------//
    
    /// Tests that creating a `Kind` with `PlayingCards`that do not all have the same `Rank` throws
    /// an `ElementsError.insufficientElements Error`.
    func test_init_withMultipleRanks_throwsError() throws {

        // Given
        let rank1 = Rank.ace
        let rank2 = Rank.two
        let color = Color.black
        let symbol1 = Symbol.clover
        let symbol2 = Symbol.spade
        let suit1 = Suit(color, symbol1)
        let suit2 = Suit(color, symbol2)
        let card1 = PlayingCard(rank1, of: suit1)!
        let card2 = PlayingCard(rank2, of: suit2)!
        let cards = [card1, card2]
        let expected = ElementsError.insufficientElements
        
        // When
        XCTAssertThrowsError(try Kind(of: cards)) { error in
            
            // Then
            XCTAssertEqual(expected, error as? ElementsError)
        }
    }
    
    //=========================================================================//
    //                              PROPERTIES                                 //
    //=========================================================================//
    
    //-------------------------------------------------------------------------//
    //                             Min/Max Cards                               //
    //-------------------------------------------------------------------------//
    
    /// Tests that the min cards  of a `Kind` equals two.
    func test_minCards_ofKind_equalsTwo() throws {

        // Given
        let rank = Rank.ace
        let color = Color.black
        let symbol1 = Symbol.clover
        let symbol2 = Symbol.spade
        let suit1 = Suit(color, symbol1)
        let suit2 = Suit(color, symbol2)
        let card1 = PlayingCard(rank, of: suit1)!
        let card2 = PlayingCard(rank, of: suit2)!
        let cards = [card1, card2]
        let kind = try Kind(of: cards)
        let expected = 2
        
        // When
        let actual = kind.minCards
        
        XCTAssertEqual(expected, actual)
    }
    
    /// Tests that the max cards  of a `Kind` equals the system max
    func test_maxCards_ofKind_equalsSystemMax() throws {

        // Given
        let rank = Rank.ace
        let color = Color.black
        let symbol1 = Symbol.clover
        let symbol2 = Symbol.spade
        let suit1 = Suit(color, symbol1)
        let suit2 = Suit(color, symbol2)
        let card1 = PlayingCard(rank, of: suit1)!
        let card2 = PlayingCard(rank, of: suit2)!
        let cards = [card1, card2]
        let kind = try Kind(of: cards)
        let expected = Int.max
        
        // When
        let actual = kind.maxCards
        
        XCTAssertEqual(expected, actual)
    }
    
    //-------------------------------------------------------------------------//
    //                                 Count                                   //
    //-------------------------------------------------------------------------//
    
    /// Tests that the count of a `Kind` equals the # of `PlayingCards` given.
    func test_count_ofKind_equalsNCardsGiven() throws {
        
        // Given
        let rank = Rank.ace
        let color = Color.black
        let symbol1 = Symbol.clover
        let symbol2 = Symbol.spade
        let suit1 = Suit(color, symbol1)
        let suit2 = Suit(color, symbol2)
        let card1 = PlayingCard(rank, of: suit1)!
        let card2 = PlayingCard(rank, of: suit2)!
        let cards = [card1, card2]
        let kind = try Kind(of: cards)
        let expected = 2
        
        // When
        let actual = kind.count
        
        XCTAssertEqual(expected, actual)
    }
    
}
