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
    var session: MCSession!
    //var messageCallback = {(data: [String: String]) -> Void in print("default message callback")}
    var updateCallback = {()->Void in print("default update callback")}

    var selectedAnswer = "A"
    var questions : [Question] = []
    
    
    func setQuestions(_ quests: [Question]){
        self.questions = quests
    }
    
    ///////////////Messaging
    func recieveMessage(_ data : [String:String]) {
            
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
        
        
    /////////////////////////////// Game logic
    
    
    func submit() {
        
    }
    
    func tickClock() {
        
    }
    
    
    
}
