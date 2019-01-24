//
//  APIManager.swift
//  SwiftyCompanion
//
//  Created by jdavin on 24/01/2019.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import Foundation

let                 CUSTOMER_KEY = "602b32b1966b6eb5271b298e89f7fef3e0f772fc86027398ed28acc76272c03c"
let                 CUSTOMER_SECRET = "c9abe954dd71d2d0955da4c128b737277c87e02e9d44b315721843499dc7668c"
let                 API_URL = "https://api.intra.42.fr/v2"
var                 token: String = ""

class APIManager: NSObject, URLSessionDelegate {

    func getToken(completion : @escaping((String?) -> ())) {
        let url = URL(string: "https://api.intra.42.fr/oauth/token?" +
                              "grant_type=client_credentials&client_id=" + CUSTOMER_KEY +
                              "&client_secret=" + CUSTOMER_SECRET)
        
        var req = URLRequest(url: url!)
        req.httpMethod = "POST"
        URLSession(configuration: .default, delegate: self, delegateQueue: .main).dataTask(with: req) { (data, response, err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            if let d = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: d, options: []) as? [String : Any]
                    completion(json!["access_token"] as? String)
                }
                catch (let err){
                    print(err.localizedDescription)
                    return
                }
            }
            }.resume()
    }
    
    func getStudent(_ login : String, completion: @escaping ((Student) -> ())) {
        let w = login.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlopt = URL(string: "https://api.intra.42.fr/v2/users/\(w)")
        guard let url = urlopt else { print("user's login not well formated"); return }
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession(configuration: .default, delegate: self, delegateQueue: .main).dataTask(with: req) { (data, response, err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            if let d = data {
                do {
                    let json = try JSONDecoder().decode(Student.self, from: d)
                    completion(json)
                }
                catch (let err){
                    print(err.localizedDescription)
                    return
                }
            }
            }.resume()
    }
}
