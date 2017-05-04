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
    let defaults = UserDefaults.standard
    
    
    @IBAction func ChooseSingle(_ sender: AnyObject) {
        //Change settings to single player mode
        defaults.set(false, forKey: "multi")
        NSLog("Single")
        MultiButton.backgroundColor=UIColor.blue
        MultiButton.layer.cornerRadius=13
        MultiButton.layer.borderWidth=2
        MultiButton.layer.borderColor=UIColor.blue.cgColor
        SingleButton.backgroundColor=UIColor.white
        SingleButton.layer.cornerRadius=13
        SingleButton.layer.borderWidth=2
        SingleButton.layer.borderColor=UIColor.blue.cgColor
    
        MultiButton.titleLabel?.textColor=UIColor.white
        SingleButton.titleLabel?.textColor=UIColor.blue
    }
    
    @IBAction func ChooseMulti(_ sender: AnyObject) {
        //Change settings to multi player mode
        defaults.set(true, forKey: "multi")
        NSLog("Multi")
        MultiButton.backgroundColor=UIColor.white
        MultiButton.layer.cornerRadius=13
        MultiButton.layer.borderWidth=2
        MultiButton.layer.borderColor=UIColor.blue.cgColor
        SingleButton.backgroundColor=UIColor.blue
        SingleButton.layer.cornerRadius=13
        SingleButton.layer.borderWidth=2
        SingleButton.layer.borderColor=UIColor.blue.cgColor
        
        MultiButton.titleLabel?.textColor=UIColor.blue
        SingleButton.titleLabel?.textColor=UIColor.white
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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier == "basic" {
        //    if let cvc = segue.destinationViewController as? CategoryViewController {
        //        cvc.model = model
        //    }
        //}
        if let qvc = segue.destination as? QuizViewController {
            qvc.model = model
        }
    }


}

