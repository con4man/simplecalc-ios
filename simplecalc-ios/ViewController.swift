//
//  ViewController.swift
//  simplecalc-ios
//
//  Created by iGuest on 2/2/18.
//  Copyright © 2018 Connor Hawthorne. All rights reserved.
//

import UIKit

enum Operation:String {
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case mod = "%"
    case multiply = "*"
    case count = "cnt"
    case avg = "avg"
    case fact = "fact"
    case Null = "Null"
}

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    var runningNumber = ""
    var lhs = ""
    var rhs = ""
    var result = ""
    var count = 1
    var runningTotal = 0.0
    var currentOperation:Operation = .Null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = "0"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(_ sender: RoundButton) {
        if runningNumber.count <= 8 {
            runningNumber += "\(sender.tag)"
            outputLabel.text = runningNumber
        }
    }
    
    @IBAction func clearPressed(_ sender: RoundButton) {
        runningNumber = ""
        lhs = ""
        rhs = ""
        result = ""
        count = 1
        runningTotal = 0.0
        currentOperation = .Null
        outputLabel.text = "0"
    }
    
    @IBAction func decimalPressed(_ sender: RoundButton) {
        if runningNumber.count <= 7 {
            runningNumber += "."
            outputLabel.text = runningNumber
        }
    }
    
    @IBAction func equalsPressed(_ sender: RoundButton) {
        operation(operation: currentOperation)
    }
    
    @IBAction func plusPressed(_ sender: RoundButton) {
        operation(operation: .add)
    }
    
    @IBAction func minusPressed(_ sender: RoundButton) {
        operation(operation: .subtract)
    }
    
    @IBAction func timesPressed(_ sender: RoundButton) {
        operation(operation: .multiply)
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        operation(operation: .divide)
    }
    
    @IBAction func modPressed(_ sender: RoundButton) {
        operation(operation: .mod)
    }
    
    @IBAction func countPressed(_ sender: RoundButton) {
        operation(operation: .count)
    }
    
    @IBAction func averagePressed(_ sender: RoundButton) {
        operation(operation: .avg)
    }
    
    @IBAction func factPressed(_ sender: RoundButton) {
        operation(operation: .fact)
    }
    
    func operation(operation: Operation) {
        if currentOperation != .Null {
            if runningNumber != "" {
                rhs = runningNumber
                runningNumber = ""
            
                if currentOperation == .add {
                    result = "\(Double(lhs)! + Double(rhs)!)"
                } else if currentOperation == .subtract {
                    result = "\(Double(lhs)! - Double(rhs)!)"
                } else if currentOperation == .multiply {
                    result = "\(Double(lhs)! * Double(rhs)!)"
                } else if currentOperation == .divide {
                    result = "\(Double(lhs)! / Double(rhs)!)"
                } else if currentOperation == .mod {
                    result = "\(Double(lhs)!.truncatingRemainder(dividingBy: Double(rhs)!))"
                } else if currentOperation == .count {
                    count += 1
                    result = "\(count)"
                } else if currentOperation == .avg {
                    count += 1
                    if (runningTotal == 0) {
                        runningTotal = (Double(lhs))! + (Double(rhs))!
                    } else {
                        runningTotal += Double(rhs)!
                    }
                    result = "\(Double(runningTotal) / Double(count))"
                }
                lhs = result
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0){
                    result = "\(Int(Double(result)!))"
                }
                outputLabel.text = result
            }
            currentOperation = operation
        } else {
            lhs = runningNumber
            runningNumber = ""
            currentOperation = operation
            
            if currentOperation == .fact {
                var sum = 1;
                for i in 1...Int(lhs)! {
                    sum = sum * i
                }
                result = "\(Double(sum))"
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0){
                    result = "\(Int(Double(result)!))"
                }
                outputLabel.text = result
            }
            
        }
    }
}

