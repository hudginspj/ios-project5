//
//  ViewController.swift
//  Assignment5
//
//  Created by Paul Hudgins on 4/16/17.
//  Copyright © 2017 Paul Hudgins. All rights reserved.
//

import UIKit

import MultipeerConnectivity

class ViewController: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate  {
    
    
    //var session: MCSession!
    var peerID: MCPeerID!
    
    var browser: MCBrowserViewController!
    var assistant: MCAdvertiserAssistant!
    var model = Model()

    //Main Screen Images (currently unused)
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var MultiplayerImage: UIImageView!
    @IBOutlet weak var SinglePlayerImage: UIImageView!
    
    @IBOutlet weak var MultiButton: UIButton!
    @IBOutlet weak var SingleButton: UIButton!
    @IBOutlet weak var StartButton: UIButton!
    //Set user defaults
    let defaults = UserDefaults.standard
    
    
    @IBAction func ChooseSingle(_ sender: AnyObject) {
        //Change settings to single player mode
        setSingle()
        
        model.sendMessage(msg: "Ping")
    }
    func setSingle() {
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
        
        present(browser, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSingle()
        
        
        JsonLoader.getJSONData(model.setQuestions)
        
        self.peerID = MCPeerID(displayName: UIDevice.current.name + String(arc4random()%100))
        model.session = MCSession(peer: peerID)
        self.browser = MCBrowserViewController(serviceType: "chat", session: model.session)
        self.assistant = MCAdvertiserAssistant(serviceType: "chat", discoveryInfo: nil, session: model.session)
        
        assistant.start()
        model.session.delegate = self
        browser.delegate = self
        model.messageCallback = {(msg : String) -> Void in
            self.SingleButton.setTitle(msg, for: UIControlState())
        }
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
    
    ///////////////////////////
    /// Peer to peer
    
    

    
    
    
    //**********************************************************
    // required functions for MCBrowserViewControllerDelegate
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        // Called when the browser view controller is dismissed
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        // Called when the browser view controller is cancelled
        dismiss(animated: true, completion: nil)
    }
    //**********************************************************
    
    
    
    
    //**********************************************************
    // required functions for MCSessionDelegate
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        // this needs to be run on the main thread
        DispatchQueue.main.async(execute: {
            
            if let receivedString = NSKeyedUnarchiver.unarchiveObject(with: data) as? String{
                //self.updateChatView(newText: receivedString, id: peerID)
                //self.SingleButton.setTitle(receivedString, for: UIControlState())
                self.model.messageCallback(receivedString)
            }
            
        })
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
        // Called when a connected peer changes state (for example, goes offline)
        
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
        
    }
    //**********************************************************
    



}

