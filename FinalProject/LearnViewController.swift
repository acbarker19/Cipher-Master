//
//  LearnViewController.swift
//  FinalProject
//
//  Created by Barker, Alec on 3/26/19.
//  Copyright © 2019 Barker, Alec. All rights reserved.
//
//  This class is linked to the Learn the Ciphers view controller.
//  This tutorial was used to allow the font style to change within the text label: https://makeapppie.com/2014/10/20/swift-swift-using-attributed-strings-in-swift/
//  This tutorial was used for rounding the edges of GUI elements: https://stackoverflow.com/questions/38874517/how-to-make-a-simple-rounded-button-in-storyboard

import UIKit

class LearnViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //This rounds the corners of the buttons.
        backButton.layer.cornerRadius = 15
        backButton.clipsToBounds = true
        
        //This rounds the corners of the text area.
        textView.layer.cornerRadius = 10
        
        textView.isEditable = false
        
        //Displays the info about the cipher.
        let myString = "History:\n\(global.multiCipher.list[global.currentlyViewing].history)\n\n\nExplanation:\n\(global.multiCipher.list[global.currentlyViewing].explanation)\n\n\nExample:\n\(global.multiCipher.list[global.currentlyViewing].example)"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 18.0)!])
        
        //Turns parts of the info section into Courier New font since it is monospaced and can be used to line up diagrams.
        if global.currentlyViewing == 0 {
            myMutableString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Courier New", size: 15.0)!, range: NSRange(location: 851, length: 75))
        } else if global.currentlyViewing == 1 {
            myMutableString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Courier New", size: 15.0)!, range: NSRange(location: 677, length: 36))
            myMutableString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Courier New", size: 15.0)!, range: NSRange(location: 807, length: 36))
        } else if global.currentlyViewing == 2 {
            myMutableString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Courier New", size: 15.0)!, range: NSRange(location: 774, length: 75))
        }
        
        nameLabel.text = global.multiCipher.list[global.currentlyViewing].name
        textView.attributedText = myMutableString
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
