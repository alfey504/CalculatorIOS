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
    var historyRefreshReady: Bool = false
    var resultState: Bool = false
    
    // to store all the operators and operands
    var prefixStack = MathExpression()
    
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
        let currentInput = button.titleLabel!.text
        let resultLabelText = resultLabel.text
        
        if(!resultState){
            switch currentInput {
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
                    resultLabel.text?.append(currentInput!)
                }
            }
        }else{
            resultLabel.text = ""
            if(!resultLabelReady) {
                resultLabelReady = true
            }
            resultLabel.text?.append(currentInput!)
            resultState = false
        }
    }
    
    
    @IBAction func operatorClicked(_ sender: UIButton) {
        let button = sender as UIButton
        let currentOperator  = button.titleLabel!.text
        let currentOperand = resultLabel.text
        
        if(historyRefreshReady){
            historyRefreshReady = false
            prefixStack.clearHistory()
        }
        
        if(resultState){
            resultState = false
        }
        inputHandler(currentOperator: currentOperator!, currentOperand: currentOperand!)
    }
    
    func inputHandler(currentOperator: String, currentOperand:String){
        
        switch currentOperator{
        case "C":
            clearCalculator()
        case "⌫":
            if(resultLabel.text?.count == 1){
                resultLabel.text? = "0"
            }else{
                resultLabel.text?.removeLast()
            }
        case "+/-":
            if(resultLabel.text!.contains("-")){
                resultLabel.text?.removeFirst()
            }else{
                resultLabel.text? = "-" + resultLabel.text!
            }
        case "=":
            prefixStack.pushToPrefixStack(op: currentOperator, oprand: currentOperand)
            print("prefixStack:-")// for reference
            prefixStack.printStack()
            let result = prefixStack.evaluate()
            resultLabel.text = String(result)
            resultLabelReady = false
            historyRefreshReady = true
            resultState = true
        default:
            prefixStack.pushToPrefixStack(op: currentOperator, oprand: currentOperand)
            print("prefixStack:-")// for reference
            prefixStack.printStack()
            if(prefixStack.prefixExpression.count >= 3){
                let result = prefixStack.evaluate(incomplete: true)
                resultLabel.text = result
                resultLabelReady = false
            }else{
                resultLabel.text? = "0"
            }
            
        }
        historyLabel.text?  = prefixStack.history.joined()
        
    }
    
    func clearCalculator() {
        prefixStack.clearAll()
        historyLabel.text? = ""
        resultLabel.text? = "0"
        resultLabelReady = true
    }
}
