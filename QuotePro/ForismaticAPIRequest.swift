//
//  ForismaticAPIRequest.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

class ForismaticAPIRequest {
  
  // MARK: GET Requests
  
  class func getQuote(completion: @escaping (String, String) -> Void) {
    guard let url = ForismaticAPIRequest.buildURL() else {
      print("Could not create url")
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
      guard let data = data else {
        print("Invalid data returned")
        return
      }
      
      guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] else {
        print("Invalid JSON returned")
        return
      }
      
      guard let response = response as? HTTPURLResponse else {
        print("Invalid response returned")
        return
      }
      
      guard response.statusCode == 200 else {
        print("Did not receive 200 status code")
        return
      }
      
      guard let quoteText = json["quoteText"] as? String,
        let author = json["quoteAuthor"] as? String else {
        print("Quote text or author is nil")
        return
      }
      
      completion(quoteText, author)
    }
    task.resume()
  }
  
  // MARK: Helper Methods
  
  private class func buildURL() -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.forismatic.com"
    components.queryItems = [
      URLQueryItem(name: "method", value: "getQuote"),
      URLQueryItem(name: "lang", value: "en"),
      URLQueryItem(name: "format", value: "json")]
    var componentsURL = components.url
    componentsURL = componentsURL?.appendingPathComponent("api")
    componentsURL = componentsURL?.appendingPathComponent("1.0/")
    
    return componentsURL
  }
}
