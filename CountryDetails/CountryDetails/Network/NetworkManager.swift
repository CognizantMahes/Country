//
//  NetworkManager.swift
//  CountryDetails
//
//  Created by C, Maheswaran (Cognizant) on 24/02/20.
//  Copyright © 2020 C, Maheswaran (Cognizant). All rights reserved.
//

import Foundation

let kURLString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
let requestUrl = URL(string: kURLString)
class NetworkManager: NSObject{
    let session = URLSession(configuration: URLSessionConfiguration.default)
    func fetchCountryDetails(completion: @escaping(Country?, Error?)-> Void){
        let task = URLSession.shared.countryTask() { countryObj, response, error in
         if countryObj != nil {
             print(countryObj!)
            completion(countryObj,error)
          }
        }
        task.resume()
    }
}
// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>( completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: requestUrl!) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                //print(error)
                return
            }
            let dataString = String(data: data, encoding: .isoLatin1)!
            let cleanData: NSData = Data(dataString.utf8) as NSData
            do {
                
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: cleanData as Data, options: .mutableLeaves) as? [String : NSArray] {
                    // Print out dictionary
                    print(convertedJsonIntoDict)
                    
               }
            } catch let error as NSError {
                print(error.localizedDescription)
            }

            completionHandler(try? JSONDecoder().decode(T.self, from: cleanData as Data), response, nil)
        }
    }

   func countryTask(completionHandler: @escaping (Country?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
       return self.codableTask(completionHandler: completionHandler)
    }
}
