//
//  HomeScreenViewController.swift
//  QuotePro
//
//  Created by Jun Oh on 2019-02-20.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  
  // MARK: Properties
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: ViewController Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  // MARK: UITableView Data Source
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as? QuoteTableViewCell else {
      fatalError("QuoteTableViewCell was not dequeued")
    }
    
    
    
    return cell
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
