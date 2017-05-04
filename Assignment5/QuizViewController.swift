//
//  QuizViewController.swift
//  Assignment5
//
//  Created by William Nieporte on 4/30/17.
//  Copyright © 2017 Paul Hudgins. All rights reserved.
//

import UIKit
import CoreMotion

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
    
    //Player images
    @IBOutlet weak var P1Image: UIImageView!
    @IBOutlet weak var P2Image: UIImageView!
    @IBOutlet weak var P3Image: UIImageView!
    @IBOutlet weak var P4Image: UIImageView!
    
    var numberOfPlayers=1
    
    //Quiz Answer choices
    @IBAction func AnswerA(sender: AnyObject) {
        //defaults.setValue("A", forKeyPath: "answer")
        click("A")
        TextA.backgroundColor=UIColor.yellowColor()
        TextA.layer.cornerRadius=10
        TextA.layer.borderWidth=1
        TextA.layer.borderColor=UIColor.yellowColor().CGColor
        TextB.backgroundColor=UIColor.grayColor()
        TextB.layer.cornerRadius=10
        TextB.layer.borderWidth=1
        TextB.layer.borderColor=UIColor.grayColor().CGColor
        TextC.backgroundColor=UIColor.grayColor()
        TextC.layer.cornerRadius=10
        TextC.layer.borderWidth=1
        TextC.layer.borderColor=UIColor.grayColor().CGColor
        TextD.backgroundColor=UIColor.grayColor()
        TextD.layer.cornerRadius=10
        TextD.layer.borderWidth=1
        TextD.layer.borderColor=UIColor.grayColor().CGColor
    }
    @IBAction func AnswerB(sender: AnyObject) {
        //defaults.setValue("B", forKeyPath: "answer")
        click("B")
        TextA.backgroundColor=UIColor.grayColor()
        TextA.layer.cornerRadius=10
        TextA.layer.borderWidth=1
        TextA.layer.borderColor=UIColor.grayColor().CGColor
        TextB.backgroundColor=UIColor.yellowColor()
        TextB.layer.cornerRadius=10
        TextB.layer.borderWidth=1
        TextB.layer.borderColor=UIColor.yellowColor().CGColor
        TextC.backgroundColor=UIColor.grayColor()
        TextC.layer.cornerRadius=10
        TextC.layer.borderWidth=1
        TextC.layer.borderColor=UIColor.grayColor().CGColor
        TextD.backgroundColor=UIColor.grayColor()
        TextD.layer.cornerRadius=10
        TextD.layer.borderWidth=1
        TextD.layer.borderColor=UIColor.grayColor().CGColor
    }
    @IBAction func AnswerC(sender: AnyObject) {
        //defaults.setValue("C", forKeyPath: "answer")
        click("C")
        TextA.backgroundColor=UIColor.grayColor()
        TextA.layer.cornerRadius=10
        TextA.layer.borderWidth=1
        TextA.layer.borderColor=UIColor.grayColor().CGColor
        TextB.backgroundColor=UIColor.grayColor()
        TextB.layer.cornerRadius=10
        TextB.layer.borderWidth=1
        TextB.layer.borderColor=UIColor.grayColor().CGColor
        TextC.backgroundColor=UIColor.yellowColor()
        TextC.layer.cornerRadius=10
        TextC.layer.borderWidth=1
        TextC.layer.borderColor=UIColor.yellowColor().CGColor
        TextD.backgroundColor=UIColor.grayColor()
        TextD.layer.cornerRadius=10
        TextD.layer.borderWidth=1
        TextD.layer.borderColor=UIColor.grayColor().CGColor
    }
    @IBAction func AnswerD(sender: AnyObject) {
        //defaults.setValue("D", forKeyPath: "answer")
        click("D")
        TextA.backgroundColor=UIColor.grayColor()
        TextA.layer.cornerRadius=10
        TextA.layer.borderWidth=1
        TextA.layer.borderColor=UIColor.grayColor().CGColor
        TextB.backgroundColor=UIColor.grayColor()
        TextB.layer.cornerRadius=10
        TextB.layer.borderWidth=1
        TextB.layer.borderColor=UIColor.grayColor().CGColor
        TextC.backgroundColor=UIColor.grayColor()
        TextC.layer.cornerRadius=10
        TextC.layer.borderWidth=1
        TextC.layer.borderColor=UIColor.grayColor().CGColor
        TextD.backgroundColor=UIColor.yellowColor()
        TextD.layer.cornerRadius=10
        TextD.layer.borderWidth=1
        TextD.layer.borderColor=UIColor.yellowColor().CGColor
    }
    
    //Other Stuff
    @IBOutlet weak var TimerLabel: UILabel!
    @IBAction func ResetQuiz(sender: AnyObject) {
        score = 0
        time = 20
        timer = NSTimer()
        questionNumber = 1
        questionTotal = 2
        P1ScoreNumber=0
        P2ScoreNumber=0
        P3ScoreNumber=0
        P4ScoreNumber=0

        
        //Set initial values
        defaults.setValue(nil, forKeyPath: "answer")
        updateLabel(TimerLabel, text: String(20))
        
        
        //TODO: Find out how many players are connected
        if(numberOfPlayers<4){
            P4Image.alpha=0.4
        }
        if(numberOfPlayers<3){
            P3Image.alpha=0.4
        }
        if(numberOfPlayers<2){
            P2Image.alpha=0.4
        }
        
        
        //Set Answer labels and scores
        updateLabel(P1Answer, text: "")
        updateLabel(P2Answer, text: "")
        updateLabel(P3Answer, text: "")
        updateLabel(P4Answer, text: "")
        updateLabel(P1Score, text: String(P1ScoreNumber))
        updateLabel(P2Score, text: String(P2ScoreNumber))
        updateLabel(P3Score, text: String(P3ScoreNumber))
        updateLabel(P4Score, text: String(P4ScoreNumber))
        
        //Set question counter
        updateLabel(QuestionNumberLabel, text: "Question: "+String(questionNumber)+"/"+String(questionTotal))
        
        
        //TODO: Hide reset quiz button
        ResetButton.alpha=0
        ResetButton.enabled=false
        
        //TODO: Load Question 1
        
        //Set button colors
        TextA.backgroundColor=UIColor.grayColor()
        TextA.layer.cornerRadius=10
        TextA.layer.borderWidth=1
        TextA.layer.borderColor=UIColor.grayColor().CGColor
        TextB.backgroundColor=UIColor.grayColor()
        TextB.layer.cornerRadius=10
        TextB.layer.borderWidth=1
        TextB.layer.borderColor=UIColor.grayColor().CGColor
        TextC.backgroundColor=UIColor.grayColor()
        TextC.layer.cornerRadius=10
        TextC.layer.borderWidth=1
        TextC.layer.borderColor=UIColor.grayColor().CGColor
        TextD.backgroundColor=UIColor.grayColor()
        TextD.layer.cornerRadius=10
        TextD.layer.borderWidth=1
        TextD.layer.borderColor=UIColor.grayColor().CGColor

    }
    @IBOutlet weak var ResetButton: UIButton!
    
    
    //Variables
    var score = 0
    var time = 20
    var timer = NSTimer()
    var questionNumber = 1
    var questionTotal = 2
    var P1ScoreNumber=0
    var P2ScoreNumber=0
    var P3ScoreNumber=0
    var P4ScoreNumber=0
    
    var model = Model()
    var selectedAnswer = "A"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Find out how many players are connected
        if(numberOfPlayers<4){
            P4Image.alpha=0.4
        }
        if(numberOfPlayers<3){
            P3Image.alpha=0.4
        }
        if(numberOfPlayers<2){
            P2Image.alpha=0.4
        }
        
        
        //Set initial values
        defaults.setValue(nil, forKeyPath: "answer")
        updateLabel(TimerLabel, text: String(20))
        
        //Set Answer labels and scores
        updateLabel(P1Answer, text: "")
        updateLabel(P2Answer, text: "")
        updateLabel(P3Answer, text: "")
        updateLabel(P4Answer, text: "")
        updateLabel(P1Score, text: String(P1ScoreNumber))
        updateLabel(P2Score, text: String(P2ScoreNumber))
        updateLabel(P3Score, text: String(P3ScoreNumber))
        updateLabel(P4Score, text: String(P4ScoreNumber))
        
        //Set question counter
       
        updateLabel(QuestionNumberLabel, text: "Question: "+String(questionNumber)+"/"+String(questionTotal))
        
        
        //Hide reset quiz button
        ResetButton.alpha=0
        ResetButton.enabled=false
        
        //Load Question 1
        loadQuestion(1)
        
        
        //Set Timer
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(QuizViewController.updateTimer), userInfo: nil, repeats: true)
        /*Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(updateDeviceMotion), userInfo: nil, repeats: true)
        self.motion  motionManager.deviceMotionUpdateInterval = 1.0/60.0
        self.motionManager.startDeviceMotionUpdates(using: .xArbitraryCorrectedZVertical)*/
        
        //Set button colors
        TextA.backgroundColor=UIColor.grayColor()
        TextA.layer.cornerRadius=10
        TextA.layer.borderWidth=1
        TextA.layer.borderColor=UIColor.grayColor().CGColor
        TextB.backgroundColor=UIColor.grayColor()
        TextB.layer.cornerRadius=10
        TextB.layer.borderWidth=1
        TextB.layer.borderColor=UIColor.grayColor().CGColor
        TextC.backgroundColor=UIColor.grayColor()
        TextC.layer.cornerRadius=10
        TextC.layer.borderWidth=1
        TextC.layer.borderColor=UIColor.grayColor().CGColor
        TextD.backgroundColor=UIColor.grayColor()
        TextD.layer.cornerRadius=10
        TextD.layer.borderWidth=1
        TextD.layer.borderColor=UIColor.grayColor().CGColor
        
    }
    
    func updateTimer() {
        time=time-1
        if(time>0){
            updateLabel(TimerLabel, text: String(time))
        }else if(time == 0) {
            updateLabel(TimerLabel, text: "Times Up")
            submit()
            
            
        }else if (time < -3){
            time=20
            updateLabel(TimerLabel, text: String(time))
            if(questionNumber<questionTotal){
                questionNumber=questionNumber+1
                updateLabel(QuestionNumberLabel, text: "Question: "+String(questionNumber)+"/"+String(questionTotal))
                
                //Load next question here
                loadQuestion(questionNumber)
                
                
            }else if(questionNumber==questionTotal){
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
        button.setTitle(text, forState: .Normal)
    }
    
    func loadQuestion(questionNumber : Int) {
        let q = model.questions[questionNumber-1]
        QuestionLabel.text = q.sentence
        updateButtonText(TextA, text: q.A)
        updateButtonText(TextB, text: q.B)
        updateButtonText(TextC, text: q.C)
        updateButtonText(TextD, text: q.D)
    }
    
    
    ///////////Selecting questions
    
    func submit() {
        let q = model.questions[questionNumber-1]
        //TODO: fix scoring
        //Check for correct answer
        if (selectedAnswer == q.answer) {
            score += 42 //TODO fix scoring
        } else {
            score -= 77
            updateButtonText(getAnswerButton(selectedAnswer), text: "WRONG!")
        }
        
        //TODO: Highlight correct answer
        higlightButton(getAnswerButton(q.answer))
        
    }
    
    
    func getAnswerButton(letter : String) -> UIButton {
        if (letter == "A") {
            return TextA
        } else if (letter == "B") {
            return TextB
        } else if (letter == "C") {
            return TextC
        } else {
            return TextD
        }
    }
    
    func click(buttonLetter : String) {
        if (buttonLetter == selectedAnswer) {
            submit()
        } else {
            selectedAnswer = buttonLetter
            higlightButton(getAnswerButton(buttonLetter))
        }
    }
    
    
    func higlightButton(but : UIButton) {
        //TODO actually highlight button instead
        but.titleLabel?.text = "<" + but.titleLabel!.text! + ">"
    }
    
    
    ///////////Core Motion
    
    /*func updateDeviceMotion(){
        
        if let data = self.motionManager.deviceMotion {
            
            // orientation of body relat    ive to a reference frame
            let attitude = data.attitude
            
            let userAcceleration = data.userAcceleration
            
            let gravity = data.gravity
            let rotation = data.rotationRate
            
            //print("pitch: \(attitude.pitch), roll: \(attitude.roll), yaw: \(attitude.yaw)")
            
            updateBallWithRoll(CGFloat(attitude.roll), pitch: CGFloat(attitude.pitch), yaw: CGFloat(attitude.yaw), accX: CGFloat(userAcceleration.x), accY: CGFloat(userAcceleration.y), accZ: CGFloat(userAcceleration.z))
        }
        
    }*/
    
    
    
    
    
}

