//
//  BookTableViewController.swift
//  PMChallengeRedux
//
//  Created by Timothy Myers on 8/6/17.
//  Started at 1:30am
//  Copyright © 2017 Denver Coder. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    var bookData = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTableView()
    }
    
    func updateTableView() {
        Book.getBooks() { (results: [Book]?) in
            if let bookEntry = results {
                self.bookData = bookEntry
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return bookData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let bookObject = bookData[indexPath.row]
        cell.textLabel?.text = bookObject.title
        cell.imageView?.image = UIImage(named: bookObject.imageURL)

        return cell
    }
}
