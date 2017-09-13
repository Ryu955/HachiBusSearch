import Foundation

class TimeTableFormating{
    
    // 配列
    var timeTable:[String] = []
    
    init(){
        csvToArray()
    }
    
    func csvToArray () {
        if let csvPath = Bundle.main.path(forResource: "BusTimeTable", ofType: "csv") {
            do {
                let csvStr = try String(contentsOfFile:csvPath, encoding:String.Encoding.utf8)
                let csvArr = csvStr.components(separatedBy: ",")
                timeTable = csvArr
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

}
