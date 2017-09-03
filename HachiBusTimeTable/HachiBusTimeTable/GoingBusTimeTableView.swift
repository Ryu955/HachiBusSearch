import UIKit

class GoingBusTimeTableView: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var table:UITableView!
    
    // section毎の画像配列
    private let imgArray: NSArray = ["img0","img1","img2","img3", "img4","img5","img6","img7"]
    
    private let label2Array: NSArray = ["2013/8/23/16:04","2013/8/23/16:15","2013/8/23/16:47","2013/8/23/17:10","2013/8/23/1715:","2013/8/23/17:21","2013/8/23/17:33","2013/8/23/17:41"]
    
    // 配列
    private var timeTable:[String] = []

    private var formStation:[String] = []
    private var arriveCampus:[String] = []
    
    var count = 0
    
    // Sectionのタイトル
    let sectionTitle: NSArray = ["出発: 到着"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        csvToArray()
        timeTableFormating()
    }
    
    //Table Viewのセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formStation.count
    }
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "goingBusTimetableCell", for: indexPath)
        
        // Tag番号 1 で UILabel インスタンスの生成
        let label1 = table.viewWithTag(1) as! UILabel
        label1.text = "\(formStation[indexPath.row])"
        
        // Tag番号 2 で UILabel インスタンスの生成
        let label2 = table.viewWithTag(2) as! UILabel
        label2.text = "\(arriveCampus[indexPath.row])"
        
        
        return cell
    }
    
    // Sectioのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as? String
    }
    
    func csvToArray () {
        if let csvPath = Bundle.main.path(forResource: "BusTimeTable", ofType: "csv") {
            do {
                let csvStr = try String(contentsOfFile:csvPath, encoding:String.Encoding.utf8)
                
                //print(csvStr)
                
                let csvArr = csvStr.components(separatedBy: ",")
                
                
                
                timeTable = csvArr
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    func timeTableFormating(){
        for time in timeTable {
            
            if(time == "シャトル運行（約5～10分間隔）"){
                formStation.append(time)
                arriveCampus.append(time)
                continue
            }
            
            if(count == 0){
                
            }else if(count == 1){
                formStation.append(time)
            }else{
                arriveCampus.append(time)
            }
            
            count = count == 2 ? 0 : count + 1
        }
        
        print(formStation)
        print(arriveCampus)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
