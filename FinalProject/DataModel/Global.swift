//
//  Global.swift
//  FinalProject
//
//  Created by Barker, Alec on 3/26/19.
//  Copyright © 2019 Barker, Alec. All rights reserved.
//
//  Global stores global values that are used throughout the app.

import Foundation

class Global{
    var multiCipher: MultiCipher
    var currentlyViewing: Int   //multiCipher index number that determines which cipher you are viewing
    var learnOrPractice: Int    //If 0, go to learn page. If 1, go to practice page.
    var practiceOrGame: Int     //If 0, go to practice page. If 1, go to game page.
    var encodeDecode: EncodeDecode
    var versionNumber: Double
    
    init(){
        multiCipher = MultiCipher()
        currentlyViewing = 0
        learnOrPractice = 0
        practiceOrGame = 0
        encodeDecode = EncodeDecode()
        versionNumber = 2.0
    }
}
