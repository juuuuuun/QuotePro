//
//  QuoteManager.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit
import RealmSwift

protocol QuoteManagerDelegateProtocol: AnyObject {
  func receiveRandomQuote(_ quote: Quote)
}

class QuoteManager {

  // MARK: Properties
  
  var quotes: [Quote] = []
  weak var delegate: QuoteManagerDelegateProtocol?
  
  // MARK: QuoteManager Methods
  
  func addQuote(_ quote: Quote) {
    realmWrite(quote: quote)
    quotes.append(quote)
  }
  
  func getRandomQuote() {
    ForismaticAPIRequest.getQuote { (quoteText: String, author: String) in
      let quote = Quote()
      quote.quoteText = quoteText
      quote.author = author
      self.delegate?.receiveRandomQuote(quote)
    }
  }
  
  func loadQuotes() {
    let results = realmRead()
    for quote in results {
      quotes.append(quote)
    }
  }
  
  func deleteQuote(at index: Int) {
    let quote = quotes[index]
    realmDelete(quote: quote)
    quotes.remove(at: index)
  }
  
  // MARK: Realm Private Helper Methods
  
  private func realmWrite(quote: Quote) {
    let realm = try! Realm()
    try! realm.write {
      realm.add(quote)
    }
  }
  
  private func realmRead() -> Results<Quote> {
    let realm = try! Realm()
    let results = realm.objects(Quote.self)
    return results
  }
  
  private func realmDelete(quote: Quote) {
    let realm = try! Realm()
    try! realm.write {
      realm.delete(quote)
    }
  }
}
