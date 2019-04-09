//
//  CategoryTableViewController.swift
//  Uccello
//
//  Created by Ian Regino on 4/7/19.
//  Copyright © 2019 Ian Regino. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    //Variables
//    let menuController = MenuController()
    var categories = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MenuController.shared.fetchCategories { (categories) in
            if let categories = categories {
                self.udpdateUI(with: categories)
            } else {
                print("No menu categories available.")
            }
        } //end closure
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    } //end viewDidLoad()

    
    func udpdateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    } //end updateUI()
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        
        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexpath: IndexPath) {
        
        let categoryString = categories[indexpath.row]
        cell.textLabel?.text = categoryString.capitalized
    }
                   
    
    // MARK: - Navigation

    // Preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MenuSegue" {
            let menuTableVC = segue.destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuTableVC.category = categories[index]
        } //end if
    } //end prepare(for segue:)

} //end CategoryTableViewController{}
