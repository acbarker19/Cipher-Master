//
//  EncodeDecode.swift
//  FinalProject
//
//  Created by Barker, Alec on 3/28/19.
//  Copyright © 2019 Barker, Alec. All rights reserved.
//
//  This class holds methods for how the program can encode and decode messages.

import Foundation

class EncodeDecode{
    
    //This method takes in a String value and will return true (the String can be parsed as an Int) or false (the String can not be parsed as an Int)
    //This tutorial was used for error handling while parsing Strings: https://stackoverflow.com/questions/38159397/how-to-check-if-a-string-is-an-int-in-swift
    func isStringAnInt(message: String) -> Bool {
        return Int(message) != nil
    }
    
    //This method takes in a String value and will return true (the String can be parsed as a UInt16) or false (the String can not be parsed as a UInt16)
    //This tutorial was used for error handling while parsing Strings: https://stackoverflow.com/questions/38159397/how-to-check-if-a-string-is-an-int-in-swift
    func isStringAUInt16(message: String) -> Bool {
        return UInt16(message) != nil
    }
    
    //This method returns an array of Characters that represent the capital letters of the alphabet.
    func getCapitalAlphabet() -> [Character]{
        var alphabet: [Character] = [Character]()
        alphabet.append("A")
        alphabet.append("B")
        alphabet.append("C")
        alphabet.append("D")
        alphabet.append("E")
        alphabet.append("F")
        alphabet.append("G")
        alphabet.append("H")
        alphabet.append("I")
        alphabet.append("J")
        alphabet.append("K")
        alphabet.append("L")
        alphabet.append("M")
        alphabet.append("N")
        alphabet.append("O")
        alphabet.append("P")
        alphabet.append("Q")
        alphabet.append("R")
        alphabet.append("S")
        alphabet.append("T")
        alphabet.append("U")
        alphabet.append("V")
        alphabet.append("W")
        alphabet.append("X")
        alphabet.append("Y")
        alphabet.append("Z")
        return alphabet
    }
    
    //This method returns an array of Characters that represent the lowercase letters of the alphabet.
    func getLowercaseAlphabet() -> [Character]{
        var alphabet: [Character] = [Character]()
        alphabet.append("a")
        alphabet.append("b")
        alphabet.append("c")
        alphabet.append("d")
        alphabet.append("e")
        alphabet.append("f")
        alphabet.append("g")
        alphabet.append("h")
        alphabet.append("i")
        alphabet.append("j")
        alphabet.append("k")
        alphabet.append("l")
        alphabet.append("m")
        alphabet.append("n")
        alphabet.append("o")
        alphabet.append("p")
        alphabet.append("q")
        alphabet.append("r")
        alphabet.append("s")
        alphabet.append("t")
        alphabet.append("u")
        alphabet.append("v")
        alphabet.append("w")
        alphabet.append("x")
        alphabet.append("y")
        alphabet.append("z")
        return alphabet
    }
    
    //This method takes in a String value and will return an array of individual Characters that make up the String
    //This tutorial was used for converting a String to an array of Characters: https://stackoverflow.com/questions/25921204/convert-swift-string-to-array
    func convertStringToCharacter(input: String) -> [Character]{
        let string : String = input
        let characters = Array(string)
        return characters
    }
    
    //This method takes in a String value and will return an array of UInt16 ascii values for each individual Character in the String
    //This tutorial was used for converting a String to an array of UInt16 ascii values: https://www.dotnetperls.com/convert-int-character-swift
    func convertStringToAscii(input: String) -> [UInt16] {
        var asciiArray: [UInt16]
        asciiArray = [UInt16]()
        
        for i in input.utf16 {
            asciiArray.append(i)
        }
        
        return asciiArray
    }
    
    //This method takes in an array of UInt16 ascii values, will convert them to UnicodeScalar, will convert them to Characters, and will return a String made up of all the Characters in the array
    //This tutorial was used for converting an array of UInt16 ascii values to a String: https://www.dotnetperls.com/convert-int-character-swift
    //This tutorial was used for converting an array of Characters into a String: https://stackoverflow.com/questions/25457615/how-to-append-a-character-to-string-in-swift
    func convertAsciiToString(input: [UInt16]) -> String {
        var output = ""
        
        for i in input{
            // Convert Int to a UnicodeScalar.
            let uni = UnicodeScalar(i)
            // Convert UnicodeScalar to a Character.
            let char = Character(uni!)
            output = output + String(char)
        }
        
        return output
    }
    
    //This method is used to encode or decode Caesar ciphers. It takes in a String for the input, a UInt16 value for the shift number, and a Bool to determine if you are encoding (false) or decoding (true).
    func caesarCipher(input: String, shift: UInt16, decode: Bool) -> String {
        var asciiArray = convertStringToAscii(input: input)

        for i in 0 ..< asciiArray.count {
            let originalAscii = asciiArray[i]
            
            //If it is a capital or lowercase letter, it will encode/decode. Any other characters will be ignored.
            if (asciiArray[i] > 64 && asciiArray[i] < 91) || (asciiArray[i] > 96 && asciiArray[i] < 123) {
                if decode == true {
                    asciiArray[i] = asciiArray[i] - shift
                } else {
                    asciiArray[i] = asciiArray[i] + shift
                }
            }
            
            //This will loop around the capital letters.
            if originalAscii > 64 && originalAscii < 91  {
                if asciiArray[i] > 90 {
                    asciiArray[i] = asciiArray[i] - 26
                } else if asciiArray[i] < 65 {
                    asciiArray[i] = asciiArray[i] + 26
                }
            }
            
            //This will loop around the lowercase letters.
            else if originalAscii > 96 && originalAscii < 123 {
                if asciiArray[i] > 122 {
                    asciiArray[i] = asciiArray[i] - 26
                } else if asciiArray[i] < 97 {
                    asciiArray[i] = asciiArray[i] + 26
                }
            }
        }
        
        let convertedMessage = convertAsciiToString(input: asciiArray)
        
        return convertedMessage
    }
    
