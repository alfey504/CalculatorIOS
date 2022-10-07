//
//  Stack.swift
//  Calculator
//
//  Created by Abraham Alfred Babu on 2022-10-05.
//

import Foundation

struct StringStack{
    var stack: [String] = []

    mutating func push(val: String){
        self.stack.append(val)
    }
    
    mutating func pop() -> String{
        let val = self.stack.last
        self.stack.removeLast()
        return(val!)
    }
    
    mutating func clearStack(){
        self.stack = []
    }
    
    func getLastOperator() -> String{
        for item in self.stack.reversed() {
            if(item == "x" || item == "÷" ||  item == "+" || item == "-"){
                return(item)
            }
        }
        return("~")
    }
    
    
    mutating func pushToStack(op: String, operand: String){
        self.push(val: operand)
        if(op != "="){
            self.push(val: op)
        }
    }
    

    func findNextOperator(currentIndex: Int, stack: Array<String>) -> (String, Int){
        for i in (currentIndex+1...stack.count-1){
            if(["+", "-", "÷", "x", "%"].contains(stack[i])){
                return(stack[i], i)
            }
        }
        return("nill", 0)
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
    
    func replaceInPlace(val: String, pos: Int, array: Array<String>) -> Array<String> {
        var temp = array
        temp.remove(at: pos-1)
        temp.insert(String(val), at: pos-1)
        temp.remove(at: pos)
        temp.remove(at: pos)
        return(temp)
    }
    
    mutating func evaluate() -> String{
        var temp = self.stack
        if (["+", "-", "x", "÷", "%"].contains(temp.last)){
            temp.removeLast()
        }
        var prevOp: String = "nill"
        while(temp.count > 1){
            print(temp)
            var i = 0
            while (i < temp.count){
                if(["+", "-", "x", "÷", "%"].contains(temp[i])){
                    let (newOp, j) = self.findNextOperator(currentIndex: i, stack: temp)
                    if(newOp != "nill"){
                        if(dmasCompare(op1: temp[i], op2: newOp)){
                            let lhs = Float(temp[i-1]), rhs = Float(temp[i+1])
                            let result = self.calculate(lhs: lhs!, rhs: rhs!, op: temp[i])
                            temp = replaceInPlace(val: String(result), pos: i, array: temp)
                            i+=1
                        }else{
                            prevOp = temp[i]
                            i = j
                        }
                    }else{
                        if(prevOp == "nill"){
                            let lhs = Float(temp[i-1]), rhs = Float(temp[i+1])
                            let result = self.calculate(lhs: lhs!, rhs: rhs!, op: temp[i])
                            temp = replaceInPlace(val: String(result), pos: i, array: temp)
                            i+=1
                            break
                        }else if(dmasCompare(op1: temp[i], op2: prevOp)){
                            let lhs = Float(temp[i-1]), rhs = Float(temp[i+1])
                            let result = self.calculate(lhs: lhs!, rhs: rhs!, op: temp[i])
                            temp = replaceInPlace(val: String(result), pos: i, array: temp)
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
    
    func printStack(){
        print(self.stack)
    }
}
