//
//  ViewController.swift
//  FinalProject
//
//  Created by Barker, Alec on 2/28/19.
//  Copyright © 2019 Barker, Alec. All rights reserved.
//
//  This class is linked to the main menu view controller.
//  This tutorial was used for rounding the edges of GUI elements: https://stackoverflow.com/questions/38874517/how-to-make-a-simple-rounded-button-in-storyboard
//
//  Cipher Master is an app that helps users learn about and use various ciphers. Each cipher has its history, an explanation, and an example provided. Users can practice the ciphers individually or all together as part of a cipher game. Users can also encode and decode messages with various ciphers in the app.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var encodeDecodeButton: UIButton!
    @IBOutlet weak var learnButton: UIButton!
    @IBOutlet weak var practiceButton: UIButton!
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //This rounds the corners of the buttons.
        encodeDecodeButton.layer.cornerRadius = 23
        encodeDecodeButton.clipsToBounds = true
        learnButton.layer.cornerRadius = 23
        learnButton.clipsToBounds = true
        practiceButton.layer.cornerRadius = 23
        practiceButton.clipsToBounds = true
        gameButton.layer.cornerRadius = 23
        gameButton.clipsToBounds = true
        aboutButton.layer.cornerRadius = 23
        aboutButton.clipsToBounds = true
    }

    @IBAction func learnButtonPressed(_ sender: UIButton) {
        global.learnOrPractice = 0
    }
    
    @IBAction func practiceButtonPressed(_ sender: UIButton) {
        global.learnOrPractice = 1
    }
    
    @IBAction func gameButtonPressed(_ sender: UIButton) {
        global.practiceOrGame = 1
    }
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Cipher Master", message:
            "Version \(global.versionNumber)\n\nCreated by Alec Barker for the University of Mount Union's CSC 399 iOS Programming course.\n\nThis app was developed to be run on an iPhone XR.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}

