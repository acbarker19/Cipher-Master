//
//  MatchingAlphabet.swift
//  Cipher Master Advanced
//
//  Created by Barker, Alec on 5/7/19.
//  Copyright © 2019 Barker, Alec. All rights reserved.
//
//  This class matches an encoded alphabet with the actual alphabet.

import Foundation

class MatchingAlphabet {
    var origCharacter: Character
    var encCharacter: Character
    
    init() {
        origCharacter = "A"
        encCharacter = "A"
    }
    
    init(origAlph: Character, encAlph: Character) {
        origCharacter = origAlph
        encCharacter = encAlph
    }
}
