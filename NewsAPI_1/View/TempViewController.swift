//
//  TempViewController.swift
//  NewsAPI_1
//
//  Created by Ram on 27/07/21.
//

import UIKit

class TempViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var newsTableView: UITableView!
    //var newsTableView:UITableView!
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
    var index:Int = 0
    var someString:String = "2021-07-013'T'01:24:26Z"
    var publishedTimeArray:[String] = []
    
    //let dateFormatterGet = DateFormatter()
    //dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    var publishedAtArray:[String] = []
    var sourceNameArr:Array = [Any]()
    
    var publishedTimeArray1:[String] = []
    var publishedTimeArray2:[Any] = []
    var tableviewIndex = [0,0]
    var isIndexZero:Bool = true
    let reloadBtn = UIButton(type: .custom)
    let backToTopBtn = UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(UINib(nibName: "PlaceholderTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaceholderTableViewCell")
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        
        ApiCall()
        createButton()

        // Do any additional setup after loading the view.
    }
    


    func createReloadBtn(){
        reloadBtn.setImage(UIImage(systemName: "goforward"), for: .normal)
        reloadBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        reloadBtn.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        let reloadItem = UIBarButtonItem(customView: reloadBtn)
        self.navigationItem.rightBarButtonItem  = reloadItem
        
    }
    func createBackToTopBtn(){
       
        
        backToTopBtn.setImage(UIImage(systemName: "square.and.arrow.up"), for: UIControl.State.normal)
        backToTopBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backToTopBtn.addTarget(self, action: #selector(reloadData) , for: UIControl.Event.touchUpInside)
        let backToTopItem = UIBarButtonItem(customView: backToTopBtn)
        self.navigationItem.rightBarButtonItem = backToTopItem
    }
    
    
    @objc func backToTop(){
        
    }
    
    @objc func reloadData(){
        //print("Button Clicked")
        //newsTableView.reloadData()
        
        
        if(isIndexZero == true)
        {
            
            //ApiCall()
            newsTableView.reloadData()
            print("Reload")
            isIndexZero = false
            reloadBtn.isHidden = false
            backToTopBtn.isHidden = true
            //reloadBtn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
            //reloadBtn.layoutIfNeeded()
            
            //backToTopBtn.removeFromSuperview()
            //createReloadBtn()
        }else
        {
            reloadBtn.isHidden = true
            backToTopBtn.isHidden = false
            //newsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            print("Back to Top")
            isIndexZero = true
            //reloadBtn.removeFromSuperview()
            //createBackToTopBtn()
            reloadBtn.setImage(UIImage(systemName: "goforward"), for: .normal)
            //reloadBtn.layoutIfNeeded()
            
        }
        
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
        
        
//        var timeDifference:Int = 0
//        var dayDiffernece:Int = 0
//        if difference.day != 0 {
//            dayDiffernece = difference.day!
//        }else if difference.day == 0 {
//            timeDifference = difference.hour!
//        }
//        if(dayDiffernece == 0)
//        {
//            return timeDifference
//        }else{
//            return dayDiffernece
//        }
//        timeDifference = difference.hour!
//
//        return timeDifference
        
    }
    
    func ApiCall(){
        NetworkManager.shared.APICall(url: "\(Constants.news_API)apiKey=\(Constants.news_API_Key)") { (Data, Err) in
            if(Err != nil){
                print(Err!)
            }
            else{
                //print(Data as Any)
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
                    //print(self.newsDataDictionary!["source"]!)
                    //print(self.publishedAtArray)
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
                //print("a2")
                print(self.publishedTimeArray2)
                for i in 0..<self.sourceArray.count{
                    let sourceDict = self.sourceArray[i] as! NSDictionary
                    self.sourceNameArr.append(sourceDict["name"]!)
                     //print(self.sourceNameArr)
                }
                
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                    //self.newsCollectionView.reloadData()
                   // print(self.imgURLArray)
                }
                
            }
        }
    }

    
    @IBAction func onClickOfBarBtn(_ sender: UIBarButtonItem)
    {
        
        
//        if(tableviewIndex == [0,0])
//        {
//            newsTableView.reloadData()
//        }else
//        {
//            newsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        }
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
        
    }
    
    //MARK:- Creating UI Button
    func createButton(){
        btn = UIButton()
        btn.frame = CGRect(x: view.frame.size.width - 150, y: view.frame.size.height - 150, width: 100, height: 35)
        btn.setTitle("Covid Alert", for: UIControl.State.normal)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        view.addSubview(btn)
        btn.addTarget(self, action:  #selector(onClickOfBtn), for: UIControl.Event.touchUpInside)
        creatingMenuView()
        menuView.isHidden = true
        isMenuViewShowing = true
    }
    //MARK:- Covid Button Action
    @objc func onClickOfBtn()
    {
        
        if (isMenuViewShowing == true) {
            menuView.isHidden = false
           
            countryImage = UIImageView()
            countryImage.frame = CGRect(x: 25, y: 25, width: 250, height: 140)
            menuView.addSubview(countryImage)
            countryName = UILabel()
            countryName.frame = CGRect(x: 25, y: 170, width: 250, height: 40)
            countryName.font = UIFont.boldSystemFont(ofSize: 16)
            countryName.backgroundColor = #colorLiteral(red: 0.9180471301, green: 0.5697929263, blue: 0.1973303556, alpha: 1)
            countryName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            menuView.addSubview(countryName)
            todayCases = UILabel()
            todayCases.frame = CGRect(x: 25, y: 225, width: 250, height: 40)
            todayCases.font = UIFont.boldSystemFont(ofSize: 16)
            todayCases.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            todayCases.textColor = #colorLiteral(red: 0.1884154975, green: 0.2232014239, blue: 0.5997007489, alpha: 1)
            menuView.addSubview(todayCases)
            activeCases = UILabel()
            activeCases.frame = CGRect(x: 25, y: 285, width: 250, height: 40)
            activeCases.font = UIFont.boldSystemFont(ofSize: 16)
            activeCases.backgroundColor = #colorLiteral(red: 0.9998918176, green: 1, blue: 0.9998809695, alpha: 1)
            activeCases.textColor = #colorLiteral(red: 0.0822102949, green: 0.1903048158, blue: 0.5293337107, alpha: 1)
            menuView.addSubview(activeCases)
            totalCases = UILabel()
            totalCases.frame = CGRect(x: 25, y: 345, width: 250, height: 40)
            totalCases.backgroundColor = #colorLiteral(red: 0.2320346534, green: 0.5217760205, blue: 0.04774210602, alpha: 1)
            totalCases.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            totalCases.font = UIFont.boldSystemFont(ofSize: 16)
            menuView.addSubview(totalCases)
            totalCases.text = "Total Cases : \(NetworkManager.shared.covidData["cases"]!)"
            activeCases.text = "Active Cases : \(NetworkManager.shared.covidData["active"]!)"
            countryName.text = "Country : \(NetworkManager.shared.covidData["country"]!)"
            todayCases.text = "Today Cases : \(NetworkManager.shared.covidData["todayCases"]!)"
            do{
                self.countryImage.image = try UIImage(data: Data(contentsOf: URL(string: NetworkManager.shared.countryData!["flag"] as! String)!))
            }catch
            {
                print("Error while getting Image")
            }
            
            btn.setTitle("Close", for: UIControl.State.normal)
            
            
        }else{
            btn.setTitle("Covid Alert", for: UIControl.State.normal)
            menuView.isHidden = true
        }
        isMenuViewShowing = !isMenuViewShowing
    }
    func creatingMenuView()
    {
        menuView = UIView()
        menuView.frame = CGRect(x: view.frame.size.width - 325, y: view.frame.size.height - 575, width: 300, height: 400) //120W, 275H
        menuView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        menuView.clipsToBounds = true
        menuView.layer.cornerRadius = 12
        view.addSubview(menuView)
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if(isSegmentSelected == true)
//        {
//            let off = self.mainTableView.contentOffset.y
//            btn.frame = CGRect(x: 300, y: off + 730, width: btn.frame.width, height: btn.frame.height)
//            menuView.frame = CGRect(x: 120, y: off + 275, width: menuView.frame.width, height: menuView.frame.height)
//        }else
//        {
//            let off = self.newsCollectionView.contentOffset.y
//            btn.frame = CGRect(x: 300, y: off + 730, width: btn.frame.width, height: btn.frame.height)
//            menuView.frame = CGRect(x: 120, y: off + 275, width: menuView.frame.width, height: menuView.frame.height)
//        }
//    }
    func createNewsTableView()
       {
        newsTableView = UITableView(frame: view.frame, style: UITableView.Style.grouped)
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        newsTableView.register(UINib(nibName: "PlaceholderTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaceholderTableViewCell")
           //newsTableView.delegate = self
           //newsTableView.dataSource = self
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
        //tableviewIndex = IndexPath(row: indexPath.row, section: indexPath.row)
        if(authorArray.count == 0)
        {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "PlaceholderTableViewCell", for: indexPath) as! PlaceholderTableViewCell
            return cell
        }else
        {
            if(indexPath.row == 0)
            {
                isIndexZero = true
                reloadBtn.setImage(UIImage(systemName: "goforward"), for: .normal)
//                reloadBtn.layoutIfNeeded()
            }else
            {
                isIndexZero = false
                reloadBtn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
//                reloadBtn.layoutIfNeeded()
            }
            let todayDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let currentTime = formatter.string(from: todayDate)
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
            
            cell.titleLbl.text = titleArray[indexPath.row] as? String
            cell.descriptionLbl.text = contentArray[indexPath.row] as? String
            cell.swipeLeftLbl.text = "swipe left for more at \(sourceNameArr[indexPath.row]) / \(calculateTimeDifference(from: publishedTimeArray2[indexPath.row] as! String, to: currentTime))"
            
            //print(result)
            //print(startDate)
            //print(calculateTimeDifference(from: startDate, to: currentTime))
            //cell.newsButton.setTitle(titleArray[indexPath.row] as? String, for: UIControl.State.normal)
            
            
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
//        let TableViewNewsViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TableViewNewsViewController") as? TableViewNewsViewController
//        //var someString:String = contentArray[indexPath.row] as! String
//        TableViewNewsViewController?.modalPresentationStyle = .fullScreen
//        navigationController?.pushViewController(TableViewNewsViewController!, animated: true, completion: {
//            TableViewNewsViewController?.newsLbl.text = "\((self.contentArray[indexPath.row]))   \n - Swipe left to see more"
//            TableViewNewsViewController?.authorLbl.text = "Author : \(self.authorArray[indexPath.row])"
//            TableViewNewsViewController?.url = "\(self.urlArray[indexPath.row])"
//
//            if(self.imgURLArray[indexPath.row] is NSNull)
//            {
//                TableViewNewsViewController?.newsImgView.image = UIImage(named: "NoImage")
//            }else
//            {
//                do{
//                    TableViewNewsViewController?.newsImgView.image = try UIImage(data: Data(contentsOf: URL(string: self.imgURLArray[indexPath.row] as! String)!))
//                }catch
//                {
//                    print("Error while loading image")
//                }
//
//            }
//        })
        index = indexPath.row
        handleGestureRecogniser(indexNumber:indexPath.row)
        //tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        
        

        self.navigationController?.hidesBarsOnTap = true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return newsTableView.frame.size.height
    }
    
    
    @IBAction func onTapOfDiscoverBtn(_ sender: UIBarButtonItem)
    {
        let DVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "DiscoverViewController") as! DiscoverViewController
//        DVC.modalPresentationStyle = .fullScreen
//        navigationController?.pushViewController(DVC, animated: true)
        
        let nav = self.navigationController //grab an instance of the current navigationController
           DispatchQueue.main.async { //make sure all UI updates are on the main thread.
               nav?.view.layer.add(CATransition().popFromLeft(), forKey: nil)
               nav?.pushViewController(DVC, animated: true)
           }
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
                let DVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "DiscoverViewController") as! DiscoverViewController
                DVC.modalPresentationStyle = .fullScreen
                navigationController?.pushViewController(DVC, animated: true)
                
                
            case .down:
                print("Swiped down")
            case .left:
                print("Swiped left")
//                let NWVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NWVC") as! NewsWebViewViewController
//                NWVC.modalPresentationStyle = .fullScreen
//                navigationController?.pushViewController(NWVC, animated: true, completion: {
//                    NWVC.newsUrl = self.url
//                })
                let NWVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NewsWebViewController") as! NewsWebViewController
                NWVC.modalPresentationStyle = .fullScreen
                navigationController?.pushViewController(NWVC, animated: true, completion: {
                    NWVC.newsUrl = "\(self.urlArray[self.index])"
                })
                print(index)
//                let TableViewNewsViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TableViewNewsViewController") as? TableViewNewsViewController
//                //var someString:String = contentArray[indexPath.row] as! String
//                TableViewNewsViewController?.modalPresentationStyle = .fullScreen
//                navigationController?.pushViewController(TableViewNewsViewController!, animated: true, completion: {
//                    TableViewNewsViewController?.newsLbl.text = "\((self.contentArray[self.index]))   \n - Swipe left to see more"
//                    TableViewNewsViewController?.authorLbl.text = "Author : \(self.authorArray[self.index])"
//                    TableViewNewsViewController?.url = "\(self.urlArray[self.index])"
//
//                    if(self.imgURLArray[self.index] is NSNull)
//                    {
//                        TableViewNewsViewController?.newsImgView.image = UIImage(named: "NoImage")
//                    }else
//                    {
//                        do{
//                            TableViewNewsViewController?.newsImgView.image = try UIImage(data: Data(contentsOf: URL(string: self.imgURLArray[self.index] as! String)!))
//                        }catch
//                        {
//                            print("Error while loading image")
//                        }
//
//                    }
//                })
               
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
}
//MARK:- UINavigationController Extension for completion Block
//extension UINavigationController {
//
//    func pushViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void) {
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        pushViewController(viewController, animated: animated)
//
//        CATransaction.commit()
//    }
//
//    func popViewController(animated: Bool = true, completion: @escaping () -> Void) {
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        popViewController(animated: animated)
//        CATransaction.commit()
//    }
//
//    func popToRootViewController(animated: Bool = true, completion: @escaping () -> Void) {
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        popToRootViewController(animated: animated)
//        CATransaction.commit()
//    }
//
//}
//
//extension CATransition {
//
////New viewController will appear from bottom of screen.
//func segueFromBottom() -> CATransition {
//    self.duration = 0.375 //set the duration to whatever you'd like.
//    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//    self.type = CATransitionType.moveIn
//    self.subtype = CATransitionSubtype.fromTop
//    return self
//}
////New viewController will appear from top of screen.
//func segueFromTop() -> CATransition {
//    self.duration = 0.375 //set the duration to whatever you'd like.
//    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//    self.type = CATransitionType.moveIn
//    self.subtype = CATransitionSubtype.fromBottom
//    return self
//}
// //New viewController will appear from left side of screen.
//func segueFromLeft() -> CATransition {
//    self.duration = 0.1 //set the duration to whatever you'd like.
//    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//    self.type = CATransitionType.moveIn
//    self.subtype = CATransitionSubtype.fromLeft
//    return self
//}
////New viewController will pop from right side of screen.
//func popFromRight() -> CATransition {
//    self.duration = 0.1 //set the duration to whatever you'd like.
//    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//    self.type = CATransitionType.reveal
//    self.subtype = CATransitionSubtype.fromRight
//    return self
//}
////New viewController will appear from left side of screen.
//func popFromLeft() -> CATransition {
//    self.duration = 0.1 //set the duration to whatever you'd like.
//    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//    self.type = CATransitionType.reveal
//    self.subtype = CATransitionSubtype.fromLeft
//    return self
//   }
//}
