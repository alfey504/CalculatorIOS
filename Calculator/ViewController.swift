//
//  ViewController.swift
//
//  Calculator
//  ---------------------------------------------------------------
//  A basic calculator that does all the basic calculator function
//  like add, subtract, divide etc.
//
//  Date : 09/22/2022
//  Version: 1.0
//
//  Author 1:
//  Name        :   Abraham Alfred Babu
//  Student ID  :   301270598
//
//  Author 2:
//  Name        :   Pia Mae Obias
//  Student ID  :   301283632
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
    
    // reference to the result label
    @IBOutlet weak var resultLabel: UILabel!
    
    // refernce to history label
    @IBOutlet weak var historyLabel: UILabel!
    
    var resultLabelReady: Bool = true
    var operandStack: [Float] = [] // stack for storing operands
    var operatorStack: [String] = [] // stack for storing operator
    var historyStack: [String] = [] // for populating the history label with data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding shadows to all the number buttons
        for numBtn in numberButtons {
            numBtn.layer.shadowOpacity = 0.7
            numBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
            numBtn.layer.shadowRadius = 3
            numBtn.layer.shadowColor = UIColor.black.cgColor
        }
        
        // Adding shadows to all the command buttons
        for cmdBtn in commandButtons {
            cmdBtn.layer.shadowOpacity = 0.7
            cmdBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
            cmdBtn.layer.shadowRadius = 3
            cmdBtn.layer.shadowColor = UIColor.black.cgColor
        }
    }
    
    // Changing the color of the elements in the status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func numberClicked(_ sender: UIButton) {
        let button = sender as UIButton
        let curentInput = button.titleLabel!.text
        let resultLabelText = resultLabel.text
        
        switch curentInput {
            case "0":
                if (resultLabelText != "0"){
                    resultLabel.text?.append("0")
                }
            case ".":
                if (!resultLabelText!.contains(".")){
                    resultLabel.text?.append(".")
                }
            default:
                if (resultLabelText == "0" || !resultLabelReady){
                    resultLabel.text = ""
                    resultLabelReady = true
                }
                
                if(resultLabelReady){
                    resultLabel.text?.append(curentInput!)
                }
        }
    }
    
    
    @IBAction func operatorClicked(_ sender: UIButton) {
        let button = sender as UIButton
        let currentOperator  = button.titleLabel!.text
        let currentOperand = resultLabel.text
        evaluate(currentOperator: currentOperator!, currentOperand: currentOperand!)
    }
    
    func evaluate(currentOperator: String, currentOperand:String){
        
        if(operatorStack.isEmpty){
            operandStack.append(Float(currentOperand)!)
            operatorStack.append(currentOperator)
            resultLabel.text? = "0"
        }else{
            let lhs = operandStack.last
            operandStack.removeLast()
            let rhs = Float(currentOperand)!
            let op =  operatorStack.last
            operatorStack.removeLast()
            resultLabel.text = "0"
            
            let result = calculate(lhs: lhs!, rhs: rhs, op:op!)
            operandStack.append(result)
            operatorStack.append(currentOperator)
            historyLabel.text = String(result)
        }
    }
    
    func calculate(lhs:Float, rhs:Float, op:String) -> Float{
        
        switch op {
            case "+":
                return(lhs+rhs)
            case "-":
                return(lhs-rhs)
            case "÷":
                return(lhs/rhs)
            case "x":
                return(lhs*rhs)
            default:
                return(0)
        }
    }
}

