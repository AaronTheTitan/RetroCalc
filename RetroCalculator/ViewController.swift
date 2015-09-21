//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Aaron Bradley on 9/20/15.
//  Copyright © 2015 Aaron Bradley. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
  
  enum Operation: String  {
    case Divide = "/"
    case Multiply = "*"
    case Subtract = "-"
    case Add = "+"
    case Empty = "Empty"
  }
  
  @IBOutlet weak var outputLabel: UILabel!
  
  var buttonSound: AVAudioPlayer!
  var runningNumber = ""
  var leftValStr = ""
  var rightValStr = ""
  var currentOperation: Operation = Operation.Empty
  var result = ""

  override func viewDidLoad() {
    super.viewDidLoad()
    
    outputLabel.text = "0"
    let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
    let soundURL = NSURL(fileURLWithPath: path!)
    
    do {
      try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
      buttonSound.prepareToPlay()
      
    } catch let err as NSError {
      print(err.debugDescription)
    }
    
  }

  @IBAction func numberPressed(button: UIButton) {
    playSound()
    runningNumber += "\(button.tag)"
    outputLabel.text = runningNumber
  }
  
  @IBAction func onDivideTapped(sender: AnyObject) {
    processOperation(Operation.Divide)
  }
  
  @IBAction func onMultiplyTapped(sender: AnyObject) {
    processOperation(Operation.Multiply)
  }
  
  @IBAction func onSubtractTapped(sender: AnyObject) {
    processOperation(Operation.Subtract)
  }

  @IBAction func onAddTapped(sender: AnyObject) {
    processOperation(Operation.Add)
  }
  
  @IBAction func onEqualTapped(sender: AnyObject) {
    processOperation(currentOperation)
  }
  
  func processOperation(op: Operation) {
    playSound()
    
    if currentOperation != Operation.Empty {
      // do some math
      
      // A user selected an operator, but then selected another operator 
      // without first entering a number
      
      if runningNumber != "" {
      
        rightValStr = runningNumber
        runningNumber = ""
        
        switch op {
        case .Multiply: result = "\(Double(leftValStr)! * Double(rightValStr)!)"
        case .Divide: result = "\(Double(leftValStr)! / Double(rightValStr)!)"
        case .Subtract: result = "\(Double(leftValStr)! - Double(rightValStr)!)"
        case .Add: result = "\(Double(leftValStr)! + Double(rightValStr)!)"
        default: break
        }
        
        leftValStr =  result
        outputLabel.text = result
        
      }
      
      currentOperation = op
      
    } else {
      // this is the first time an operator has been pressed
      leftValStr = runningNumber
      runningNumber = ""
      currentOperation = op
    }
    
  }
  
  func playSound() {
    if buttonSound.playing {
      buttonSound.stop()
    }
    
    buttonSound.play()
  }
  
}

