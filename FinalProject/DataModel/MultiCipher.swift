//
//  MultiCipher.swift
//  FinalProject
//
//  Created by Barker, Alec on 3/26/19.
//  Copyright © 2019 Barker, Alec. All rights reserved.
//
//  This class keeps a list of all available ciphers.

import Foundation

class MultiCipher{
    var list: [Cipher]
    
    init(){
        list = [Cipher]()
        list.append(Cipher(name: "Caesar Cipher",
                           history: "The cipher is attributed to Julius Caesar, who is said to be the first to use the cipher in order to protect important military information. It is now considered one of the easiest ciphers to crack, but it is believed to have been effective at the time.",
                           explanation: "You must decide upon a shift number from 1 to 25. Each letter in the alphabet is shifted to the right based on the shift number, and the letters of the alphabet loop around. In order to decode, you simply do the opposite and shift each letter of the message to the left based on the shift number.",
                           example: "The plaintext message is \"Hello World\" and the shift number is 3.\n\nEach letter will shift 3 letters forward in the alphabet. Therefore, \"H\" would become \"K\", \"e\" would become \"h\", etc. In order to quickly encode and decode, you can write out the shifted alphabet:\n\nPlaintext: abcdefghijklmnopqrstuvwxyz\nEncoded:   defghijklmnopqrstuvwxyzabc\n\nThe encoded message will become \"Khoor Zruog\".\n\nTo decode, you just shift the letters 3 to the left."))
        list.append(Cipher(name: "Rail Fence Cipher",
                           history: "None available.",
                           explanation: "You must decide on a number of rails that is less than the number of letters in your message. Each letter of the message is put on a different rail. The first letter is put on the first rail, the second letter on the second rail, etc. The decoded message then read from left to right and top to bottom. To decrypt a message, you must know the rail number. You can use the rail number to make an empty set of rails with the spaces for letters marked. You can then fill in those spaces with the encoded letters.",
                           example: "The plaintext message is \"Hello World\" and the number of rails is 3. The message is arranged on 3 rails in this way:\n\nH---O---L-\n-E-L-W-R-D\n--L---O---\n\nThe encoded message is: HOLELWRDLO.\nTo decode, make a blank set of rails with the rail number:\n\nX---X---X-\n-X-X-X-X-X\n--X---X---\n\nYou can then fill in the letters going from line to line, and then read the message up and down then left to right."))
        list.append(Cipher(name: "Simple Substitution Cipher",
                           history: "None available.",
                           explanation: "You must first decide on a keyword. Duplicate letters are taken out of the keyword, and the revised keyword must contain between 1 and 25 letters. The revised keyword is written down, and every unused letter in the alphabet is placed in order after the keyword. This creates an encoded alphabet that will match up with the actual alphabet. To encode or decode, you must line up the original and encoded alhpabets and compare the letters to create your message.",
                           example: "The plaintext message is \"Hello World\" and the keyword is \"Test\".\n\nDuplicate letters are removed from the keyword, so it becomes \"Tes\".\n\nThe keyword is then placed at the beginning of the encoded alphabet and the remaining letters are placed in order after it:\n\nPlaintext: abcdefghijklmnopqrstuvwxyz\nEncoded:   tesabcdfghijklmnopqruvwxyz\n\nYou can then compare the plaintext alphabet to the encoded one. \"H\" in the plaintext alphabet becomes \"F\" in the encoded alphabet, \"e\" becomes \"b\", etc.\n\nThe encoded message is \"XXX\".\n\nTo decode, just compare the encoded alphabet to the plaintext one."))
    }
}
