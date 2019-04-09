//
//  OrderConfirmationViewController.swift
//  Uccello
//
//  Created by student14 on 4/7/19.
//  Copyright © 2019 student14. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.alpha = 1
        print(minutes!)
        timeRemainingLabel?.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."

    } //end viewDidLoad()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

} //end OrderConfirmationViewController{}
