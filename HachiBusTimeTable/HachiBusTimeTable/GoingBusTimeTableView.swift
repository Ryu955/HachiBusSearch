import UIKit

class GoingBusTimeTableView: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var table:UITableView!
    
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
            
            if(time == "シャトル運行（約5～10分間隔）" || time == "シャトル運行（約3～5分間隔）"){
                formStation.append(time)
                arriveCampus.append(time)
                count = 0
                continue
            }
            
            if(count == 0){
                count += 1
            }else if(count == 1){
                formStation.append(time)
                count += 1
            }else{
                arriveCampus.append(time)
                count = 0
            }
            
            
        }
        
        print(formStation)
        print(arriveCampus)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
