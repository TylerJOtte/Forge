//=============================================================================//
//                                                                             //
//  Three.swift                                                                //
//  Forge                                                                      //
//                                                                             //
//  Created by Tyler J. Otte on 4/19/21.                                       //
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

/// A standard French-suited three `PlayingCard`.
public class Three: NumeralCard {
    
    //=========================================================================//
    //                               CONSTRUCTORS                              //
    //=========================================================================//
    
    /// Creates a`Three` with the given `Suit`.
    ///
    /// - Precondition: The given `Suit` must be `clubs`, `diamonds`, `hearts`, or
    ///  `spades`.
    /// - Postcondition:
    ///   - The `Card`s `Rank`is set to `three`.
    ///   - The `Card`s `Suit` is set to the given `Suit`.
    ///   - The `Card`s points are set to three.
    ///   - The `Card`s title is set to "`Three` of `{Suit}`.
    /// - Parameter suit: The symbol grouping.
    /// - Throws: `FeatureError.invalidSuit`  if the given `Suit` is not `clubs`,
    ///   `diamonds`, `hearts`, or `spades`.
    public init(of suit: Suit, is high: Bool = false) throws {
        
        try super.init(.three, of: suit)
    }
}
