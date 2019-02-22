//
//  HomeScreenViewController.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, QuoteBuilderViewControllerDelegateProtocol {
  
  
  // MARK: Properties
  
  @IBOutlet weak var tableView: UITableView!
  var quoteManager: QuoteManager!
  
  // MARK: ViewController Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    tableView.delegate = self
    tableView.dataSource = self
    
    quoteManager = QuoteManager()
  }
  
  // MARK: QuoteBuilderViewControllerDelegateProtocol
  
  func receiveQuote(_ quote: Quote) {
    quoteManager.addQuote(quote)
    tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
  }
  
  // MARK: UITableView Data Source
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return quoteManager.quotes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as? QuoteTableViewCell else {
      fatalError("QuoteTableViewCell was not dequeued")
    }
    
    cell.quote = quoteManager.quotes[indexPath.row]
    cell.configureCell()
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row from the data source
      quoteManager.deleteQuote(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let quoteView = QuoteView(frame: view.frame)
    quoteView.setupWithQuote(quoteManager.quotes[indexPath.row])
    UIGraphicsBeginImageContext(quoteView.bounds.size)
    quoteView.drawHierarchy(in: quoteView.bounds, afterScreenUpdates: true)
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    present(UIActivityViewController(activityItems: [image], applicationActivities: nil), animated: true)
  }
  
  // MARK: Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "segueToQuoteBuilder" {
      if let destinationViewController = segue.destination.children[0] as? QuoteBuilderViewController {
        destinationViewController.quoteManager = quoteManager
        destinationViewController.delegate = self
      }
    }
  }
  
}
