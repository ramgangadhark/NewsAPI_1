//
//  CategoryViewController.swift
//  NewsAPI_1
//
//  Created by Ram on 18/07/21.
//

import UIKit

class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var newsTableView:UITableView!
    var url:String = ""
    var countryImage:UIImageView!
    var activeCases:UILabel!
    var totalCases:UILabel!
    var countryName:UILabel!
    var todayCases:UILabel!
    var mainTableView:UITableView!
    var newsCollectionView:UICollectionView!
    var isSideViewShowing = false
    var newsDataDictionary:NSDictionary?
    var authorArray:Array = [Any]()
    var titleArray:Array = [Any]()
    var urlArray:Array = [Any]()
    var descriptionArray:Array = [Any]()
    var imgURLArray:Array = [Any]()
    var contentArray:Array = [Any]()
    var sourceArray:Array = [Any]()
    var timeArray:Array = [Any]()
    var btn:UIButton!
    var menuView:UIView!
    var isMenuViewShowing = false
    var countryInfo:[String:Any]?
    var covidInfo:[String:Any]?
    var covidArray:NSArray?
    var isSegmentSelected:Bool = true
    var index:Int = 3
    var urlIndex:Int = 0
    //var someString:String = "2021-07-013'T'01:24:26Z"
    var publishedTimeArray:[String] = []
    
    //let dateFormatterGet = DateFormatter()
    //dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    var publishedAtArray:[String] = []
    var sourceNameArr:Array = [Any]()
    
    var publishedTimeArray1:[String] = []
    var publishedTimeArray2:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---index---")
        print(index)
        ApiCall(index: index)
        createNewsTableView()
        self.navigationItem.title = Constants.categoryArray1[index]
        

        // Do any additional setup after loading the view.
    }
    

    func calculateTimeDifference(from dateTime1: String, to dateTime2: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateAsString = dateTime1
        let date1 = dateFormatter.date(from: dateAsString)!
        
        let dateAsString2 = dateTime2
        let date2 = dateFormatter.date(from: dateAsString2)!
        
        let components : NSCalendar.Unit = [.second, .minute, .hour, .day,.month, .year]
        let difference = (Calendar.current as NSCalendar).components(components, from: date1, to: date2, options: [])
        
        var dateTimeDifferenceString = ""

        if difference.day != 0 {
            dateTimeDifferenceString = "\(difference.day!)day \(difference.hour!) hours ago"
        } else if  difference.day == 0 {
            dateTimeDifferenceString = "\(difference.hour!)hours ago"
        }
        return dateTimeDifferenceString
    }
    
    func ApiCall(index:Int){
        NetworkManager.shared.APICall(url: "\(Constants.news_API)category=\( Constants.categoryArray[index])&apiKey=\(Constants.news_API_Key)") { (Data, Err) in
            if(Err != nil){
                print(Err!)
            }
            else{
                for i in 0..<Data!.count
                {
                    self.newsDataDictionary = ((Data![i]) as! NSDictionary)
                    print(self.newsDataDictionary!)
                    self.authorArray.append(self.newsDataDictionary!["author"]!)
                    self.titleArray.append(self.newsDataDictionary!["title"]!)
                    self.descriptionArray.append(self.newsDataDictionary!["description"]!)
                    self.urlArray.append(self.newsDataDictionary!["url"]!)
                    self.imgURLArray.append(self.newsDataDictionary!["urlToImage"]!)
                    self.contentArray.append(self.newsDataDictionary!["content"]!)
                    self.sourceArray.append(self.newsDataDictionary!["source"]!)
                    self.publishedAtArray.append(self.newsDataDictionary!["publishedAt"]! as! String)
                }
                for i in 0..<self.publishedAtArray.count
                {
                    let someString = self.publishedAtArray[i].replacingOccurrences(of: "Z", with: "", options: String.CompareOptions.literal, range: nil)
                    self.publishedTimeArray1.append(someString)
                }
                for i in 0..<self.publishedTimeArray1.count
                {
                    let someSTring = self.publishedTimeArray1[i].replacingOccurrences(of: "T", with: " ", options: String.CompareOptions.literal, range: nil)
                    self.publishedTimeArray2.append(someSTring)
                }
                print(self.publishedTimeArray2)
                for i in 0..<self.sourceArray.count{
                    let sourceDict = self.sourceArray[i] as! NSDictionary
                    self.sourceNameArr.append(sourceDict["name"]!)
                }
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            }
        }
    }
    
    
    func createNewsTableView()
       {
        newsTableView = UITableView(frame: view.frame, style: UITableView.Style.grouped)
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        newsTableView.register(UINib(nibName: "PlaceholderTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaceholderTableViewCell")
           newsTableView.delegate = self
           newsTableView.dataSource = self
           //self.newsTableView.backgroundColor = UIColor.white
        newsTableView.isPagingEnabled = true
        newsTableView.showsVerticalScrollIndicator = false
        newsTableView.separatorColor = UIColor.clear
        view.addSubview(self.newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        newsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        newsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(authorArray.count == 0)
        {
            return 10
        }else
        {
            return authorArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(authorArray.count == 0)
        {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "PlaceholderTableViewCell", for: indexPath) as! PlaceholderTableViewCell
            return cell
        }else
        {
            urlIndex = indexPath.row
            let todayDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let currentTime = formatter.string(from: todayDate)
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
            
            cell.titleLbl.text = titleArray[indexPath.row] as? String
            cell.descriptionLbl.text = contentArray[indexPath.row] as? String
            cell.swipeLeftLbl.text = "swipe left for more at \(sourceNameArr[indexPath.row]) / \(calculateTimeDifference(from: publishedTimeArray2[indexPath.row] as! String, to: currentTime))"

            if(imgURLArray[indexPath.row] is NSNull)
            {
                cell.NewsImageView.image = UIImage(named: "NoImage")
            }else
            {
                do{
                    cell.NewsImageView.image = try UIImage(data: Data(contentsOf: URL(string: imgURLArray[indexPath.row] as! String)!))
                }catch
                {
                    print("Error while loading image")
                }

            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        handleGestureRecogniser(indexNumber:indexPath.row)
        //print(urlArray[indexPath.row])
        

        self.navigationController?.hidesBarsOnTap = true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return newsTableView.frame.size.height
    }
    func handleGestureRecogniser(indexNumber:Int){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)

            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
        
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")

                navigationController?.popViewController(animated: true)
                
            case .down:
                print("Swiped down")
            case .left:
                print("Swiped left")

                let NWVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NewsWebViewController") as! NewsWebViewController
                NWVC.modalPresentationStyle = .fullScreen
                navigationController?.pushViewController(NWVC, animated: true, completion: {
                    NWVC.newsUrl = "\(self.urlArray[self.urlIndex])"
                    //print("Navigate to tableview \(self.urlArray[self.urlIndex])")
                })
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }

}
