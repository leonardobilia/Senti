//
//  Services.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit
import TwitterKit

class Services {
    
    func fetchImageFrom(_ url: String, completion: @escaping (UIImage?, Error?) -> ()) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image, nil)
        }.resume()
    }
    
    func fetchTweets(from username: String, completion: @escaping ([Tweet]?, Error?) -> ()) {
        let client = TWTRAPIClient()
        let url = Constants.TwitterKit.baseUrl
        let params = ["screen_name": username, "count":"20", "include_rts": "false"]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", url: url, parameters: params, error: &clientError)
        client.sendTwitterRequest(request) { (response, data, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            guard let json = try? JSONDecoder().decode([Tweet].self, from: data) else { return }
            completion(json, nil)
        }
    }
    
    func fetchGoogleAnalysis(with text: String, completion: @escaping (SentimentAnalysis?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: Constants.GoogleCloud.baseUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["document": ["type": "PLAIN_TEXT", "content": text], "encodingType": "UTF8"] as [String : Any]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            guard let json = try? JSONDecoder().decode(SentimentAnalysis.self, from: data) else { return }
            completion(json, error)
        }.resume()
    }
}
