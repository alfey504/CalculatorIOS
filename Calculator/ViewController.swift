//
//  ViewController.swift
//
//  Calculator
//  ---------------------------------------------------------------
//  A basic calculator that does all the basic calculator function
//  like add, subtract, divide etc.
//
//  Date : 09/22/2022
//
//  Author 1:
//  Name        :   Abraham Alfred Babu
//  Student ID  :   301270598
//
//  Author 2:
//  Name        :   Pia Mae Obias
//  Student ID  :   801283632
//
//  Author 3:
//  Name        :   Betrand Nyarko
//  Student ID  :   301293794

import UIKit

class ViewController: UIViewController {
    
    // reference to all the number buttons
    @IBOutlet var numberButtons: [UIButton]!
    
    // reference to all the command buttons
    @IBOutlet var commandButtons: [UIButton]!
    
    // reference to the backspace button
    @IBOutlet weak var backspace: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding shadows and and font to all the number buttons
        for numBtn in numberButtons {
            numBtn.titleLabel?.font =  UIFont(name: "Helvetica Neue", size: 33)
            numBtn.layer.shadowOpacity = 0.7
            numBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
            numBtn.layer.shadowRadius = 3
            numBtn.layer.shadowColor = UIColor.black.cgColor
        }
        
        // Adding shadows and and fonts to all the command buttons
        for cmdBtn in commandButtons {
            cmdBtn.titleLabel?.font =  UIFont(name: "Helvetica Neue", size: 33)
            cmdBtn.layer.shadowOpacity = 0.7
            cmdBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
            cmdBtn.layer.shadowRadius = 3
            cmdBtn.layer.shadowColor = UIColor.black.cgColor
        }
        
        // Changing the font of the backspace button
        backspace.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 60)
        
    }
    
    // Changing the color of the elements in the status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

