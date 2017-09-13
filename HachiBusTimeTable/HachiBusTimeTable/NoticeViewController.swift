import UIKit
import Kanna

class NoticeViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var table:UITableView!

    var selectedURL: URL?
    var selectedTitle: String?
    
    private var timeTableTitles:[String] = []
    private var normalTimeTableTitles:[String] = []
    
    var baseURL = "http://www.teu.ac.jp"
    
    var isTitele = true
    
    var countTitle = 0

    var specilURL:[URL] = []
    var normalURL:[URL] = []
    
    // Sectionのタイトル
    let sectionTitle: NSArray = ["臨時運行", "通常運行"]

    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scraping()

    }
    // Section数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
 
    // Sectioのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as? String
    }
    
    
    
    //Table Viewのセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return specilURL.count
        }
        else if section == 1 {
            return normalURL.count
        }
        else{
            return 0
        }
    }
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath)
        
        if indexPath.section == 0 {        
            // Tag番号 1 で UILabel インスタンスの生成
            let label1 = table.viewWithTag(1) as! UILabel
            label1.text = "\(timeTableTitles[indexPath.row])"
        }else if indexPath.section == 1 {

            // Tag番号 1 で UILabel インスタンスの生成
            let label1 = table.viewWithTag(1) as! UILabel
            label1.text = "\(normalTimeTableTitles[indexPath.row])"
        }
        
        return cell
    }
    
    // Cell が選択された場合
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        //selectedImage = UIImage(named:"\(imgArray[indexPath.row])")
        if indexPath.section == 0 {
            selectedURL = specilURL[indexPath.row]
            selectedTitle = timeTableTitles[indexPath.row]
        }else if indexPath.section == 1{
            selectedURL = normalURL[indexPath.row]
            selectedTitle = normalTimeTableTitles[indexPath.row]
        }
        
        if selectedURL != nil {
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toWebViewController",sender: nil)
        }
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toWebViewController") {
            let webVC: WebViewController = (segue.destination as? WebViewController)!
            // SubViewController のselectedImgに選択された画像を設定する
            webVC.selectedURL = selectedURL
            webVC.selectedTitle = selectedTitle
        }
    }

    func scraping(){
        guard let url = URL(string: "http://www.teu.ac.jp/campus/access/006644.html") else {
            fatalError("Error: URL")
        }
        
        let data = self.getHtml(url: url)
        guard let doc = HTML(html: data, encoding: String.Encoding.utf8) else {
            fatalError("Error: HTML")
        }
        for node in doc.xpath("//*[@data-role='listview']//li") {
            if(node.text! != "■スクールバス【臨時】時刻表" && countTitle == 1){
                timeTableTitles.append(node.text!)
            }else if(isTitele){
                isTitele = false
            }else if(countTitle == 2){
                normalTimeTableTitles.append(node.text!)
            }
            
            
            print(node.text!)
            let ans = node.toHTML!.pregReplace(pattern: "<li style=\"margin-bottom:5px;\"><a href=\"", with: "")
            let ans2 = ans.pregReplace(pattern: "</a></li>", with: "")
            let ans3 = ans2.pregReplace(pattern: "\">.+", with: "")
            let ans4 = ans3.pregReplace(pattern: "<li><a href=\"", with: "")
            
            if(ans4 != "<li data-role=\"list-divider"){
                print(ans4)
                
                if(countTitle == 1){
//                    var url = baseURL + ans4
                    specilURL.append(URL(string: baseURL + ans4)!)
                }else{
//                    var url = baseURL + ans4
                    normalURL.append(URL(string: baseURL + ans4)!)
                }
                
            }else{
                countTitle += 1
                print(countTitle)
            }
        }
    }
    
    
    /// HTML取得
    /// - parameter url: URL
    /// - returns Data
    func getHtml(url: URL) -> Data {
        do {
            return try Data(contentsOf: url)
        } catch {
            fatalError("fail to download")
        }
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
