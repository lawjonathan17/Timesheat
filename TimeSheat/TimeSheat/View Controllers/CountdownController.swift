import Cocoa

class CountdownController: NSViewController
{
    @IBOutlet weak var timeField: NSTextField!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var resetButton: NSButton!
    
    var clock = Clock()
    var prefs = Preferences()
    
    @IBAction func startButtonClicked(_ sender: Any)
    {
        if clock.isPaused
        {
            clock.resumeTimer()
        }
        else
        {
            clock.duration = prefs.selectedTime
            clock.startTimer()
        }
    }

    
    @IBAction func stopButtonClicked(_ sender: Any)
    {
        clock.stopTimer()
    }
    
    @IBAction func resetButtonClicked(_ sender: Any)
    {
        clock.resetTimer()
        updateDisplay(for: prefs.selectedTime)
    }

    @IBAction func startTimerMenuItemSelected(_ sender: Any)
    {
        startButtonClicked(sender)
    }
    
    @IBAction func stopTimerMenuItemSelected(_ sender: Any)
    {
        stopButtonClicked(sender)
    }
    
    @IBAction func resetTimerMenuItemSelected(_ sender: Any)
    {
        resetButtonClicked(sender)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        clock.delegate = self
        setupPrefs()
    }
    
    override var representedObject: Any?
    {
        didSet
        {
            // Update the view, if already loaded.
        }
    }
}

extension CountdownController: ClockProtocol
{
    func timeRemainingOnTimer(_ timer: Clock, timeRemaining: TimeInterval) {
        updateDisplay(for: timeRemaining)
    }
    
    func timerHasFinished(_ timer: Clock) {
        updateDisplay(for: 0)
    }
}

extension CountdownController
{
    // MARK: - Display
    
    func updateDisplay(for timeRemaining: TimeInterval)
    {
        timeField.stringValue = textToDisplay(for: timeRemaining)
    }
    
    private func textToDisplay(for timeRemaining: TimeInterval) -> String
    {
        if timeRemaining == 0
        {
            return "Done!"
        }
        
        let minutesRemaining = floor(timeRemaining / 60)
        let secondsRemaining = timeRemaining - (minutesRemaining * 60)
        
        let secondsDisplay = String(format: "%02d", Int(secondsRemaining))
        let timeRemainingDisplay = "\(Int(minutesRemaining)):\(secondsDisplay)"
        
        return timeRemainingDisplay
    }
}

extension CountdownController
{
    // MARK: - Preferences
    
    func setupPrefs()
    {
        updateDisplay(for: prefs.selectedTime)
        
        let notificationName = Notification.Name(rawValue: "PrefsChanged")
        NotificationCenter.default.addObserver(forName: notificationName,
                                               object: nil, queue: nil) {
                                                (notification) in
                                                self.checkForResetAfterPrefsChange()
        }
    }
    
    func updateFromPrefs()
    {
        self.clock.duration = self.prefs.selectedTime
        self.resetButtonClicked(self)
    }
    
    func checkForResetAfterPrefsChange()
    {
        if clock.isStopped || clock.isPaused
        {
            // 1
            updateFromPrefs()
        }
        else
        {
            // 2
            let alert = NSAlert()
            alert.messageText = "Reset timer with the new settings?"
            alert.informativeText = "This will stop your current timer!"
            alert.alertStyle = .warning
            
            // 3
            alert.addButton(withTitle: "Reset")
            alert.addButton(withTitle: "Cancel")
            
            // 4
            let response = alert.runModal()
            if response == NSApplication.ModalResponse.alertFirstButtonReturn
            {
                self.updateFromPrefs()
            }
        }
    }
}

