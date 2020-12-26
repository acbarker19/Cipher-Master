//
//  PracticeGameViewController.swift
//  FinalProject
//
//  Created by Barker, Alec on 3/28/19.
//  Copyright © 2019 Barker, Alec. All rights reserved.
//
//  This class is linked to the Practice Cipher view controller and the Cipher Game view controller.
//  This tutorial was used to programmatically perform multiple segues with one button: https://digitalleaves.com/define-segues-programmatically/
//  This tutorial was used for rounding the edges of GUI elements: https://stackoverflow.com/questions/38874517/how-to-make-a-simple-rounded-button-in-storyboard

import UIKit

class PracticeGameViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var messages: [String] = [String]()     //A list of possible messages that users can encode or decode.
    var keywords: [String] = [String]()     //A list of possible keywords used for encoding or decoding.
    var currentQuestion: Int = 0            //Which question the user is on.
    var answer: String = ""                 //The encoded/decoded answer for the message.
    var decode: Bool = false                //Will user be encoding (false) or decoding (true)
    var points: Int = 0                     //If the user is playing the game, how many points do they have?
    
    override func viewWillAppear(_ animated: Bool) {
        if global.practiceOrGame == 0 {
            headerLabel.text = "Practice Ciphers"
            nameLabel.text = global.multiCipher.list[global.currentlyViewing].name
            pointsLabel.text = ""
            counterLabel.text = ""
        } else {
            headerLabel.text = "Cipher Game"
            pointsLabel.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.numberOfLines = 0
        
        //This rounds the corners of the buttons.
        backButton.layer.cornerRadius = 15
        backButton.clipsToBounds = true
        enterButton.layer.cornerRadius = 18
        enterButton.clipsToBounds = true
        
        fillMessages()
        fillKeywords()
        getQuestion()
    }
    
    //This method will refill the list with all possible messages.
    func fillMessages() {
        messages.removeAll()
        messages.append(String("Hello World"))
        messages.append(String("This is a message"))
        messages.append(String("Welcome!"))
        messages.append(String("Hello!"))
        messages.append(String("This is fun"))
    }
    
    //This method contains all possible keywords
    func fillKeywords() {
        keywords.append(String("Test"))
        keywords.append(String("Keyword"))
        keywords.append(String("Zebras"))
    }
    
    //This method will choose a question, set the labels, and determine the answer.
    func getQuestion() {
        if global.practiceOrGame == 1 {
            global.currentlyViewing = Int.random(in: 0 ..< global.multiCipher.list.count)
            nameLabel.text = global.multiCipher.list[global.currentlyViewing].name
            counterLabel.text = "Your Score: \(points)"
        }
        
        var message: String = ""
        
        //Choosing random values for the question.
        currentQuestion = Int.random(in: 0 ..< messages.count)
        decode = Bool.random()
        var specialNum: Int = 0
        if global.currentlyViewing == 0 {
            specialNum = Int.random(in: 1 ..< 26)
        } else if global.currentlyViewing == 1 {
            specialNum = Int.random(in: 2 ..< messages[currentQuestion].count)
        } else if global.currentlyViewing == 2 {
            specialNum = Int.random(in: 0 ..< keywords.count)
        }
        
        //Building the label to ask the question.
        if decode == false {
            message = "Encode \'"
        } else {
            message = "Decode \'"
        }
        if decode == false {
            message = message + messages[currentQuestion]
        } else {
            if global.currentlyViewing == 0 {
                message = message + global.encodeDecode.caesarCipher(input: messages[currentQuestion], shift: UInt16(specialNum), decode: false)
            } else if global.currentlyViewing == 1 {
                message = message + global.encodeDecode.railFenceCipher(input: messages[currentQuestion], rails: specialNum, decode: false)
            } else if global.currentlyViewing == 2 {
                message = message + global.encodeDecode.substitutionCipher(input: messages[currentQuestion], keyword: keywords[specialNum], decode: false)
            }
        }
        message = message + "\'"
        if global.currentlyViewing == 0 {
            message = message + " with a shift number of \(specialNum)."
        } else if global.currentlyViewing == 1 {
            message = message + " with \(specialNum) rails."
        } else if global.currentlyViewing == 2 {
            message = message + " with a keyword of \'\(keywords[specialNum])\'."
        }
        messageLabel.text = message
        
        //Getting the answer.
        if global.currentlyViewing == 0 {
            if decode == false {
                answer = global.encodeDecode.caesarCipher(input: messages[currentQuestion], shift: UInt16(specialNum), decode: false)
            } else {
                answer = messages[currentQuestion]
            }
        } else if global.currentlyViewing == 1 {
            if decode == false {
                answer = global.encodeDecode.railFenceCipher(input: messages[currentQuestion], rails: specialNum, decode: false)
            } else {
                answer = messages[currentQuestion]
            }
        } else if global.currentlyViewing == 2 {
            if decode == false {
                answer = global.encodeDecode.substitutionCipher(input: messages[currentQuestion], keyword: keywords[specialNum], decode: false)
            } else {
                answer = messages[currentQuestion]
            }
        }
        
        //Removes question from list so it isn't repeated. If there are no more questions, the list is repopulated.
        messages.remove(at: currentQuestion)
        if messages.count == 0 {
            fillMessages()
        }
    }
    
    //Goes back to either the main menu view controller or the view controller with a list of all ciphers, depending on which page you came from.
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if global.practiceOrGame == 1 {
            self.performSegue(withIdentifier: "homeSegue", sender: nil)
        } else {
            self.performSegue(withIdentifier: "listSegue", sender: nil)
        }
    }
    
    
    //Checks if the answer is correct, tells the user, and moves on to the next question. If the user has gone through every possible message, it will
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        let customGreen = UIColor(red: 0,
                            green: 0.7,
                            blue: 0,
                            alpha: 1)
        
        if textField.text?.lowercased() == answer.lowercased() {
            pointsLabel.text = "Correct"
            pointsLabel.textColor = customGreen
            if global.practiceOrGame == 1 {
                points = points + 1
            }
        } else {
            pointsLabel.text = "Incorrect"
            pointsLabel.textColor = UIColor.red
        }
        
        textField.text = ""
        getQuestion()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
