//
//  NetworkManager.swift
//  CountryDetails
//
//  Created by C, Maheswaran (Cognizant) on 24/02/20.
//  Copyright © 2020 C, Maheswaran (Cognizant). All rights reserved.
//

import Foundation
import UIKit

let kURLString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
let requestUrl = URL(string: kURLString)
class NetworkManager: NSObject{
    var imageCache = NSCache<NSString, UIImage>()
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
    
    func getImageData(url: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()){
    session.dataTask(with: NSURL(string: url)! as URL, completionHandler: completion).resume()
            
    }
    func downloadImage(url: String, completion: @escaping (Data?, Error?) -> Void) {
        self.getImageData(url: url, completion: { (data, response, error) -> Void in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data, error == nil else {
                return
            }
            
                completion(data, error)
            
        })
    }
    func fetchimageFromServerURL(url: String){

        if(imageCache.object(forKey: url as NSString) != nil){
            
           // self.image = imageCache.object(forKey: url as NSString)
        }else{
    print("Download 3")
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            let task = session.dataTask(with: NSURL(string: url)! as URL, completionHandler: { (data, response, error) -> Void in
                print("Download 4")
                print(response)
                if error == nil {
                    DispatchQueue.main.async{
                        if let downloadedImage = UIImage(data: data!) {
                            //if (url == self.currentUrl) {//Only cache and set the image view when the downloaded image is the one from last request
                                self.imageCache.setObject(downloadedImage, forKey: url as NSString)
                                //self.image = downloadedImage
                                print("Download 5")
                                
                            //}

                        }
                    }
                    

                }
                else {
                    print(error)
                }
            })
            task.resume()
        }

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

