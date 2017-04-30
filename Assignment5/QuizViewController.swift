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
    @IBOutlet weak var P1ScoreLabel: UILabel!
    @IBOutlet weak var P2ScoreLabel: UILabel!
    @IBOutlet weak var P3ScoreLabel: UILabel!
    @IBOutlet weak var P4ScoreLabel: UILabel!
    
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
        defaults.setValue("A", forKeyPath: "answer")
    }
    @IBAction func AnswerB(sender: AnyObject) {
        defaults.setValue("B", forKeyPath: "answer")
    }
    @IBAction func AnswerC(sender: AnyObject) {
        defaults.setValue("C", forKeyPath: "answer")
    }
    @IBAction func AnswerD(sender: AnyObject) {
        defaults.setValue("D", forKeyPath: "answer")
    }
    
    //Other Stuff
    @IBOutlet weak var TimerLabel: UILabel!
    @IBAction func ResetQuiz(sender: AnyObject) {
        score = 0
        time = 25
        timer = NSTimer()
        questionNumber = 1
        questionTotal = 2
        P1Score=0
        P2Score=0
        P3Score=0
        P4Score=0

        
        //Set initial values
        defaults.setValue(nil, forKeyPath: "answer")
        updateLabel(TimerLabel, text: String(25))
        
        //Set Answer labels and scores
        updateLabel(P1Answer, text: "")
        updateLabel(P2Answer, text: "")
        updateLabel(P3Answer, text: "")
        updateLabel(P4Answer, text: "")
        updateLabel(P1ScoreLabel, text: String(P1Score))
        updateLabel(P2ScoreLabel, text: String(P1Score))
        updateLabel(P3ScoreLabel, text: String(P1Score))
        updateLabel(P4ScoreLabel, text: String(P1Score))
        
        //Set question counter
        updateLabel(QuestionNumberLabel, text: "Question: "+String(questionNumber)+"/"+String(questionTotal))
        
        
        //TODO: Hide reset quiz button
        ResetButton.alpha=0
        ResetButton.enabled=false
        
        //TODO: Load Question 1

    }
    @IBOutlet weak var ResetButton: UIButton!
    
    
    //Variables
    var score = 0
    var time = 25
    var timer = NSTimer()
    var questionNumber = 1
    var questionTotal = 2
    var P1Score=0
    var P2Score=0
    var P3Score=0
    var P4Score=0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set initial values
        defaults.setValue(nil, forKeyPath: "answer")
        updateLabel(TimerLabel, text: String(25))
        
        //Set Answer labels and scores
        updateLabel(P1Answer, text: "")
        updateLabel(P2Answer, text: "")
        updateLabel(P3Answer, text: "")
        updateLabel(P4Answer, text: "")
        updateLabel(P1ScoreLabel, text: String(P1Score))
        updateLabel(P2ScoreLabel, text: String(P1Score))
        updateLabel(P3ScoreLabel, text: String(P1Score))
        updateLabel(P4ScoreLabel, text: String(P1Score))
        
        //Set question counter
        updateLabel(QuestionNumberLabel, text: "Question: "+String(questionNumber)+"/"+String(questionTotal))
        
        
        //TODO: Hide reset quiz button
        ResetButton.alpha=0
        ResetButton.enabled=false
        
        //TODO: Load Question 1
        
        //Set Timer
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(QuizViewController.updateTimer), userInfo: nil, repeats: true)
        
        //TODO: Run check for correct answer for all players
        
        //TODO: Show correct answer for 3 seconds
        
        //TODO: Load next question
        
    }
    
    func updateTimer() {
        time=time-1
        if(time>=0){
            updateLabel(TimerLabel, text: String(time))
        }else if(time >= -3){
            updateLabel(TimerLabel, text: "Times Up")
        }else{
            time=25
            updateLabel(TimerLabel, text: String(time))
            
            if(questionNumber<questionTotal){
                questionNumber=questionNumber+1
                updateLabel(QuestionNumberLabel, text: "Question: "+String(questionNumber)+"/"+String(questionTotal))
                
                //Load next question
            }
            if(questionNumber==questionTotal){
                //Show who won
                ResetButton.alpha=100
                ResetButton.enabled=true
            }
        }
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

