import UIKit
import Kanna

/// Arrayの要素
class element {
    var day = ""
    var hour = ""
    var temperature: Double = 0
}


class NoticeViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var table:UITableView!

    var selectedURL: URL?
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }
    
    /// 最終データのArray
    var finalData: [element] = []
    /// 昨日のデータのArray
    var yesterdayData: [element] = []
    /// 今日のデータのArray
    var todayData: [element] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scraping()

    }
    //Table Viewのセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath)
        
        // Tag番号 1 で UILabel インスタンスの生成
        let label1 = table.viewWithTag(1) as! UILabel
        label1.text = "1"
        

        return cell
    }
    
    // Cell が選択された場合
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        //selectedImage = UIImage(named:"\(imgArray[indexPath.row])")
        selectedURL = URL(string: "http://www.teu.ac.jp/campus/access/006644.html")
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
        for a in doc.xpath("//*[@data-role='listview']//li") {
            print(a.toHTML!)
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
