//
//  Cipher.swift
//  FinalProject
//
//  Created by Barker, Alec on 3/26/19.
//  Copyright © 2019 Barker, Alec. All rights reserved.
//
//  This class is used to store variables for each cipher.

import Foundation

class Cipher{
    var name: String
    var history: String
    var explanation: String
    var example: String
    
    init(){
        name = "???"
        history = "???"
        explanation = "???"
        example = "???"
    }
    
    init(name: String, history: String, explanation: String, example: String){
        self.name = name
        self.history = history
        self.explanation = explanation
        self.example = example
    }
}
