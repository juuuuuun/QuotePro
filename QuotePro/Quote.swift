//
//  Quote.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit
import RealmSwift

class Quote: Object {
  
  // MARK: Properties
  
  @objc dynamic var quoteText: String = ""
  @objc dynamic var author: String = ""
  @objc dynamic var photo: Photo?
}
