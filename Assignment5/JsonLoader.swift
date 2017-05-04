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
    
    static func getJSONData(_ completionHandler: @escaping (([Question])-> Void)) {
        
        let urlString = "http://people.vcu.edu/~ebulut/jsonFiles/quiz1.json"
        let url = URL(string: urlString)
        
        let session = URLSession.shared
        var questions : [Question] = []
        
        // create a data task
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if let result = data{
                
                print("inside get JSON")
                do{
                    let json = try JSONSerialization.jsonObject(with: result, options: .allowFragments)

                    
                    if let jsondic = json as? Dictionary<String, Any>,
                        let lst = jsondic["questions"] as? NSArray {
                        for questionJ in lst {
                            //print(questionJson["correctOption"])
                            
                            if let questionJson = questionJ as? Dictionary<String, Any>,
                                let sent = questionJson["questionSentence"] as? String,
                                let n = questionJson["number"] as? Int,
                                let opts = questionJson["options"] as? Dictionary<String, Any>,
                                let a = opts["A"] as? String,
                                let b = opts["B"] as? String,
                                let c = opts["C"] as? String,
                                let d = opts["D"] as? String,
                                let ans = questionJson["correctOption"] as? String
                               {
                                let question = Question()
                                question.sentence = sent
                                question.number = n
                                question.A = a
                                question.B = b
                                question.C = c
                                question.D = d
                                question.answer = ans
                                questions.append(question)
                                print("Reading Json, A: \(question.A)")
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
