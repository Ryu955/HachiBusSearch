import UIKit
import CoreActionSheetPicker

class ViewController: UIViewController, UIPickerViewDelegate  {
    
    @IBOutlet weak var selectButton: UIButton!
    
    @IBAction func selectTime(_ sender: Any) {
        SelectTime()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
         let now = Date()
        
        
    
        
    }


    
    func SelectTime(){
        let timePicker = ActionSheetDatePicker(title: "帰宅時間", datePickerMode: UIDatePickerMode.time, selectedDate: Date(), doneBlock: {
            picker, value, index in
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            self.selectButton.titleLabel?.text = formatter.string(for: value)! + "に帰る"
            
            print("value = \(value)")
            print("index = \(index)")
            print("picker = \(picker)")
            return
        }, cancel: { ActionStringCancelBlock in
            print("cancel")
            return }, origin: self.view)
        timePicker?.minuteInterval = 5
        timePicker?.locale = Calendar.current.locale
        timePicker?.show()
        
    }
}
