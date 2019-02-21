//
//  Quote.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

class Quote {
  
  // MARK: Properties
  
  var quoteText: String
  var author: String
  var photo: Photo?
  
  // MARK: Initializers
  
  init(quoteText: String, author: String) {
    self.quoteText = quoteText
    self.author = author
  }

}
