//=============================================================================//
//                                                                             //
//  ArrayExtension.swift                                                       //
//  Forge                                                                      //
//                                                                             //
//  Created by Tyler J. Otte on 4/04/21.                                       //
//-----------------------------------------------------------------------------//
//                                                                             //
// This source file is part of the Forge framework project.                    //
//                                                                             //
// Copyright (c) 2021, Tyler J. Otte.                                          //
// Licensed under the GNU Affero General Public License v3.0.                  //
//                                                                             //
// See https://github.com/TylerJOtte/forge/LICENSE.txt for more details.       //
//=============================================================================//

/// An extension for common `RankedCard Array` operations.
extension Array where Element: RankedCard  {

    //=========================================================================//
    //                                 TESTERS                                 //
    //=========================================================================//

    /// Determines if all the `Card`s in the given collection contain the same`Rank`.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Returns: True if all the `Card`s in the given collection contain the same`Rank`, else false.
    func areEquallyRanked() -> Bool {
        
        return getCardsByRank().count == 1
    }
    
    /// Determines if all the `Card`s in the given collection are in sequential order.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Returns: True if all the `Card`s in the given collection are in sequential order, else false.
    func areSequential() -> Bool {
        
        var areSequential = true
        var index = 0
        
        while (areSequential && index < count - 1)
        {
            let card = self[index]
            let nextCard = self[index + 1]
            let expected = card.position + 1
            let actual = nextCard.position
            
            areSequential = expected == actual
            index += 1
        }
        
        return areSequential
    }
    
    //=========================================================================//
    //                                 GETTERS                                 //
    //=========================================================================//

    /// Retrieves all the `Card`s in the given collection by `Rank`.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Returns: A dictionary with the `Rank`s keys and their respective `Card`s as the values.
    func getCardsByRank() -> [Rank:[RankedCard]] {
        
        return Dictionary(grouping: self, by: {$0.rank})
    }
}

/// An extension for common `PlayingCard Array` operations.
extension Array where Element: PlayingCard  {

    //=========================================================================//
    //                                 TESTERS                                 //
    //=========================================================================//

    /// Determines if all `Card`s in the collection have the same `Rank`.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Returns: True if all `Card`s in the collection have the same `Rank`, else false.
    func areEquallyRanked() -> Bool {
        
        return !self.contains(where: {$0.rank != self.first?.rank})
    }
    
    /// Determines if all `Card`s in the collection have the same `Suit`.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Returns: True if all `Card`s in the collection have the same `Suit`, else false.
    func areEquallySuited() -> Bool {
        
        return !self.contains(where: {$0.suit != self.first?.suit})
    }
    
    /// Determines if all `Card`s are in sequential order.
    ///
    /// - Precondition: `count` >= 2.
    /// - Postcondition: None.
    /// - Parameter high: True if `.ace` is high, else false.
    /// - Returns: True if all `Card`s are in sequential order, else false.
    /// - Throws: `ElementsError.insufficientElements` if count &lt; 2.
    func areSequential(ace high: Bool = false) throws -> Bool {
        
        let min = 2
        
        guard (count >= min) else {
            
            print("The collection must contain at least \(min) Cards.")
            throw ElementsError.insufficientElements
        }
        
        let lastCard = count - 1
        var areSequential = true
        var card = 0
        
        while (areSequential && card < lastCard) {
            
            let nextRank = self[card].position + 1
            let nextCardRank = self[card + 1].position
            
            areSequential = nextRank == nextCardRank
            card += 1
        }
        
        return areSequential
    }
    
    /// Determines if all `Card`s are in sequential order with the given # of pairs.
    ///
    /// - Precondition:
    ///    - `count` >= three.
    ///    - The # of given pairs must be >= one.
    ///    - Must contain the specified # of pairs.
    /// - Postcondition: None.
    /// - Parameters:
    ///    - pairs: The # of paris that the collection contains.
    ///    - high: True if `.ace` is high, else false.
    ///    - groups: True if multiple pair groups allowed, else false.
    /// - Returns: True if all `Card`s are in sequential order with the given # of pairs, else false.
    /// - Throws:
    ///    - `ElementsError.insufficientElements` if contains less than four `Card`s.
    ///    - `ElementsError.invalidDuplicateCount` if
    ///       - Doesn't contain the specified # of pairs, or
    ///       - Specified groups is false, and `Card`s contain multiple pair groups
    ///    - `RangeError.invalidMin` if the # of specified pairs &lt;= zero.
    func areSequential(with pairs: Int, ace high: Bool = false,
                       multiple groups: Bool = true) throws -> Bool {
        
        let min = 3
        let pairMin = 1
        let pairGroups = getPairCounts()
        let pairGroupCount = pairGroups.count
        let pairCount = getPairCount(from: pairGroups)
        let s = pairs > 1 ? "s" : ""
        
        guard (count >= min) else {
            
            print("The collection must contain at least \(min) Cards.")
            throw ElementsError.insufficientElements
        }
        
        guard (pairs >= pairMin) else {
            
            print("The # of given pairs must be >= \(pairMin).")
            throw RangeError.invalidMin
        }
        
        guard (pairCount == pairs) else {
            
            let tenet = pairCount < pairs ? "" : "only "
            print("The collection must contain \(tenet)\(pairs) pair\(s).")
            throw ElementsError.invalidDuplicateCount
        }
        
        if (!groups && pairGroupCount > 1) {
            
            print("The collection must contain only one grouping of pairs.")
            throw ElementsError.invalidDuplicateCount
        }
        
        let lastCard = count - 1
        var areSequential = true
        var card = 0
        
        while (areSequential && card < lastCard) {
            
            let rank = self[card].position
            let nextRank = self[card].position + 1
            let nextCardRank = self[card + 1].position
            let isSequential = nextCardRank == nextRank
            let isPair = nextCardRank == rank
            
            areSequential = isSequential || isPair
            card += 1
        }
        
        return areSequential
    }
    
    /// Retrieves the duplicate items in the collection.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Returns: The duplicate items in the collection.
    func getPairs() -> [Rank:[PlayingCard]] {
        
        return Dictionary(grouping: self, by: {$0.rank})
            .filter({$0.value.count > 1})
    }
    
    /// Retrieves the count of each duplicate in the collection.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Returns: The count of each duplicate in the collection.
    func getPairCounts() -> [Rank:Int] {
        
        return getPairs().mapValues{ ($0.count * ($0.count - 1)) / 2 }
    }

    /// Retrieves the total duplicate count in the collection.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Returns: The total duplicate count in the collection.
    func getPairCount() -> Int {
        
        return getPairCounts().values.reduce(0, +)
    }
    
    /// Retrieves the total duplicate count in the given collection.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Parameter pairs: The pairs to get duplicate count from.
    /// - Returns: The total duplicate count in the given collection.
    func getPairCount(from pairs: [Rank:Int]) -> Int {
        
        return pairs.values.reduce(0, +)
    }
    
    //=========================================================================//
    //                               CALCULATORS                               //
    //=========================================================================//
    
    /// Retrieves the sum total of points from all the `Card`s in the collection.
    ///
    /// - Precondition: None.
    /// - Postcondition: None.
    /// - Returns: The sum total of points from all the `Card`s in the collection.
    func sum() -> Int {
        
        return self.map{$0.points}.reduce(0, +)
    }
    
}

