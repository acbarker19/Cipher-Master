//
//  EncodeDecodeViewController.swift
//  FinalProject
//
//  Created by Barker, Alec on 3/28/19.
//  Copyright © 2019 Barker, Alec. All rights reserved.
//
//  This class is linked to the Encode/Decode view controller.
//  This tutorial was used for setting up the picker view: https://codewithchris.com/uipickerview-example/
//  This tutorial was used for rounding the edges of GUI elements: https://stackoverflow.com/questions/38874517/how-to-make-a-simple-rounded-button-in-storyboard

import UIKit

class EncodeDecodeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var inputText: UITextView!
    @IBOutlet weak var outputText: UITextView!
    @IBOutlet weak var specialTextField: UITextField!
    @IBOutlet weak var specialLabel: UILabel!
    @IBOutlet weak var revisedMessageLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var encodeButton: UIButton!
    @IBOutlet weak var decodeButton: UIButton!
    var selected: Int = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return global.multiCipher.list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return global.multiCipher.list[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
        displayAdditionalInfo()
    }
    
    //This method displays the correct information on the screen based on which cipher is chosen.
    func displayAdditionalInfo(){
        if selected == 0 {
            specialLabel.text = "Shift Number:"
            specialTextField.isHidden = false
        } else if selected == 1 {
            specialLabel.text = "Number of Rails:"
            specialTextField.isHidden = false
        } else if selected == 2 {
            specialLabel.text = "Keyword:"
            specialTextField.isHidden = false
        } else {
            specialLabel.text = ""
            specialTextField.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        displayAdditionalInfo()
        
        //This rounds the corners of the buttons.
        backButton.layer.cornerRadius = 15
        backButton.clipsToBounds = true
        encodeButton.layer.cornerRadius = 15
        encodeButton.clipsToBounds = true
        decodeButton.layer.cornerRadius = 15
        decodeButton.clipsToBounds = true
        
        //This round the corners of the text areas.
        inputText.layer.cornerRadius = 10
        outputText.layer.cornerRadius = 10
        
        //This locks the output text area so the user can only enter information in the input text area.
        outputText.isEditable = false
    }
    
    @IBAction func encodeButton(_ sender: UIButton) {
        if inputText.text == "" {
            let alertController = UIAlertController(title: "Message Error", message:
                "You have not entered a message. Please enter one.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        } else {
            revisedMessageLabel.text = "Encoded Message:"
            
            //If choosing to encode with a Caesar Cipher.
            if selected == 0 {
                if specialTextField.text == "" {
                    let alertController = UIAlertController(title: "Shift Number Error", message:
                        "You have not entered a shift number. Please enter one.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    if global.encodeDecode.isStringAUInt16(message: specialTextField.text ?? "") == true {
                        let num: UInt16 = UInt16(specialTextField.text ?? "") ?? 0
                        
                        //If you have a shift number that is bigger than 25, it won't encode properly.
                        if num > 25 {
                            let alertController = UIAlertController(title: "Shift Number Error", message:
                                "Your shift number must be between 0 and 25. Please try another.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                            self.present(alertController, animated: true, completion: nil)
                        } else if num == 0 {
                            let alert = UIAlertController(title: "Shift Number Alert", message:
                                "Your shift number is 0. This will result in an encoded message that is the same as the original message.", preferredStyle: .alert)
                            let submit = UIAlertAction(title: "Submit Anyway", style: .default, handler: { (action) -> Void in
                                self.outputText.text = self.inputText.text
                            })
                            
                            // Cancel button
                            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                            
                            alert.addAction(submit)
                            alert.addAction(cancel)
                            present(alert, animated: true, completion: nil)
                        } else {
                            outputText.text = global.encodeDecode.caesarCipher(input: inputText.text, shift: num, decode: false)
                        }
                    } else {
                        let alertController = UIAlertController(title: "Shift Number Error", message:
                            "Your shift number could not be read. It must be a positive number. Please try another.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            
            //If choosing to encode with a Rail Fence Cipher.
            else if selected == 1 {
                if specialTextField.text == "" {
                    let alertController = UIAlertController(title: "Rail Number Error", message:
                        "You have not entered a rail number. Please enter one.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    if global.encodeDecode.isStringAnInt(message: specialTextField.text ?? "") == true {
                        let num: Int = Int(specialTextField.text ?? "") ?? 0
                        
                        if num == 1 {
                            let alert = UIAlertController(title: "Rail Number Alert", message:
                                "Your rail number is 1. This will result in an encoded message that is the same as the original message.", preferredStyle: .alert)
                            let submit = UIAlertAction(title: "Submit Anyway", style: .default, handler: { (action) -> Void in
                                self.outputText.text = self.inputText.text
                            })
                            
                            // Cancel button
                            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                            
                            alert.addAction(submit)
                            alert.addAction(cancel)
                            present(alert, animated: true, completion: nil)
                        } else if num >= inputText.text.count {
                            let alert = UIAlertController(title: "Rail Number Alert", message:
                                "Your rail number is equal to or higher than the number of letters in your message. This will result in an encoded message that is the same as the original message.", preferredStyle: .alert)
                            let submit = UIAlertAction(title: "Submit Anyway", style: .default, handler: { (action) -> Void in
                                self.outputText.text = self.inputText.text
                            })
                            
                            // Cancel button
                            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                            
                            alert.addAction(submit)
                            alert.addAction(cancel)
                            present(alert, animated: true, completion: nil)
                        } else if num < 1 {
                            let alertController = UIAlertController(title: "Rail Number Error", message:
                                "Your rail number is 0 or below. It must be a positive number higher than 0. Please try another.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                            self.present(alertController, animated: true, completion: nil)
                        } else {
                            outputText.text = global.encodeDecode.railFenceCipher(input: inputText.text, rails: Int(specialTextField.text ?? "") ?? 0, decode: false)
                        }
                    } else {
                        let alertController = UIAlertController(title: "Rail Number Error", message:
                            "Your rail number could not be read. It must be a positive number. Please try another.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            
            //If choosing to encode with Simple Substitution Cipher
            else if selected == 2 {
                if specialTextField.text == "" {
                    let alertController = UIAlertController(title: "Keyword Error", message:
                        "You have not entered a keyword. Please enter one.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let specialCharacters: [Character] = global.encodeDecode.convertStringToCharacter(input: specialTextField.text ?? "")
                    var spaceOrNumberError: Bool = false
                    let capitalAlphabet: [Character] = global.encodeDecode.getCapitalAlphabet()
                    let lowercaseAlphabet: [Character] = global.encodeDecode.getLowercaseAlphabet()
                    
                    for i in 0 ..< specialCharacters.count {
                        if !capitalAlphabet.contains(specialCharacters[i]) && !lowercaseAlphabet.contains(specialCharacters[i]) {
                            spaceOrNumberError = true
                        }
                    }
                    
                    if spaceOrNumberError == true {
                        let alertController = UIAlertController(title: "Keyword Error", message:
                            "You entered a keyword with a space, number, or special character. Please enter another with only letters.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        outputText.text = global.encodeDecode.substitutionCipher(input: inputText.text, keyword: specialTextField.text ?? "", decode: false)
                    }
                }
            }
        }
    }
    
    @IBAction func decodeButton(_ sender: UIButton) {
        if inputText.text == "" {
            let alertController = UIAlertController(title: "Message Error", message:
                "You have not entered a message. Please enter one.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        } else {
            revisedMessageLabel.text = "Decoded Message:"
            
            //If choosing to decode with a Caesar Cipher.
            if selected == 0 {
                if specialTextField.text == "" {
                    let alertController = UIAlertController(title: "Shift Number Error", message:
                        "You have not entered a shift number. Please enter one.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    if global.encodeDecode.isStringAUInt16(message: specialTextField.text ?? "") == true {
                        let num: UInt16 = UInt16(specialTextField.text ?? "") ?? 0
                        
                        //If you have a shift number that is bigger than 25, it won't encode properly.
                        if num > 25 {
                            let alertController = UIAlertController(title: "Shift Number Error", message:
                                "Your shift number must be between 0 and 25. Please try another.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                            self.present(alertController, animated: true, completion: nil)
                        } else if num == 0 {
                            let alert = UIAlertController(title: "Shift Number Alert", message:
                                "Your shift number is 0. This will result in a decoded message that is the same as the original message.", preferredStyle: .alert)
                            let submit = UIAlertAction(title: "Submit Anyway", style: .default, handler: { (action) -> Void in
                                self.outputText.text = self.inputText.text
                            })
                            
                            // Cancel button
                            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                            
                            alert.addAction(submit)
                            alert.addAction(cancel)
                            present(alert, animated: true, completion: nil)
                        } else {
                            outputText.text = global.encodeDecode.caesarCipher(input: inputText.text, shift: num, decode: true)
                        }
                    } else {
                        let alertController = UIAlertController(title: "Shift Number Error", message:
                            "Your shift number could not be read. It must be a positive number. Please try another.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        
            //If choosing to decode with a Rail Fence Cipher.
            else if selected == 1 {
                if specialTextField.text == "" {
                    let alertController = UIAlertController(title: "Rail Number Error", message:
                        "You have not entered a rail number. Please enter one.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    if global.encodeDecode.isStringAnInt(message: specialTextField.text ?? "") == true {
                        let num: Int = Int(specialTextField.text ?? "") ?? 0
                        
                        if num == 1 {
                            let alert = UIAlertController(title: "Rail Number Alert", message:
                                "Your rail number is 1. This will result in a decoded message that is the same as the original message.", preferredStyle: .alert)
                            let submit = UIAlertAction(title: "Submit Anyway", style: .default, handler: { (action) -> Void in
                                self.outputText.text = self.inputText.text
                            })
                            
                            // Cancel button
                            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                            
                            alert.addAction(submit)
                            alert.addAction(cancel)
                            present(alert, animated: true, completion: nil)
                        } else if num >= inputText.text.count {
                            let alert = UIAlertController(title: "Rail Number Alert", message:
                                "Your rail number is equal to or higher than the number of letters in your message. This will result in a decoded message that is the same as the original message.", preferredStyle: .alert)
                            let submit = UIAlertAction(title: "Submit Anyway", style: .default, handler: { (action) -> Void in
                                self.outputText.text = self.inputText.text
                            })
                            
                            // Cancel button
                            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                            
                            alert.addAction(submit)
                            alert.addAction(cancel)
                            present(alert, animated: true, completion: nil)
                        } else if num < 1 {
                            let alertController = UIAlertController(title: "Rail Number Error", message:
                                "Your rail number is 0 or below. It must be a positive number higher than 0. Please try another.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                            self.present(alertController, animated: true, completion: nil)
                        } else {
                            outputText.text = global.encodeDecode.railFenceCipher(input: inputText.text, rails: Int(specialTextField.text ?? "") ?? 0, decode: true)
                        }
                    } else {
                        let alertController = UIAlertController(title: "Rail Number Error", message:
                            "Your rail number could not be read. It must be a positive number. Please try another.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            
            //If choosing to decode with Simple Substitution Cipher
            else if selected == 2 {
                if specialTextField.text == "" {
                    let alertController = UIAlertController(title: "Keyword Error", message:
                        "You have not entered a keyword. Please enter one.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let specialCharacters: [Character] = global.encodeDecode.convertStringToCharacter(input: specialTextField.text ?? "")
                    var spaceOrNumberError: Bool = false
                    let capitalAlphabet: [Character] = global.encodeDecode.getCapitalAlphabet()
                    let lowercaseAlphabet: [Character] = global.encodeDecode.getLowercaseAlphabet()
                    
                    for i in 0 ..< specialCharacters.count {
                        if !capitalAlphabet.contains(specialCharacters[i]) && !lowercaseAlphabet.contains(specialCharacters[i]) {
                            spaceOrNumberError = true
                        }
                    }
                    
                    if spaceOrNumberError == true {
                        let alertController = UIAlertController(title: "Keyword Error", message:
                            "You entered a keyword with a space, number, or special character. Please enter another with only letters.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        outputText.text = global.encodeDecode.substitutionCipher(input: inputText.text, keyword: specialTextField.text ?? "", decode: true)
                    }
                }
            }
        }
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
