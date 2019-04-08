//
//  OrderConfirmationViewController.swift
//  Ucello
//
//  Created by student14 on 4/7/19.
//  Copyright © 2019 student14. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(minutes!)
        timeRemainingLabel?.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."

    } //end viewDidLoad()

} //end OrderConfirmationViewController{}
