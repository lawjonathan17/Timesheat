//
//  ViewController.swift
//  TimeSheat
//
//  Created by Jonathan Law on 3/28/18.
//  Copyright © 2018 Jonathan Law. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var helloLabel: NSTextField!
    @IBOutlet weak var timeField: NSTextField!
    
    var clock = Clock()
    
    
    @IBAction func startButtonClicked(_ sender: Any) {
        if clock.isPaused {
            clock.resumeTimer()
        } else {
            clock.duration = 360
            clock.startTimer()
        }
    }
    
    @IBAction func beginTimer(_ sender: Any) {
        var name = timeField.stringValue
        if name.isEmpty {
            name = "World"
        }
        let greeting = "Hello \(name)!"
        helloLabel.stringValue = greeting
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clock.delegate = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ViewController: ClockProtocol {
    
    func timeRemainingOnTimer(_ timer: Clock, timeRemaining: TimeInterval) {
        updateDisplay(for: timeRemaining)
    }
    
    func timerHasFinished(_ timer: Clock) {
        updateDisplay(for: 0)
    }
}

extension ViewController {
    
    // MARK: - Display
    
    func updateDisplay(for timeRemaining: TimeInterval) {
        timeField.stringValue = textToDisplay(for: timeRemaining)
    }
    
    private func textToDisplay(for timeRemaining: TimeInterval) -> String {
        if timeRemaining == 0 {
            return "Done!"
        }
        
        let minutesRemaining = floor(timeRemaining / 60)
        let secondsRemaining = timeRemaining - (minutesRemaining * 60)
        
        let secondsDisplay = String(format: "%02d", Int(secondsRemaining))
        let timeRemainingDisplay = "\(Int(minutesRemaining)):\(secondsDisplay)"
        
        return timeRemainingDisplay
    }
    
}