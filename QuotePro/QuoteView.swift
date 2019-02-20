//
//  QuoteView.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

class QuoteView: UIView {

  // MARK: Properties
  
  let nibName = "QuoteView"
  var contentView: UIView?
  
  @IBOutlet weak var quoteLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  // MARK: Actions
  
  @IBAction func quoteTapped(_ sender: UITapGestureRecognizer) {
    quoteLabel.text = "Best quote"
    authorLabel.text = "ME"
    authorLabel.isHidden = false
    print("Quote Tapped")
  }
  @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
    imageView.image = UIImage(named: "clicked")
    print("Image Tapped")
  }
  
  // MARK: Initializers
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    guard let view = loadViewFromNib() else { return }
    view.frame = self.bounds
    self.addSubview(view)
    contentView = view
  }
  
  // MARK: Xib Methods
  
  func loadViewFromNib() -> UIView? {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: nibName, bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil).first as? UIView
  }
}
