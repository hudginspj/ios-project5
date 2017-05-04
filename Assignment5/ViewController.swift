//
//  ViewController.swift
//  Assignment5
//
//  Created by Paul Hudgins on 4/16/17.
//  Copyright © 2017 Paul Hudgins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()

    //Main Screen Images (currently unused)
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var MultiplayerImage: UIImageView!
    @IBOutlet weak var SinglePlayerImage: UIImageView!
    
    @IBOutlet weak var MultiButton: UIButton!
    @IBOutlet weak var SingleButton: UIButton!
    //Set user defaults
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    @IBAction func ChooseSingle(sender: AnyObject) {
        //Change settings to single player mode
        defaults.setBool(false, forKey: "multi")
        NSLog("Single")
        MultiButton.backgroundColor=UIColor.blueColor()
        MultiButton.layer.cornerRadius=13
        MultiButton.layer.borderWidth=2
        MultiButton.layer.borderColor=UIColor.blueColor().CGColor
        SingleButton.backgroundColor=UIColor.whiteColor()
        SingleButton.layer.cornerRadius=13
        SingleButton.layer.borderWidth=2
        SingleButton.layer.borderColor=UIColor.blueColor().CGColor
    
        MultiButton.titleLabel?.textColor=UIColor.whiteColor()
        SingleButton.titleLabel?.textColor=UIColor.blueColor()
    }
    
    @IBAction func ChooseMulti(sender: AnyObject) {
        //Change settings to multi player mode
        defaults.setBool(true, forKey: "multi")
        NSLog("Multi")
        MultiButton.backgroundColor=UIColor.whiteColor()
        MultiButton.layer.cornerRadius=13
        MultiButton.layer.borderWidth=2
        MultiButton.layer.borderColor=UIColor.blueColor().CGColor
        SingleButton.backgroundColor=UIColor.blueColor()
        SingleButton.layer.cornerRadius=13
        SingleButton.layer.borderWidth=2
        SingleButton.layer.borderColor=UIColor.blueColor().CGColor
        
        MultiButton.titleLabel?.textColor=UIColor.blueColor()
        SingleButton.titleLabel?.textColor=UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChooseSingle(self)
        
        
        JsonLoader.getJSONData(model.setQuestions)
        

        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if segue.identifier == "basic" {
        //    if let cvc = segue.destinationViewController as? CategoryViewController {
        //        cvc.model = model
        //    }
        //}
        if let qvc = segue.destinationViewController as? QuizViewController {
            qvc.model = model
        }
    }


}

