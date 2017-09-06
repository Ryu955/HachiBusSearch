import UIKit
import CoreActionSheetPicker

class ViewController: UIViewController, UIPickerViewDelegate  {
    
    @IBOutlet weak var selectButton: UIButton!
    
    static var serchdata = 0
    
    @IBAction func selectTime(_ sender: Any) {
        SelectTime()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "HHmm"
        let date = dateFormater.string(from: Date())
        
        ViewController.serchdata = Int(date)!
        
        print("前serchdata = \(ViewController.serchdata)")
        
    }


    
    func SelectTime(){
        let timePicker = ActionSheetDatePicker(title: "帰宅時間", datePickerMode: UIDatePickerMode.time, selectedDate: Date(), doneBlock: {
            picker, value, index in
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ja_JP")
            formatter.dateFormat = "HH:mm"
            
            self.selectButton.titleLabel?.text = formatter.string(for: value)
            
            let time = value as! Date
            
            let dateFormater = DateFormatter()
            dateFormater.locale = Locale(identifier: "ja_JP")
            dateFormater.dateFormat = "HHmm"
            let date = dateFormater.string(from: Date())
            
            ViewController.serchdata = Int(dateFormater.string(from: time))!
            print("後serchdata = \(ViewController.serchdata)")
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
