

import UIKit

class ResultViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var table:UITableView!
    // 配列
    private var timeTable:[String] = []
    
    private var formCampus:[String] = []
    private var arriveStation:[String] = []
    private var formStation:[String] = []
    
    var isSet = false
    
    var count = 0
    
    var test = "12:34"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        csvToArray()
        timeTableFormating()
    }
    
    //Table Viewのセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        
        

        
        // Tag番号 ２ で UILabel インスタンスの生成
        let label1 = table.viewWithTag(1) as! UILabel
        label1.text = "\(formCampus[indexPath.row])"
        
        // Tag番号 ３ で UILabel インスタンスの生成
        let label2 = table.viewWithTag(2) as! UILabel
        label2.text = "\(arriveStation[indexPath.row])"
        
        let label3 = table.viewWithTag(3) as! UILabel
        label3.text = "\(formStation[indexPath.row])"
        
        return cell
    }
    
    func csvToArray () {
        if let csvPath = Bundle.main.path(forResource: "TrainTimeTable", ofType: "csv") {
            do {
                let csvStr = try String(contentsOfFile:csvPath, encoding:String.Encoding.utf8)
                
                print(csvStr)
                
                let csvArr = csvStr.components(separatedBy: ",")
                
                
                
                timeTable = csvArr
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func timeTableFormating(){
        for time in timeTable {
            
            if(count == 0){
                
                var timeTmp = time
                if var range = timeTmp.range(of: ":") {
                    timeTmp.removeSubrange(range)
                }
                
                if(ViewController.serchdata < Int(timeTmp)!){
                    isSet = true
                }
                
                if(isSet){
                    formCampus.append(time)
                }
                
                count += 1
            }else if(count == 1){
                if(isSet){
                    arriveStation.append(time)
                }
                count += 1
            }else{
                if(isSet){
                    formStation.append(time)
                }
                count = 0
            }
        }
        
        print(arriveStation)
        print(formCampus)
        print(formStation)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

