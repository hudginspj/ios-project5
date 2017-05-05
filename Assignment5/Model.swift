//
//  Model.swift
//  Assignment5
//
//  Created by Paul Hudgins on 4/30/17.
//  Copyright © 2017 Paul Hudgins. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Model {
    
    final var A = "A"
    final var B = "B"
    final var C = "C"
    final var D = "D"
    final var NoSub = ""
    
    var session: MCSession!
    //var messageCallback = {(data: [String: String]) -> Void in print("default message callback")}
    var updateCallback = {()->Void in print("default update callback")}

    var players = ["Default"]  //TODO set this
    var submissions = [String : String]()
    var scores = [String : String]()
    
    var score = 0
    var time = 20
    

    var selectedAnswer = "A"
    var submitted = false
    var notification = "Default Notification"
    
    
    var questionNumber = 0;
    var quizNumber = -1;
    var gameOver = false
    
    var quizzes : [[Question]] = []
    var questions : [Question] = []
    
    
    /////////Game logic
    

    func newQuiz() {
        gameOver = false
        score = 0
        quizNumber += 1
        if quizNumber == quizzes.count { quizNumber = 0 }
        questions = quizzes[quizNumber]
        questionNumber =  -1
        newQuestion()
    }
    
    func newQuestion(){
        submitted = false
        time = 20
        notification = "\(time)"
        selectedAnswer = A
        questionNumber += 1
        if questionNumber == questions.count {
            endGame()
        }
        updateCallback()
    }
    
    func endGame() {
        gameOver = true
        time = 5
        var maxScore = score
        for (_, scoreString) in scores {
            if let scoreInt = Int(scoreString) {
                maxScore = max(maxScore, scoreInt)
            }
        }
        if maxScore == score {
            notification = "You won!"
        } else if maxScore - score > 1 {
            notification = "You lost..."
        } else {
            notification = "You lost!"
        }
    }
    
    
    func tickClock() {
        time -= 1
        if (gameOver) {
            if time <= 0 {
                newQuiz()
            }
        } else {
            if time > 0 {
                notification = "\(time)"
            } else if time == 0 {
                notification = "Time's up!"
                submit()
            } else if time <= -3 {
                newQuestion()
            }
        }
        updateCallback()
    }
    
    func submit() {
        submitted = true
        if questions[questionNumber].answer == selectedAnswer {
            notification = "Correct!"
            score += 1
        } else {
            notification = "Wrong!"
        }
        updateCallback()
    }
    
    
    /////////////////////////////// Players logic
    
    func setName(_ name : String) {
        players[0] = name
    }
    
    func getName() -> String {
        return players[0]
    }
    
    func addPlayer(_ name : String) {
        submissions[name] = ""
        scores[name] = "0"
    }
    func join() {
        sendMessage(["type" : "join", "name" : getName()])
    }
    
    func restart() {
        
    }
    
    
    
    ///////////////Messaging
    func recieveMessage(_ data : [String:String]) {
        print("Got message \(data["type"])")
        if data["type"] == "join" {
            addPlayer(data["name"]!)
        }
        
        
        updateCallback()
    }
    
    func sendMessage(_ data : [String:String]) {
        
        //let dataToSend =  NSKeyedArchiver.archivedData(withRootObject: msg)
        let dataToSend =  NSKeyedArchiver.archivedData(withRootObject: data)
        print("Peers: " + String(session.connectedPeers.count))
        if (session.connectedPeers.count != 0) {
            do{
                try session.send(dataToSend, toPeers: session.connectedPeers, with: .unreliable)
            }
            catch let err {
                print("Error in sending data \(err)")
            }
        }
        //updateChatView(newText: msg!, id: peerID)
        
    }
    
    
    
}
