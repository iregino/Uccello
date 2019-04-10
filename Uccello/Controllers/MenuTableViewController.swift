//
//  MenuTableViewController.swift
//  Uccello
//
//  Created by Ian Regino on 4/7/19.
//  Copyright © 2019 Ian Regino. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    //Variables
    var category: String!
//    let menuController = MenuController()
    var menuItems = [MenuItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = category.capitalized
        MenuController.shared.fetchMenuItems(forCategory: category) { (menuItems) in
            if let menuItems = menuItems {
                self.updateUI(with: menuItems)
            } else {
                print("Unable to fetch menu items.")
            } //end if-let
        }
    } //end viewDidLoad()

    func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
    } //end updateUI()
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)

        configure(cell, forItemAt: indexPath)

        return cell
    }

    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath {
                    return
                }
                let cellImg : UIImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 80, height: 80))
                cellImg.image = image
                cell.imageView?.addSubview(cellImg)
                cell.setNeedsLayout()
            }
        }
        
    } //end configure()

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Navigation

    // Preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MenuDetailSegue" {
            let menuItemDetailVC = segue.destination as! MenuItemDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuItemDetailVC.menuItem = menuItems[index]
        } //end if
    } //end prepare(for segue:)


} //end MenuTableViewController{}
