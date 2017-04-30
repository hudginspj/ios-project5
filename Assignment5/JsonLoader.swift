//
//  JsonLoader.swift
//  Assignment5
//
//  Created by Paul Hudgins on 4/16/17.
//  Copyright © 2017 Paul Hudgins. All rights reserved.
//

import Foundation
import WebKit


class JsonLoader {
    
    static func getJSONData(completionHandler: (([Question])-> Void)) {
        
        let urlString = "http://people.vcu.edu/~ebulut/jsonFiles/quiz1.json"
        let url = NSURL(string: urlString)
        
        let session = NSURLSession.sharedSession()
        var questions : [Question] = []
        
        // create a data task
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            
            if let result = data{
                
                print("inside get JSON")
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(result, options: .AllowFragments)

                    
                    if let topic = json["topic"] as? String {
                        print(topic)
                    }
                    
                    if let lst = json["questions"] as? NSArray {
                        for questionJson in lst {
                            print(questionJson["correctOption"])
                            
                            
                            if let sent = questionJson["questionSentence"] as? String,
                                let a = questionJson["options"]!!["A"] as? String,
                                let b = questionJson["options"]!!["B"] as? String,
                                let c = questionJson["options"]!!["C"] as? String,
                                let d = questionJson["options"]!!["D"] as? String,
                                let ans = questionJson["correctOption"] as? String
                               {
                                let question = Question()
                                question.sentence = sent
                                question.A = a
                                question.B = b
                                question.C = c
                                question.D = d
                                question.answer = ans
                                questions.append(question)
                                //print("A: \(question.A)")
                            } else { print("bad JSON 2")}
                            
                        }
                    } else { print("bad JSON")}
                    //for x in questions {
                    //    print("Loop B:\(x.B)")
                    //}
                    completionHandler(questions)
                    
                }
                catch{
                    print("Error")
                }
            }
            
        })
        task.resume()

    }
    
}