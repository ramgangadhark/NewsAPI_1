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
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController,LoginButtonDelegate {

    
    //MARK:- Variables
    @IBOutlet weak var facebookLoginBtn: FBLoginButton!
    var provider = OAuthProvider(providerID: "twitter.com")
    var imageURL:String = ""
    var loginDetails:NSDictionary = [:]
    var twitterUserData:[String:Any] = [:]
    var googleUserData:[String:Any] = [:]
    //MARK:- viewDidLoad
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
    

    //MARK:- Facebook Login
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?)
    {
           getGraph()
       }
       
       func loginButtonDidLogOut(_ loginButton: FBLoginButton)
       {
            //userName.text = ""
            print("logout")
       }


    func getGraph()
    {
        let graph = GraphRequest(graphPath: "Me", parameters: ["fields":"id , first_name,last_name,email,name, picture.type(large)"], httpMethod: HTTPMethod(rawValue: "GET"))
        graph.start { (conn, result, err) in
//            guard let result = result , err == nil else{
//                return
//            }
            
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
    
    //MARK:- Google Sign In
    @IBAction func googleSignInBtnPressed(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) {  user, error in

            if error != nil {
            // ...
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)

                }

                self.googleUserData = authResult!.additionalUserInfo!.profile!
                print(self.googleUserData)
                print(self.googleUserData["name"]!)
                //LoginViewController.sendDataDelegate?.didTapChoice(email: "ram@gmail.com", name: "self.googleUserData", profileImg: "someImage")
                self.navigationController?.popViewController(animated: true, completion: {
                 
                    
                })
                
            }

        }
    }
    //MARK:- Twitter Sign In
    @IBAction func twitterSignInBtnPressed(_ sender: UIButton) {
        provider.getCredentialWith(nil) { credential, error in
          if error != nil {
            // Handle error.
          }
          if credential != nil {
            Auth.auth().signIn(with: credential!) { authResult, error in
                if let err = error {
                    print(err.localizedDescription)
                }else{
                    //print(authResult?.additionalUserInfo?.profile)
                    if (authResult?.additionalUserInfo?.profile) != nil{
                        //print(authResult!.additionalUserInfo!.profile!)
                        self.twitterUserData = authResult!.additionalUserInfo!.profile!
                        print(self.twitterUserData["email"]!)
                        
                        self.navigationController?.popViewController(animated: true, completion: {

                            
                        })
                        
                    }else
                    {
                        
                    }
                }

            }
          }
        }
    }
}
