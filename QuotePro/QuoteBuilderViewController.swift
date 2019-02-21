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
  @IBOutlet weak var quoteView: QuoteView!
  
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
      self.quoteView.quoteLabel.text = quote.quoteText
      self.quoteView.authorLabel.text = quote.author
      self.quoteView.authorLabel.isHidden = false
      self.updateSaveButton()
    }
  }
  
  // MARK: PhotoManagerDelegateProtocol
  
  func receiveRandomPhoto(_ photo: Photo) {
    OperationQueue.main.addOperation {
      self.photo = photo
      self.quoteView.imageView.image = photo.image
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
