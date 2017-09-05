import UIKit
import CoreActionSheetPicker

class ViewController: UIViewController, UIPickerViewDelegate  {
    
    @IBOutlet weak var rideTime: UILabel!
    
    @IBAction func selectTime(_ sender: Any) {
        SelectTime()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    func actionSheet(){
        ActionSheetMultipleStringPicker.show(withTitle: "Multiple String Picker", rows: [
            [1, 2, 3],
            [00, 01, 02]
            ], initialSelection: [2, 2], doneBlock: {
                picker, indexes, values in
                
                self.rideTime.text = "\(values) , \(indexes) , \(picker)"
                print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: send)
    }

//    func timeSheet(){
//        let timePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.date, selectedDate: Date(), doneBlock: {
//            picker, value, index in
//            dateSelected.text = formatter.string(for: time)
//            print("value = \(value)")
//            print("index = \(index)")
//            print("picker = \(picker)")
//            return
//        }, cancel: { ActionStringCancelBlock in
//            print("cancel")
//            return }, origin: sender.superview)
//        timePicker?.minuteInterval = 5
//        timePicker?.locale = Calendar.current.locale
//    }

    
    func SelectTime(){
        let timePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.time, selectedDate: Date(), doneBlock: {
            picker, value, index in
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            self.rideTime.text = formatter.string(for: value)
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
