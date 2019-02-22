//
//  QuoteBuilderViewController.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

protocol QuoteBuilderViewControllerDelegateProtocol: AnyObject {
  func receiveQuote(_ quote: Quote)
}

class QuoteBuilderViewController: UIViewController, QuoteManagerDelegateProtocol, PhotoManagerDelegateProtocol {
  
  // MARK: Properties
  
  @IBOutlet weak var saveButton: UIBarButtonItem!
  var quoteView: QuoteView!
  
  var delegate: QuoteBuilderViewControllerDelegateProtocol?
  
  var quote: Quote?
  var photo: Photo?
  var quoteManager: QuoteManager?
  var photoManager: PhotoManager!
  
  // MARK: ViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    quoteManager?.delegate = self
    
    photoManager = PhotoManager()
    photoManager.delegate = self
    
    quoteView = QuoteView(frame: .zero)
    quoteView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(quoteView)
    
    quoteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    quoteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    quoteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    quoteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    
    // Do any additional setup after loading the view.
    let quoteTap = UITapGestureRecognizer(target: self, action: #selector(quoteTapped))
    quoteView.quoteLabel.addGestureRecognizer(quoteTap)
    
    let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    quoteView.imageView.addGestureRecognizer(imageTap)
  }
  
  // MARK: QuoteManagerDelegateProtocol
  
  func receiveRandomQuote(_ quote: Quote) {
    OperationQueue.main.addOperation {
      self.quote = quote
      if let photo = self.photo {
        self.quote?.photo = photo
      }
      self.quoteView.setupWithQuote(quote)
      self.quoteView.authorLabel.isHidden = false
      self.updateSaveButton()
    }
  }
  
  // MARK: PhotoManagerDelegateProtocol
  
  func receiveRandomPhoto(_ photo: Photo) {
    OperationQueue.main.addOperation {
      self.photo = photo
      if let quote = self.quote {
        quote.photo = photo
        self.quoteView.setupWithQuote(quote)
      } else {
        let quote = Quote()
        quote.quoteText = "No quote selected"
        quote.photo = photo
        self.quoteView.setupWithQuote(quote)
      }
      self.updateSaveButton()
    }
  }
  
  // MARK: Actions
  
  @objc func quoteTapped(_ sender: UITapGestureRecognizer) {
    quoteManager?.getRandomQuote()
  }
  
  @objc func imageTapped(_ sender: UITapGestureRecognizer) {
    photoManager.getRandomPhoto(width: Int(quoteView.bounds.width), height: Int(quoteView.bounds.height))
  }
  
  // MARK: Navigation
  
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func save(_ sender: UIBarButtonItem) {
    if let quote = quote, let photo = photo {
      quote.photo = photo
      self.delegate?.receiveQuote(quote)
    }
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: Private Helper Methods
  
  private func updateSaveButton() {
    if quote != nil && photo != nil {
      saveButton.isEnabled = true
    }
  }
  
}
