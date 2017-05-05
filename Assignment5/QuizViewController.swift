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
    let defaults = UserDefaults.standard
    
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
    
    
    func grayButtons() {
        TextA.backgroundColor=UIColor.gray
        TextA.layer.cornerRadius=10
        TextA.layer.borderWidth=1
        TextA.layer.borderColor=UIColor.gray.cgColor
        TextB.backgroundColor=UIColor.gray
        TextB.layer.cornerRadius=10
        TextB.layer.borderWidth=1
        TextB.layer.borderColor=UIColor.gray.cgColor
        TextC.backgroundColor=UIColor.gray
        TextC.layer.cornerRadius=10
        TextC.layer.borderWidth=1
        TextC.layer.borderColor=UIColor.gray.cgColor
        TextD.backgroundColor=UIColor.gray
        TextD.layer.cornerRadius=10
        TextD.layer.borderWidth=1
        TextD.layer.borderColor=UIColor.gray.cgColor
    }
    
    
    //Player images
    @IBOutlet weak var P1Image: UIImageView!
    @IBOutlet weak var P2Image: UIImageView!
    @IBOutlet weak var P3Image: UIImageView!
    @IBOutlet weak var P4Image: UIImageView!
    
    
    
    //Quiz Answer choices
    @IBAction func AnswerA(_ sender: AnyObject) {
        //defaults.setValue("A", forKeyPath: "answer")
      
        click("A")
    }
    @IBAction func AnswerB(_ sender: AnyObject) {
        //defaults.setValue("B", forKeyPath: "answer")
        click("B")
    }
    @IBAction func AnswerC(_ sender: AnyObject) {
        //defaults.setValue("C", forKeyPath: "answer")
        click("C")
    }
    @IBAction func AnswerD(_ sender: AnyObject) {
        //defaults.setValue("D", forKeyPath: "answer")
        click("D")
    }
    
    //Other Stuff
    @IBOutlet weak var TimerLabel: UILabel!
    @IBAction func ResetQuiz(_ sender: AnyObject) {
        
        timer = Timer()

        
        //Set initial values
        //defaults.setValue(nil, forKeyPath: "answer")
        //updateLabel(TimerLabel, text: String(20))
        
        
        //TODO: Find out how many players are connected
        P2Image.alpha=1
        P3Image.alpha=1
        P4Image.alpha=1
        if(numberOfPlayers<4){
            P4Image.alpha=0.4
        }
        if(numberOfPlayers<3){
            P3Image.alpha=0.4
        }
        if(numberOfPlayers<2){
            P2Image.alpha=0.4
        }
        
        
        //TODO: Hide reset quiz button
        ResetButton.alpha=0
        ResetButton.isEnabled=false
        
        model.newQuiz()

    }
    
    
    @IBOutlet weak var ResetButton: UIButton!
    
    
    //Variables
    var timer = Timer()
    
    
    var numberOfPlayers=1
    
    var model = Model()
    var motionManager: CMMotionManager!
    

    func tickClock() {
        model.tickClock()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //model.messageCallback = {(data : [String: String]) -> Void in
        //    self.TextB.setTitle(data["message"], for: UIControlState())
        //}
        model.updateCallback = self.update
        model.newQuiz()
        
        self.motionManager = CMMotionManager()
        self.motionManager.deviceMotionUpdateInterval = 1.0/60.0
        self.motionManager.startDeviceMotionUpdates(using: .xArbitraryCorrectedZVertical)
        Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(updateDeviceMotion), userInfo: nil, repeats: true)
        
        TextA.titleLabel?.adjustsFontSizeToFitWidth = true
        TextB.titleLabel?.adjustsFontSizeToFitWidth = true
        TextC.titleLabel?.adjustsFontSizeToFitWidth = true
        TextD.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //TODO: Find out how many players are connected
        P2Image.alpha=1
        P3Image.alpha=1
        P4Image.alpha=1
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
        
     
        //Hide reset quiz button
        ResetButton.alpha=0
        ResetButton.isEnabled=false
        
        
        //Set Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickClock), userInfo: nil, repeats: true)
        
        
        update()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabel(_ label: UILabel, text: String){
        label.text=text
    }
    func updateButtonText(_ button: UIButton, text: String){
        button.setTitle(text, for: UIControlState())
    }
    
    func loadQuestion(_ q : Question) {
        QuestionLabel.text = q.sentence
        updateButtonText(TextA, text: q.A)
        updateButtonText(TextB, text: q.B)
        updateButtonText(TextC, text: q.C)
        updateButtonText(TextD, text: q.D)
    }
    
    
    //////////Update from model
    func update() {
        print("Update Called")
        let quest = model.questions[model.questionNumber]
        updateLabel(TimerLabel, text: model.notification)
        loadQuestion(quest)
        if model.submitted {
            let but = getAnswerButton(quest.answer)
            but.backgroundColor=UIColor.green
            but.layer.borderColor=UIColor.green.cgColor
        } else {
            higlightButton(model.selectedAnswer)
        }
        
        if model.gameOver {
            ResetButton.alpha=100
            ResetButton.isEnabled=true
        }
        print("updating scores")
        
        updateLabel(P1Answer, text: model.getAns(0))
        updateLabel(P2Answer, text: model.getAns(1))
        updateLabel(P3Answer, text: model.getAns(2))
        updateLabel(P4Answer, text: model.getAns(3))
        updateLabel(P1Score, text: model.getScore(0))
        updateLabel(P2Score, text: model.getScore(1))
        updateLabel(P3Score, text: model.getScore(2))
        updateLabel(P4Score, text: model.getScore(3))
        
        updateLabel(QuestionNumberLabel, text: "Question: "+String(model.questionNumber + 1)+"/"+String(model.questions.count))

    }
    
    
    
    ///////////Selecting questions
    
   
    func getAnswerButton(_ letter : String) -> UIButton {
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
    
    func click(_ buttonLetter : String) {
        if (buttonLetter == model.selectedAnswer) {
            model.submit()
        } else {
            selectAns(buttonLetter)
        }
    }
    
    func selectAns(_ letter : String) {
        if (!model.submitted) {
            model.selectedAnswer = letter
            higlightButton(letter)
        }
    }
    
    
    func higlightButton(_ letter : String) {
        //but.titleLabel?.text = "<" + but.titleLabel!.text! + ">"
        let but = getAnswerButton(letter)
        
        grayButtons()
        
        but.backgroundColor=UIColor.yellow
        but.layer.borderColor=UIColor.yellow.cgColor
    }
    
    
    ///////////Core Motion
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
            print("shaked")
            model.submit()
        }
        
    }
    
    func updateDeviceMotion(){
        if let data = self.motionManager.deviceMotion {
            
            // orientation of body relat    ive to a reference frame
            let attitude = data.attitude
            
            let userAcceleration = data.userAcceleration
            
            //let gravity = data.gravity
            //let rotation = data.rotationRate
            
            //print("pitch: \(attitude.pitch), roll: \(attitude.roll), yaw: \(attitude.yaw)")
            if userAcceleration.z < -1.2 {
                print("pushed")
                model.submit()
            } else if (attitude.pitch < 0.1) {
                if model.selectedAnswer == "C" { selectAns("A") }
                if model.selectedAnswer == "D" { selectAns("B") }
            } else if (attitude.pitch > 0.6) {
                if model.selectedAnswer == "A" { selectAns("C") }
                if model.selectedAnswer == "B" { selectAns("D") }
            } else if (attitude.roll < -0.4) {
                if model.selectedAnswer == "B" { selectAns("A") }
                if model.selectedAnswer == "D" { selectAns("C") }
            } else if (attitude.roll > 0.4) {
                if model.selectedAnswer == "A" { selectAns("B") }
                if model.selectedAnswer == "C" { selectAns("D") }
            }
        }
        
    }
    
    
    
}

