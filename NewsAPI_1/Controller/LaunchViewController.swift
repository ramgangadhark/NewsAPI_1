//
//  LaunchViewController.swift
//  NewsAPI_1
//
//  Created by Ram on 20/08/21.
//

import UIKit
import TheAnimation

class LaunchViewController: UIViewController {

    //MARK:- Variables
    let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear)
    @IBOutlet weak var newsLbl: UILabel!
    @IBOutlet var logoImgView:UIImageView!
    var timer = Timer()
    var index = 0.0
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        configureInitialSetup()
        configureEndAnimations()
        timer = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        labelCreation()

    }

    //Logo Label Creation
    func labelCreation(){
        newsLbl.text = ""
        var charIndex = 0.0
        let titleText = "⚡️News"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.4 * charIndex, repeats: false) {(timer) in
                self.newsLbl.text?.append(letter)
                //self.configureInitialSetup()
                //self.configureEndAnimations()
                print(charIndex)
            }
            charIndex += 1
        }

    }
    func configureInitialSetup(){
        logoImgView.alpha = 0.1
        logoImgView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }
    
    func configureEndAnimations(){
        animator.addAnimations {
            self.logoImgView.alpha = 1.0
            self.logoImgView.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        }
        animator.addAnimations({
            //self.logoImgView.frame.origin.x -= 200
            self.logoImgView.frame.origin.y = 550
        }, delayFactor: 0.5)
    }
    //rotate Animation Function
    func rotate(){
        let animation = BasicAnimation(keyPath: .transformRotationZ)
        animation.fromValue = 0
        animation.toValue = .pi * 2
        animation.duration = 1
        animation.timingFunction = .easeIn
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = CACurrentMediaTime()
        animation.animate(in: logoImgView)
    }
    //action for timer function
    @objc func timerAction(){
        //print("\(timer.timeInterval) fired!")
        index = index + 0.01
        //print(index)
        
        animator.fractionComplete = CGFloat(index)
        
        if(index == 0.9000000000000006)
        {
            rotate()
            //to stop timer function
            timer.invalidate()
            let DVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ViewController") as! ViewController
            DVC.modalPresentationStyle = .fullScreen
            DVC.modalTransitionStyle = .flipHorizontal
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                //self.present(navigateToVC, animated: true)
                self.navigationController?.pushViewController(DVC, animated: true)
            }
            
        }
    }



}

