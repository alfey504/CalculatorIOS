//
//  ViewController.swift
//  Calculator
//
//  Created by Abraham Alfred Babu on 2022-09-23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var commandButtons: [UIButton]!
    @IBOutlet weak var backspace: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for numBtn in numberButtons {
            numBtn.titleLabel?.font =  UIFont(name: "Helvetica Neue", size: 33)
            numBtn.layer.shadowOpacity = 0.7
            numBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
            numBtn.layer.shadowRadius = 3
            numBtn.layer.shadowColor = UIColor.black.cgColor
        }
        
        for cmdBtn in commandButtons {
            cmdBtn.titleLabel?.font =  UIFont(name: "Helvetica Neue", size: 33)
            cmdBtn.layer.shadowOpacity = 0.7
            cmdBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
            cmdBtn.layer.shadowRadius = 3
            cmdBtn.layer.shadowColor = UIColor.black.cgColor
        }
        backspace.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 60)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

