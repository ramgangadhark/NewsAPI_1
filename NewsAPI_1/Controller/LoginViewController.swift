//
//  LoginViewController.swift
//  NewsAPI_1
//
//  Created by Ram on 09/07/33.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKPlacesKit

class LoginViewController: UIViewController,LoginButtonDelegate {

    
    
    @IBOutlet weak var facebookLoginBtn: FBLoginButton!
    var imageURL:String = ""
    var loginDetails:NSDictionary = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookLoginBtn.permissions = ["public_profile", "email"]
        facebookLoginBtn.delegate = self
        
//        profilePic.layer.cornerRadius = profilePic.frame.width/2
//        profilePic.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
//        profilePic.layer.borderWidth = 2.0
//        profilePic.image = #imageLiteral(resourceName: "placeholderImage")
        
        if(AccessToken.current == nil)
        {
            print("not logged in")
        }
        else{
            print("logged in already")
            
            getGraph()
        }

        // Do any additional setup after loading the view.
    }
    

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?)
    {
           getGraph()
       }
       
       func loginButtonDidLogOut(_ loginButton: FBLoginButton)
       {
            //userName.text = ""
            print("logout")
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func getGraph()
    {
        let graph = GraphRequest(graphPath: "Me", parameters: ["fields":"id , first_name,last_name,email,name, picture.type(large)"], httpMethod: HTTPMethod(rawValue: "GET"))
        graph.start { (conn, result, err) in
            
                if(err == nil) {
                    self.loginDetails = result as! NSDictionary
                    //self.userName.text = self.loginDetails["name"] as! String
                    print("FB UserName : \(self.loginDetails["first_name"] as! String)")
                    print(result as Any)
                    
                    self.imageURL = (((self.loginDetails["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String)!
                    
//                    do
//                    {
//                        self.profilePic.image = try UIImage(data: Data(contentsOf: URL(string: self.imageURL)!))
//                    }
//                    catch
//                    {
//                        self.profilePic.image = #imageLiteral(resourceName: "placeholderImage")
//                    }
                    
                     print("result \(result as! NSDictionary)")
                } else {
                     print("error \(err)")
                }
        }
    }

}
//<key>CFBundleURLTypes</key>
//<array>
//    <dict>
//        <key>CFBundleURLSchemes</key>
//        <array>
//            <string>fb1119709878520946</string>
//        </array>
//    </dict>
//    <dict/>
//</array>
//<key>CFBundleVersion</key>
//<string>1</string>
//<key>FacebookAppID</key>
//<string>1119709878520946</string>
//<key>FacebookClientToken</key>
//<string>NewsApp</string>
//<key>FacebookDisplayName</key>
//<string>NewsApp</string>
//<key>LSApplicationQueriesSchemes</key>
//<array>
//    <string>fbapi</string>
//    <string>fbapi20130214</string>
//    <string>fbapi20130410</string>
//    <string>fbapi20130702</string>
//    <string>fbapi20131010</string>
//    <string>fbapi20131219</string>
//    <string>fbapi20140410</string>
//    <string>fbapi20140116</string>
//    <string>fbapi20150313</string>
//    <string>fbapi20150629</string>
//    <string>fbapi20160328</string>
//    <string>fbauth</string>
//    <string>fb-messenger-share-api</string>
//    <string>fbauth2</string>
//    <string>fbshareextension</string>
//</array>














//<key>CFBundleURLTypes</key>
//
//
//<array>
//    <dict>
//        <key>CFBundleURLSchemes</key>
//        <array>
//            <string>fbAPP-ID</string>
//        </array>
//    </dict>
//    <dict/>
//</array>
//
//<key>FacebookAppID</key>
//<string>1119709878520946</string>
//<key>FacebookClientToken</key>
//<string>NewsApp</string>
//<key>FacebookDisplayName</key>
//<string>NewsApp</string>
//<key>LSApplicationQueriesSchemes</key>
//<array>
//    <string>fbapi</string>
//    <string>fbapi20130214</string>
//    <string>fbapi20130410</string>
//    <string>fbapi20130702</string>
//    <string>fbapi20131010</string>
//    <string>fbapi20131219</string>
//    <string>fbapi20140410</string>
//    <string>fbapi20140116</string>
//    <string>fbapi20150313</string>
//    <string>fbapi20150629</string>
//    <string>fbapi20160328</string>
//    <string>fbauth</string>
//    <string>fb-messenger-share-api</string>
//    <string>fbauth2</string>
//    <string>fbshareextension</string>
//</array>
