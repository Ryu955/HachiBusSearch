import UIKit
import CoreActionSheetPicker

class ViewController: UIViewController, UIPickerViewDelegate  {
    
    @IBOutlet weak var rideTime: UILabel!
    
    @IBAction func selectTime(_ sender: Any) {
        actionSheet()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    func actionSheet(){
        ActionSheetMultipleStringPicker.show(withTitle: "Multiple String Picker", rows: [
            ["One", "Two", "A lot"],
            ["Many", "Many more", "Infinite"]
            ], initialSelection: [2, 2], doneBlock: {
                picker, indexes, values in
                
                self.rideTime.text = "\(values) , \(indexes) , \(picker)"
                print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: send)
    }

    
}
