//
//  ViewController.swift
//  Assignment5
//
//  Created by Paul Hudgins on 4/16/17.
//  Copyright © 2017 Paul Hudgins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Main Screen Images (currently unused)
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var MultiplayerImage: UIImageView!
    @IBOutlet weak var SinglePlayerImage: UIImageView!
    
    //Set user defaults
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    @IBAction func ChooseSingle(sender: AnyObject) {
        //Change settings to single player mode
        defaults.setBool(false, forKey: "multi")
    }
    @IBAction func ChooseMulti(sender: AnyObject) {
        //Change settings to multi player mode
        defaults.setBool(true, forKey: "multi")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Automatically start with single-player default
        defaults.setBool(false, forKey: "multi")
        
        //TODO: Set images (if needed)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

