//
//  DiscoverViewController.swift
//  NewsAPI_1
//
//  Created by Ram on 06/07/33.
//

import UIKit

class DiscoverViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var discoverTableView:UITableView!
    var sectionsArr:[String] = ["CATEGORIES","SUGGESTIONS"]
    var numberOfSections = 0
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        createDiscoverTableView()
        handleGestureRecogniser()
    }
    
    
    @IBAction func onTapOfNewsBtn(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapOfSettings(_ sender: UIBarButtonItem)
    {
        let OVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "OptionsViewController") as! OptionsViewController
        OVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(OVC, animated: true, completion: {
            //NWVC.newsUrl = self.url
            //print("Navigation")
        })
    }
    
    @IBAction func onTapOfNewsNavigationBtn(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    //MARK:- TableView
    func createDiscoverTableView()
       {
        discoverTableView = UITableView(frame: view.frame, style: UITableView.Style.grouped)
        discoverTableView.register(UINib(nibName: "SuggestionsTableViewCell", bundle: nil), forCellReuseIdentifier: "SuggestionsTableViewCell")
        discoverTableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
           discoverTableView.delegate = self
           discoverTableView.dataSource = self
           self.discoverTableView.backgroundColor = UIColor.white
        //discoverTableView.isPagingEnabled = true
        discoverTableView.showsVerticalScrollIndicator = false
        discoverTableView.separatorColor = UIColor.clear
        view.addSubview(self.discoverTableView)
        discoverTableView.translatesAutoresizingMaskIntoConstraints = false
        discoverTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        discoverTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        discoverTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        discoverTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
       }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
////        if(section == 0)
////        {
////            return "SUGGESTIONS"
////        }else if(section == 1)
////        {
////            return "CATEGORIES"
////        }else
////        {
////            return "Nothing"
////        }
//        numberOfSections = section
//        return sectionsArr[section]
//    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 1)
        {
            let cell = discoverTableView.dequeueReusableCell(withIdentifier: "SuggestionsTableViewCell", for: indexPath) as! SuggestionsTableViewCell
            
            return cell
        }else
        {
            let cell = discoverTableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0)
        {
            return tableView.frame.height/3.5
        }else
        {
            return tableView.frame.height - tableView.frame.height/3.5
        }
        
    }
    //MARK:- Gesture recogniser
    func handleGestureRecogniser(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)

            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
        
    }
    //Action for gesture recgniser
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                
            case .down:
                print("Swiped down")
            case .left:
                print("Swiped left")
//                let NWVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NWVC") as! NewsWebViewViewController
//                NWVC.modalPresentationStyle = .fullScreen
//                navigationController?.pushViewController(NWVC, animated: true, completion: {
//                    NWVC.newsUrl = self.url
//                })
//                let VC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ViewController") as! ViewController
//                VC.modalPresentationStyle = .fullScreen
//                navigationController?.pushViewController(VC, animated: true)
                navigationController?.popViewController(animated: true)

               
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
}
