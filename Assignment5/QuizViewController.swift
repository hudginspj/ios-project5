//
//  QuizViewController.swift
//  Assignment5
//
//  Created by William Nieporte on 4/30/17.
//  Copyright © 2017 Paul Hudgins. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    //Set user defaults
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //Player answer labels
    @IBOutlet weak var P1Answer: UILabel!
    @IBOutlet weak var P2Answer: UILabel!
    @IBOutlet weak var P3Answer: UILabel!
    @IBOutlet weak var P4Answer: UILabel!
    
    //Player score labels
    @IBOutlet weak var P1Score: UILabel!
    @IBOutlet weak var P2Score: UILabel!
    @IBOutlet weak var P3Score: UILabel!
    @IBOutlet weak var P4Score: UILabel!
    
    //Question stuff
    @IBOutlet weak var QuestionNumberLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    
    //Answer text
    @IBOutlet weak var TextA: UIButton!
    @IBOutlet weak var TextB: UIButton!
    @IBOutlet weak var TextC: UIButton!
    @IBOutlet weak var TextD: UIButton!
    
    //Quiz Answer choices
    @IBAction func AnswerA(sender: AnyObject) {
    }
    @IBAction func AnswerB(sender: AnyObject) {
    }
    @IBAction func AnswerC(sender: AnyObject) {
    }
    @IBAction func AnswerD(sender: AnyObject) {
    }
    
    //Other Stuff
    @IBOutlet weak var TimerLabel: UILabel!
    @IBAction func ResetQuiz(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabel(label: UILabel, text: String){
        label.text=text
    }
    func updateButtonText(button: UIButton, text: String){
        button.titleLabel?.text=text
    }
    
    
}

