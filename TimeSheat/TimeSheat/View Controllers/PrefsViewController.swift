import Cocoa

class PrefsViewController: NSViewController {

    @IBOutlet weak var presetsPopup: NSPopUpButton!
    @IBOutlet weak var customTextField: NSTextField!
    @IBOutlet weak var customSlider: NSSlider!
    
    var prefs = Preferences()
    
    @IBAction func popupValueChanged(_ sender: NSPopUpButton)
    {
        if sender.selectedItem?.title == "Custom"
        {
            customSlider.isEnabled = true
            return
        }
        
        let newTimerDuration = sender.selectedTag()
        customSlider.integerValue = newTimerDuration
        showSliderValueAsText()
        customSlider.isEnabled = false
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any)
    {
        view.window?.close()
    }
    
    @IBAction func okButtonClicked(_ sender: Any)
    {
        saveNewPrefs()
        view.window?.close()
    }
    
    @IBAction func sliderValueChanged(_ sender: NSSlider)
    {
        showSliderValueAsText()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        showExistingPrefs()
    }
    
    func showExistingPrefs()
    {
        // 1
        let selectedTimeInMinutes = Int(prefs.selectedTime) / 60
        
        // 2
        presetsPopup.selectItem(withTitle: "Custom")
        customSlider.isEnabled = true
        
        // 3
        for item in presetsPopup.itemArray
        {
            if item.tag == selectedTimeInMinutes
            {
                presetsPopup.select(item)
                customSlider.isEnabled = false
                break
            }
        }
        
        // 4
        customSlider.integerValue = selectedTimeInMinutes
        showSliderValueAsText()
    }
    
    func showSliderValueAsText()
    {
        let newTimerDuration = customSlider.integerValue
        let minutesDescription = (newTimerDuration == 1) ? "minute" : "minutes"
        customTextField.stringValue = "\(newTimerDuration) \(minutesDescription)"
    }
    
    
    func saveNewPrefs() {
        prefs.selectedTime = customSlider.doubleValue * 60
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PrefsChanged"),
                                        object: nil)
    }
}
