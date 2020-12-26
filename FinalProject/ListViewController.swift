//
//  ListViewController.swift
//  FinalProject
//
//  Created by Barker, Alec on 3/28/19.
//  Copyright © 2019 Barker, Alec. All rights reserved.
//
//  This class is linked to the view controller with a list of the ciphers.
//  This tutorial was used to programmatically perform multiple segues with one button: https://digitalleaves.com/define-segues-programmatically/
//  This tutorial was used for rounding the edges of GUI elements: https://stackoverflow.com/questions/38874517/how-to-make-a-simple-rounded-button-in-storyboard

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return global.multiCipher.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        cell.textLabel?.text = global.multiCipher.list[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        global.currentlyViewing = indexPath.row
        if global.learnOrPractice == 0 {
            performSegue(withIdentifier: "learnSegue", sender: nil)
        } else {
            global.practiceOrGame = 0
            performSegue(withIdentifier: "practiceSegue", sender: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if global.learnOrPractice == 0 {
            headerLabel.text = "Learn the Ciphers"
        } else {
            headerLabel.text = "Practice Ciphers"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //This rounds the corners of the buttons.
        backButton.layer.cornerRadius = 15
        backButton.clipsToBounds = true
        
        //This rounds the corners of the table.
        table.layer.cornerRadius = 10
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
