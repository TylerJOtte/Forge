//=============================================================================//
//                                                                             //
//  Hand.swift                                                                 //
//  Forge                                                                      //
//                                                                             //
//  Created by Tyler J. Otte on 3/14/21.                                       //
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

/// A `Hand` of `Card`s.
public class Hand: Cards {
    
    //=========================================================================//
    //                                ATTRIBUTES                               //
    //=========================================================================//
    
    /// The minimum # of `Card`s allowed .
    public let minCards: Int
    
    /// The maximum # of `Card`s allowed.
    public let maxCards: Int
    
    /// The total # of `Card`s.
    public var count: Int { return cards.count }
    
    /// The `Card`s.
    private var cards: [Card]
    
    //=========================================================================//
    //                               CONSTRUCTORS                              //
    //=========================================================================//
    
    /// Creates a default `Hand` of `Card`s.
    public init() {
        
        minCards = 0
        maxCards = Int.max
        cards = []
    }
    
    //=========================================================================//
    //                                 METHODS                                 //
    //=========================================================================//
    
    //-------------------------------------------------------------------------//
    //                                 Testers                                 //
    //-------------------------------------------------------------------------//
    
    /// Determines if the collection is empty.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Returns: True if the collection is empty, else false.
    public func isEmpty() -> Bool {
        
        return cards.count == 0
    }
    
    /// Determines if the collection is full.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Returns: True if the collection is full else false.
    public func isFull() -> Bool {
        
        return cards.count == maxCards
    }
    
    /// Determines if the given `Card` exists.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Parameter card: The `Card` to find.
    /// - Returns: True if the given `Card` exists, else false.
    public func contains(_ card: Card) -> Bool {
        
        return cards.contains(card)
    }
    
    //-------------------------------------------------------------------------//
    //                                  Adders                                 //
    //-------------------------------------------------------------------------//
    
    /// Adds the given `Card` to the collection.
    ///
    /// - Precondition: The collection cannot be full.
    /// - Postcondition: The collection contains the given `Card`.
    /// - Parameter card: The `Card` to add to the collection.
    /// - Throws: `ElementsError.isFull` if the collection is full.
    public func add(_ card: Card) throws {
        
        guard (isFull()) else {
            
            throw ElementsError.isFull
        }
        
        cards.append(card)
    }
    
    //-------------------------------------------------------------------------//
    //                                 Removers                                //
    //-------------------------------------------------------------------------//
    
    /// Removes the first istance of the given `Card` from the collection.
    ///
    /// - Precondition:
    ///   - The collection cannot be empty.
    ///   - The collection must contain the given `Card`.
    /// - Postcondition: The collection contains one less instance of the given `Card`.
    /// - Parameter card: The `Card` to remove from the collection.
    /// - Throws:
    ///   - `ElementsError.isEmpty` if the collection is empty.
    ///   - `ElementsError.notFound` if the collection doesn't contain the given `Card`.
    public func remove(_ card: Card) throws -> Card {
        
        guard (!isEmpty()) else {
            
            throw ElementsError.isEmpty
        }
        
        guard (contains(card)) else {
            
            throw ElementsError.notFound
        }
        
        let index = cards.firstIndex(where: {$0 == card})!
        
        return cards.remove(at: index)
    }
}
