//
//  ViewController.swift
//  TimeSheat
//
//  Created by Jonathan Law on 3/28/18.
//  Copyright © 2018 Jonathan Law. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var timeField: NSTextField!
    
    @IBOutlet weak var helloLabel: NSTextField!
    
    @IBOutlet weak var timeLabel: NSStackView!
    
    @IBAction func startButtonClicked(_ sender: Any) {
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

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

