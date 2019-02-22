//
//  PhotoManager.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

protocol PhotoManagerDelegateProtocol: AnyObject {
  func receiveRandomPhoto(_ photo: Photo)
}

class PhotoManager {

  // MARK: Properties
  
  weak var delegate: PhotoManagerDelegateProtocol?
  
  // MARK: PhotoManager Methods
  
  func getRandomPhoto(width: Int, height: Int) {
    let endpointForSize = "\(width)/\(height)/"
    LorempixelAPIRequest.getRandomPhoto(endpoint: endpointForSize) { (image: UIImage) in
      let photo = Photo()
      photo.image = image.jpegData(compressionQuality: 1.0)
      self.delegate?.receiveRandomPhoto(photo)
    }
  }
}