    //This method is used to encode or decode Rail Fence Ciphers. It takes in a String for the input, an Int for the number of rails, and a Bool to determine if you are encoding (false) or decoding (true).
    func railFenceCipher(input: String, rails: Int, decode: Bool) -> String {
        var output: String = ""
        let charArray = convertStringToCharacter(input: input)
        let columns: Int = charArray.count
        
        var currentY: Int = 0       //Determines which rail the current letter should be placed on.
        var changeNum: Int = 1      //Determines if the letters are going down the rail (1) or up the rail (-1).
        var decodeNum: Int = 0      //Counts which column the program should be reading.
        
        var railDiagram = Array(repeating: Array(repeating: "", count: rails), count: columns)      //A 2D array that acts like the diagram for explaining rail fence ciphers.

        for y in 0 ..< rails {          //y is the row number.
            currentY = 0
            
            for x in 0 ..< columns {    //x is the column number.
                //If the y value is on the correct rail to place a letter, it will place that letter in the 2D array.
                if y == currentY {
                    if decode == false {
                        railDiagram[x][y] = String(charArray[x])
                        output = output + railDiagram[x][y]
                    } else {
                        railDiagram[x][y] = String(charArray[decodeNum])
                        decodeNum = decodeNum + 1
                    }
                }
                
                if decode == true{
                    output = output + railDiagram[x][currentY]
                }

                //Changes the correct rail number.
                currentY = currentY + changeNum
                if currentY > rails - 1 {
                    currentY = rails - 2
                    changeNum = -1
                } else if currentY < 0 {
                    currentY = 1
                    changeNum = 1
                }
            }
        }
        
        //Output for decode will show itself building the message (Example: TTeTesTest). This removes everything except the desired message at the end.
        if decode == true {
            output = String(output.dropFirst(output.count - columns))
        }
        
        return output
    }
    
    //This method is used to encode or decode Substitution Ciphers. It takes in a String for the input, a String for the keyword, and a Bool to determine if you are encoding (false) or decoding (true).
    func substitutionCipher(input: String, keyword: String, decode: Bool) -> String {
        var output: String = ""
        var tempCapitalAlphabet: [Character] = getCapitalAlphabet()
        var tempLowercaseAlphabet: [Character] = getLowercaseAlphabet()
        let permCapitalAlphabet: [Character] = getCapitalAlphabet()
        let permLowercaseAlphabet: [Character] = getLowercaseAlphabet()
        var capitalCipherAlphabet: [Character] = [Character]()
        var lowercaseCipherAlphabet: [Character] = [Character]()
        let inputCharacters: [Character] = convertStringToCharacter(input: input)
        let keywordCharacters: [Character] = convertStringToCharacter(input: keyword)
        var encAlphabet: [MatchingAlphabet] = [MatchingAlphabet]()
        var revisedKeyword: String = ""
        
        //Revises the input to remove duplicate letters
        for h in 0 ..< keyword.count {
            if !revisedKeyword.uppercased().contains(String(keywordCharacters[h]).uppercased()) {
                revisedKeyword = revisedKeyword + String(keywordCharacters[h])
            }
        }
        
        let uppercaseKeyword: [Character] = convertStringToCharacter(input: revisedKeyword.uppercased())
        let lowercaseKeyword: [Character] = convertStringToCharacter(input: revisedKeyword.lowercased())
        
        //Adds the keyword to the beginning of the encoded alphabet
        for i in 0 ..< revisedKeyword.count {
            capitalCipherAlphabet.append(uppercaseKeyword[i])
            lowercaseCipherAlphabet.append(lowercaseKeyword[i])
        }
        
        //Adds the rest of the letters of the alphabet in order to the encoded alphabet
        for j in 0 ..< tempCapitalAlphabet.count {
            if capitalCipherAlphabet.contains(tempCapitalAlphabet[j]) == false {
                capitalCipherAlphabet.append(tempCapitalAlphabet[j])
                lowercaseCipherAlphabet.append(tempLowercaseAlphabet[j])
            }
        }
        
        //Matches the encoded alphabet to the actual alphabet
        for k in 0 ..< permCapitalAlphabet.count {
            encAlphabet.append(MatchingAlphabet(origAlph: permCapitalAlphabet[k], encAlph: capitalCipherAlphabet[k]))
        }
        for k in 0 ..< permLowercaseAlphabet.count {
            encAlphabet.append(MatchingAlphabet(origAlph: permLowercaseAlphabet[k], encAlph: lowercaseCipherAlphabet[k]))
        }

        //Creates the encoded/decoded String
        for l in 0 ..< input.count {
            if permCapitalAlphabet.contains(inputCharacters[l]) || permLowercaseAlphabet.contains(inputCharacters[l]){
                for m in 0 ..< encAlphabet.count {
                    if decode == false {
                        if inputCharacters[l] == encAlphabet[m].origCharacter {
                            output = output + "\(encAlphabet[m].encCharacter)"
                        }
                    } else {
                        if inputCharacters[l] == encAlphabet[m].encCharacter {
                            output = output + "\(encAlphabet[m].origCharacter)"
                        }
                    }
                }
            } else {
                output = output + String(inputCharacters[l])
            }
        }

        return output
    }

}
