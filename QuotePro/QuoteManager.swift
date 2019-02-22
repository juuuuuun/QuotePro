//
//  QuoteManager.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

protocol QuoteManagerDelegateProtocol: AnyObject {
  func receiveRandomQuote(_ quote: Quote)
}

class QuoteManager {

  // MARK: Properties
  
  var quotes: [Quote] = []
  weak var delegate: QuoteManagerDelegateProtocol?
  
  // MARK: QuoteManager Methods
  
  func addQuote(_ quote: Quote) {
    quotes.insert(quote, at: 0)
  }
  
  func getRandomQuote() {
    ForismaticAPIRequest.getQuote { (quoteText: String, author: String) in
      let quote = Quote()
      quote.quoteText = quoteText
      quote.author = author
      self.delegate?.receiveRandomQuote(quote)
    }
  }
  
  func deleteQuote(at index: Int) {
    quotes.remove(at: index)
  }
}
