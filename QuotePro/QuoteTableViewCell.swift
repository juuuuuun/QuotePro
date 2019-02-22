//
//  QuoteTableViewCell.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
  
  // MARK: Properties
  
  var quote: Quote?
  
  @IBOutlet weak var quoteLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var photoView: UIImageView!
  
  // MARK: QuoteTableViewCell Methods
  
  func configureCell() {
    quoteLabel.text = quote?.quoteText
    authorLabel.text = quote?.author
    if let image = quote?.photo?.image {
      photoView.image = UIImage(data: image)
    }
  }
  
  // MARK: UITableViewCell Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
