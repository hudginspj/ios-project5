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
    var subRecieved = [String : Bool]()
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
    
    func addQuiz(_ quiz : [Question]) {
        quizzes.append(quiz)
    }
    
    
    /////////Game logic
    

    func newQuiz() {
        print("newQuiz called")
        gameOver = false
        score = 0
        quizNumber += 1
        if quizNumber >= quizzes.count { quizNumber = 0 }
        questions = quizzes[quizNumber]
        questionNumber =  -1
        newQuestion()
    }
    
    func newQuestion(){
        print("newQuestion called")
        submitted = false
        for var (nam, _) in subRecieved {
            subRecieved[nam] = false
        }
        time = 10
        notification = "\(time)"
        selectedAnswer = A
        questionNumber += 1
        if questionNumber == questions.count {
            questionNumber -= 1
            endGame()
        }
        updateCallback()
    }
    
    func endGame() {
        print("endGame called")
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
        print("tick called")
        time -= 1
        if (gameOver) {
            if time <= 0 {
                //newQuiz()
            }
        } else {
            if time > 0 {
                if !submitted {notification = "\(time)"}
            } else if time == 0 {
                if !submitted {
                    notification = "Time's up!"
                    submit()
                }
            } else if time <= -3 {
                newQuestion()
            }
        }
        updateCallback()
    }
    
    func submit() {
        print("submit called")
        submitted = true
        if questions[questionNumber].answer == selectedAnswer {
            notification = "Correct!"
            score += 1
        } else {
            score -= 1
            notification = "Wrong!"
        }
        scores[players[0]] = "\(score)"
        submissions[players[0]] = selectedAnswer
        subRecieved[players[0]] = true
        sendMessage(["type" : "submit", "name" : getName(), "ans" : selectedAnswer, "score": "\(score)" ])
        checkIfAllSubmitted()
        
        updateCallback()
    }
    
    
    /////////////////////////////// Players logic
    
    func getScore(_ n : Int) -> String {
        if (n >= players.count) {
            return ""
        } else if let scr = scores[players[n]] {
            return scr
        } else {
            return "s??"
        }
    }
    func getAns(_ n : Int) -> String {
        if (!submitted) {
            return ""
        }
        
        
        if (n >= players.count) {
            return ""
        } else if let ans = submissions[players[n]],
                  let rec = subRecieved[players[n]] {
            if rec {
                return ans
            } else {
                return ""
            }
        } else {
            return "err"
        }
    }
    
    func getName() -> String {
        return players[0]
    }
    
    func setName(_ name : String) {
        players[0] = name
        submissions[name] = ""
        subRecieved[name] = false
        scores[name] = "0"
    }
    
    func addPlayer(_ name : String) {
        if !players.contains(name) {
            players.append(name)
            submissions[name] = ""
            subRecieved[name] = false
            scores[name] = "0"
        }
    }
    func join() {
        sendMessage(["type" : "join", "name" : getName()])
    }
    
    //TODO not called right now
    func sendStart() {
        sendMessage(["type" : "start", "name" : getName()])
    }
    
    func restart() {
        //TODO
    }
    
    func checkIfAllSubmitted() {
        var allReccieved = true
        for var (_, subR) in subRecieved {
            allReccieved = allReccieved && subR
        }
        if allReccieved && time > 0 {
            time = 0
        }
    }
    
    
    
    ///////////////Messaging
    func recieveMessage(_ data : [String:String]) {
        print("Got message \(data["type"])")
        if data["type"] == "join" {
            addPlayer(data["name"]!)
        } else if data["type"] == "start" {
            addPlayer(data["name"]!)
            join()
        } else if data["type"] == "submit" {
            scores[data["name"]!] = data["score"]
            submissions[data["name"]!] = data["ans"]
            subRecieved[data["name"]!] = true
            checkIfAllSubmitted()
        }
        
        
        updateCallback()
    }
    
    func sendMessage(_ data : [String:String]) {
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

    }
    
    
    
}
