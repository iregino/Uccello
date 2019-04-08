//
//  CategoryTableViewController.swift
//  Ucello
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
                   
                   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // Preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MenuSegue" {
            let menuTableVC = segue.destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            print(categories[index])
            menuTableVC.category = categories[index]
        } //end if
    } //end prepare(for segue:)

} //end CategoryTableViewController{}
