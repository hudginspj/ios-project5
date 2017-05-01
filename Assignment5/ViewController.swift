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
        JsonLoader.getJSONData(populateQuestionList)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateQuestionList(quests: [Question]) {
        
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "basic" {
            if let cvc = segue.destinationViewController as? CategoryViewController {
                cvc.model = model
            }
        }
    }*/


}

