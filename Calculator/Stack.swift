//
//  Stack.swift
//  Calculator
//
//  Created by Abraham Alfred Babu on 2022-10-05.
//

import Foundation

struct StringStack{
    var stack: [String] = []
    let operatorList: Array<String> = ["+", "-", "÷", "x", "%"]
    // add a new value to stack
    mutating func push(val: String){
        self.stack.append(val)
    }
    
    // returns and remove the last element in stack
    mutating func pop() -> String{
        let val = self.stack.last
        self.stack.removeLast()
        return(val!)
    }
    
    // clears the array element
    mutating func clearStack(){
        self.stack = []
    }
    
    
    // pushes to stack in context of operator and operand
    mutating func pushToStack(op: String, operand: String){
        self.push(val: operand)
        if(op != "="){
            self.push(val: op)
        }
    }
    
    //retuns the next operator and the index after given index
    func findNextOperator(currentIndex: Int, stack: Array<String>) -> (String, Int){
        for i in (currentIndex+1...stack.count-1){
            if(operatorList.contains(stack[i])){
                return(stack[i], i)
            }
        }
        return("nill", 0)
    }
    
    // return true if first operator is of preceedence else returns false
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
    
    // replace the expression with the result
    func replaceInPlace(val: String, pos: Int, array: Array<String>) -> Array<String> {
        var temp = array
        temp.remove(at: pos-1)
        temp.insert(String(val), at: pos-1)
        temp.remove(at: pos)
        temp.remove(at: pos)
        return(temp)
    }
    
    //given an index in mathematical expression perform the operation at index on lhs and rhs
    func evaluateOperationAtIndex(index: Int, expression: Array<String>) -> Array<String>{
        let lhs = Float(expression[index-1]), rhs = Float(expression[index+1])
        let result = self.calculate(lhs: lhs!, rhs: rhs!, op: expression[index])
        let temp = replaceInPlace(val: String(result), pos: index, array: expression)
        return(temp)
    }
    
    // evaluate all the math expression in stack
    mutating func evaluate() -> String{
        var temp = self.stack
        
        //remove the the last element if its an operator
        if (operatorList.contains(temp.last!)){
            temp.removeLast()
        }
        
        //loop until all the operations are done
        while(temp.count > 1){
            print(temp)
            var i = 0
            var prevOp: String = "nill"
            while (i < temp.count){
                //serching for an operator
                if(operatorList.contains(temp[i])){
                    let (newOp, j) = self.findNextOperator(currentIndex: i, stack: temp)
                    if(newOp != "nill"){
                        //perform the operation if higher in precedence from the next operator
                        if(dmasCompare(op1: temp[i], op2: newOp)){
                            temp = evaluateOperationAtIndex(index: i, expression: temp)
                        }else{
                            // set the iterator index as the next operator
                            prevOp = temp[i]
                            i = j
                        }
                    }else{
                        //if there was no prevoius op that is it was the only operator
                        if(prevOp == "nill"){
                            temp = evaluateOperationAtIndex(index: i, expression: temp)
                            i+=1
                            break
                        //if there was there was compare precedence
                        }else if(dmasCompare(op1: temp[i], op2: prevOp)){ //if there was compare precedence
                            temp = evaluateOperationAtIndex(index: i, expression: temp)
                            i+=1
                            break
                        }else{
                            break
                        }
                    }
                }else {
                    i += 1
                }
            }
        }
        return(temp[0])
    }
    
    // calculate and expression with 2 operands with one operand
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
        case "%":
                return(lhs/100*rhs)
            default:
                return(0)
            }
    }
    
    //prints out the stack
    func printStack(){
        print(self.stack)
    }
}
