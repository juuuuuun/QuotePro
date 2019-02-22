//
//  Photo.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

import Realm
import RealmSwift

class Photo: Object {

  // MARK: Properties
  
  @objc dynamic var image: Data?
  
  // MARK: Initializers
  
//  init(image: UIImage) {
//    self.image = image
//  }
}
