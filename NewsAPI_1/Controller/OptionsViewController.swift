//
//  OptionsViewController.swift
//  NewsAPI_1
//
//  Created by Ram on 08/07/21.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKPlacesKit

class OptionsViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    //MARK:- Variables
    @IBOutlet weak var signOutBtn: UIBarButtonItem!
    @IBOutlet weak var languageBtn2: UIButton!
    @IBOutlet weak var languageBtn1: UIButton!
    @IBOutlet weak var fBBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    var BtnNamePicker: UIPickerView!
    var toolBar = UIToolbar()
    //var picker  = UIPickerView()
    let BtnNamePickerValues = ["English","हिंदी"]
    var window:UIWindow?
    var userName:String = ""
    var profile:String = ""
    var userMail:String = ""
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        fBBtn.layer.cornerRadius = fBBtn.bounds.size.width/2
        fBBtn.clipsToBounds = true
        googleBtn.layer.cornerRadius = googleBtn.bounds.size.width/2
        googleBtn.clipsToBounds = true
        twitterBtn.layer.cornerRadius = twitterBtn.bounds.size.width/2
        twitterBtn.clipsToBounds = true
        callBtn.layer.cornerRadius = callBtn.bounds.size.width/2
        callBtn.clipsToBounds = true
        signInBtn.layer.cornerRadius = 5
        BtnNamePicker = UIPickerView()
        //gradeTextField.inputView = BtnNamePicker
        //gradeTextField.text = BtnNamePickerValues[0]
        languageBtn1.setTitle(BtnNamePickerValues[0], for: UIControl.State.normal)
        
        // Do any additional setup after loading the view.
    }
    
   
    //MARK:- Button Action
    func navigationToLogin(){
        let LVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        LVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(LVC, animated: true)
    }
    @IBAction func onTapOfBackBtn(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapOfSignInBtn(_ sender: UIButton)
    {
        //LoginViewController
        navigationToLogin()
        
    }
    
    @IBAction func onTapOfFBLoginBtn(_ sender: UIButton) {

        navigationToLogin()
    }
    
    @IBAction func onTapOfGoogleBtn(_ sender: UIButton) {

        navigationToLogin()
    }
    
    @IBAction func onTapOfTwitterBtn(_ sender: UIButton) {

        navigationToLogin()
    }
    
    @IBAction func onTapOfPhoneBtn(_ sender: UIButton) {

        navigationToLogin()
    }
    
    @IBAction func onTapOfLanguageBtn1(_ sender: UIButton) {
        createBtnPickerView()
        
    }
    
    
    
    @IBAction func onTapOfLanguageBtn2(_ sender: UIButton)
    {
        createBtnPickerView()
    }
    
    @IBAction func onTapOfRateThisAppBtn(_ sender: UIButton)
    {
        if let url = URL(string: "https://apps.apple.com/us/app/instapaper/id288545208") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func onTapOfShareThisAppBtn(_ sender: UIButton)
    {
        let firstActivityItem = "Read News..."

        // Setting url
        let secondActivityItem : NSURL = NSURL(string: "https://www.thehindu.com/")!
        
        // If you want to use an image
        let image : UIImage = UIImage(named: "category05")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender )
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
        UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func onTapOfFeedbackBtn(_ sender: UIButton) {
    }
    @IBAction func onTapOfPrivacyBtnTap(_ sender: UIButton) {
    }
    
    @IBAction func onTapOfNightModeSwitch(_ sender: UISwitch)
    {
        if(sender.isOn == true)
        {
            print("Switch On")
            window?.overrideUserInterfaceStyle = .dark
        }else
        {
            window?.overrideUserInterfaceStyle = .light
            print("Switch Off")
        }
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        //print("SigOut as \(userName) or \(userMail)")
        //let loginVC = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
//        LoginViewController.sendDataDelegate = self
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//            print("logout Successful")
//        } catch let signOutError as NSError {
//            print("Error signing out: %@", signOutError)
//        }
        func loginButtonDidLogOut(_ loginButton: FBLoginButton)
        {
             //userName.text = ""
             print("logout")
        }
    }
    //MARK:- PickerView
    func createBtnPickerView(){
        BtnNamePicker = UIPickerView.init()
        BtnNamePicker.delegate = self
        BtnNamePicker.dataSource = self
        BtnNamePicker.backgroundColor = UIColor.white
        BtnNamePicker.setValue(UIColor.black, forKey: "textColor")
        BtnNamePicker.autoresizingMask = .flexibleWidth
        BtnNamePicker.contentMode = .center
        BtnNamePicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(BtnNamePicker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        //toolBar.barStyle = .blackTranslucent
        toolBar.isTranslucent = true
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        BtnNamePicker.removeFromSuperview()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BtnNamePickerValues.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return BtnNamePickerValues[row]
        }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
            //gradeTextField.text = BtnNamePickerValues[row]
        
        languageBtn1.setTitle(BtnNamePickerValues[row], for: UIControl.State.normal)
            self.view.endEditing(true)
        }
    
}

