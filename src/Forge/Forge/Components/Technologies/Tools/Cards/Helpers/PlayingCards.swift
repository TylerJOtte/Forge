//=============================================================================//
//                                                                             //
//  PlayingCards.swift                                                         //
//  Forge                                                                      //
//                                                                             //
//  Created by Tyler J. Otte on 4/03/21.                                       //
//-----------------------------------------------------------------------------//
//                                                                             //
// This source file is part of the Forge framework project.                    //
//                                                                             //
// Copyright (c) 2021, Tyler J. Otte.                                          //
// Licensed under the GNU Affero General Public License v3.0.                  //
//                                                                             //
// See https://github.com/TylerJOtte/forge/LICENSE.txt for more details.       //
//=============================================================================//

import Foundation
import SwiftUI

/// A helper for common `PlayingCard` operations.
class PlayingCards {
    
    //=========================================================================//
    //                                ATTRIBUTES                               //
    //=========================================================================//
    
    static let ranks: [Rank] = [.ace, .two, .three, .four, .five, .six, .seven,
                                .eight, .nine, .ten, .jack, .queen, .king]
                       
    static let suits: [Suit] = [.clubs, .diamonds, .hearts, .spades]
    
    //=========================================================================//
    //                                 METHODS                                 //
    //=========================================================================//

    /// Retrieves all the `NumeralCard`s with the given `Suit`.
    ///
    /// - Precondition:The given `Suit` must be a standard `PlayingCard Suit`.
    /// - Postcondition: None.
    /// - Parameter suit: The symbol grouping to get `Card`s for.
    /// - Throws: `invalidSuit`  if the given `Suit` is not a standard `PlayingCard Suit`.
    /// - Returns: An array of `NumeralCard`s.
    static func getNumeralCards(with suit: Suit) throws -> [PlayingCard] {
        
        return [
            try Ace(of: suit),
            try Two(of: suit),
            try Three(of: suit),
            try Four(of: suit),
            try Five(of: suit),
            try Six(of: suit),
            try Seven(of: suit),
            try Eight(of: suit),
            try Nine(of: suit),
            try Ten(of: suit)
        ]
    }
    
    /// Retrieves all the `FaceCard`s with the given `Suit`.
    ///
    /// - Precondition:The given `Suit` must be a standard `PlayingCard Suit`.
    /// - Postcondition: None.
    /// - Parameter suit: The symbol grouping to get `Card`s for.
    /// - Throws: `invalidSuit`  if the given `Suit` is not a standard `PlayingCard Suit`.
    /// - Returns: An array of `FaceCard`s.
    static func getFaceCards(with suit: Suit) throws -> [PlayingCard] {
        
        return [
            try Jack(of: suit),
            try Queen(of: suit),
            try King(of: suit)
        ]
    }
    
    /// Retrieves all the standard `PlayingCard`s with the given `Suit`.
    ///
    /// - Precondition:The given `Suit` must be a standard `PlayingCard Suit`.
    /// - Postcondition: None.
    /// - Parameter suit: The symbol grouping to get `Card`s for.
    /// - Throws: `invalidSuit`  if the given `Suit` is not a standard `PlayingCard Suit`.
    /// - Returns: An array of standard `PlayingCard`s.
    static func getStandardCards(with suit: Suit) throws -> [PlayingCard] {
        
        var cards = try getNumeralCards(with: suit)
        let faceCards = try getFaceCards(with: suit)
        
        cards.append(contentsOf: faceCards)
        
        return cards
    }
    
    /// Retrieves a collection of`PlayingCard`s for each `PlayingCard Rank` per the given `Suit`s.
    ///
    /// - Precondition:`Suit`s' symbols must be a `clover`, `diamond`, `heart`, or `spade`.
    /// - Postcondition: None.
    /// - Parameter suits: The `Suit`s to get `PlayingCard`s for.
    /// - Throws: `FeaturesError.invalidSuit` if any of the given `Suit`s are not standard
    ///   `PlayingCard Suit`s.
    /// - Returns: An array of `PlayingCard`s.
    static func getCards(of suits: [Suit]) throws -> [PlayingCard] {
        
        var cards: [PlayingCard] = []
        
        for suit in suits {
            
            let suitCards = try getStandardCards(with: suit);
            
            cards.append(contentsOf: suitCards)
        }
        
        return cards
    }
    
    /// Retrieves a collection of`PlayingCard`s for each `PlayingCard Rank` & `Suit` along with
    /// `joker`s if specified.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Parameter jokers: True if include `joker PlayingCard`s, else false.
    /// - Returns: An array of `PlayingCard`s.
    static func getCards(with jokers: Bool = false) -> [PlayingCard]? {

        var cards: [PlayingCard] = []
        
        do {
            
            try cards.append(contentsOf: getCards(of: suits))
            
            if (jokers) {

                cards.append(try Joker(color: .red))
                cards.append(try Joker(color: .black))
            }
        
        } catch {
            
            print("Error. Failed to retrieve all PlayingCards.")
        }
        
        return cards
    }
}
