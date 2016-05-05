//
//  ViewController.swift
//  Calculator
//
//  Created by sunyazhou on 16/4/22.
//  Copyright © 2016年 Baidu, Inc. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping: Bool = false
    
    @IBAction private func touchDigit(sender: UIButton, forEvent event: UIEvent) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text
            display.text = textCurrentlyInDisplay! + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    
    @IBAction func restore() {
        if  savedProgram != nil {
            brain.program =  savedProgram!
            displayValue  = brain.result
        }
    }
    
    private var brain = CalculatorBrain()
    
     
    
    @IBAction private func performOperation(symbol: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
        }
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = symbol.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        
    }
    
    
    
    
}

