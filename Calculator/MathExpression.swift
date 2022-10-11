//
//  PrefixStack.swift
//  Calculator
//
//  Created by Abraham Alfred Babu on 2022-10-08.
//

import Foundation


struct MathExpression{
    var prefixExpression :Array<String> = []
    var history: Array<String> = []
    let operatorList = ["+", "-", "x", "÷", "%"]
    let IS_LAST_OPERATOR: String = "lastOp"
    var LAST_OPERATOR_POS: Int = 0
    
    mutating func push(val: String){
        prefixExpression.append(val)
    }
    
    func getPreviousOperator(index: Int) -> (String, Int){
        for i in (0...index).reversed(){
            print(i)
            if(operatorList.contains(self.prefixExpression[i])){
                return(prefixExpression[i], i)
            }
        }
        return(IS_LAST_OPERATOR, 0)
    }
    
    func dmasCompare(op1: String, op2: String) -> Bool {
        if(op1 == "÷"){
            if(op2 != "%"){
                return(true)
            }else{
                return(false)
            }
        }else if(op1 == "x"){
            if(op2 != "%" && op2 != "÷"){
                return(true)
            }else{
                return(false)
            }
        }else if(op1 == "+"){
            if(op2 != "%" && op2 != "÷" && op2 != "x"){
                return(true)
            }else{
                return(false)
            }
        }else if(op1 == "-"){
            if(op2 != "%" && op2 != "÷" && op2 != "x" && op2 != "+"){
                return(true)
            }else{
                return(false)
            }
        }
        return(false)
    }
    
    mutating func pushToPrefixStack(op: String, oprand: String) {
        self.putToHistory(op: op, oprand: oprand)
        if(self.prefixExpression.isEmpty){
            self.push(val: op)
            self.push(val: oprand)
            LAST_OPERATOR_POS = self.prefixExpression.count-2
        }else if(op == "="){
            self.push(val: oprand)
        }else{
            let lastOp = self.prefixExpression[self.LAST_OPERATOR_POS]
            if(dmasCompare(op1: op, op2: lastOp)){
                self.push(val: op)
                self.push(val: oprand)
                LAST_OPERATOR_POS = self.prefixExpression.count-2
            }else{
                self.prefixExpression.insert(op, at: self.LAST_OPERATOR_POS)
                self.push(val: oprand)
            }
        }
    }
    
    func replaceInPlace(array: Array<String>,val: String, index: Int) -> Array<String>{
        var temp = array
        temp.remove(at: index)
        temp.remove(at: index)
        temp.remove(at: index)
        temp.insert(val, at: index)
        return temp
    }
    
    mutating func evaluate(incomplete: Bool = false) -> String{
        var temp = self.prefixExpression
        
        if(incomplete){
            temp.remove(at: LAST_OPERATOR_POS)
        }
        
        for i in (0...temp.count-1).reversed(){
            if(operatorList.contains(temp[i])){
                let lhs = Float(temp[i+1]) ?? 0, rhs = Float(temp[i+2]) ?? 0, op = temp[i]
                let result = self.calculate(lhs: lhs, rhs: rhs, op: op)
                temp = replaceInPlace(array:temp, val: result, index: i)
            }
        }
        return(temp[0])
    }
    
    func calculate(lhs: Float, rhs:Float, op:String) -> String{
        var result: Float
        switch op {
            case "+":
                result = lhs + rhs
            case "-":
                result = lhs - rhs
            case "÷":
                result = lhs / rhs
            case "x":
                result = lhs * rhs
            case "%":
                result = lhs / 100 * rhs
            default:
                result = 0
            }
        return(String(result))
    }
    
    mutating func putToHistory(op: String, oprand:String){
        self.history.append(oprand)
        if(op != "="){
            self.history.append(op)
        }
    }
    
    mutating func clearAll(){
        self.clearPrefixStack()
        self.clearHistory()
    }
    
    mutating func clearPrefixStack(){
        self.prefixExpression = []
        self.LAST_OPERATOR_POS = 0
    }
    
    mutating func clearHistory(){
        self.history = []
    }
    
    func printStack(){
        print(self.prefixExpression)
    }
}
