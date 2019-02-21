//
//  LorempixelAPIRequest.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

class LorempixelAPIRequest {

  // MARK: GET Requests
  
  class func getRandomPhoto(endpoint: String, completion: @escaping (UIImage) -> Void) {
    guard let url = LorempixelAPIRequest.buildURL(endpoint: endpoint) else {
      print("Could not create url")
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
      guard let data = data else {
        print("Invalid data returned")
        return
      }
      
      guard let response = response as? HTTPURLResponse else {
        print("Invalid response returned")
        return
      }
      
      guard response.statusCode == 200 else {
        print("Status code is not 200")
        return
      }
      
      guard let image = UIImage(data: data) else {
        print("Invalid image received")
        return
      }
      completion(image)
    }
    task.resume()
  }
  
  // MARK: Helper Methods
  
  private class func buildURL(endpoint: String) -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "lorempixel.com"
    var componentsURL = components.url
    componentsURL = componentsURL?.appendingPathComponent(endpoint)
    
    
    return componentsURL
  }
}
