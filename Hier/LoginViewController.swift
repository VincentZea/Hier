//
//  LoginViewController.swift
//  Hier
//
//  Created by P.R.K on 6/28/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Alamofire
import FacebookLogin



class LoginViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
           }

    let URL_SIGNIN = "http://127.0.0.1:5000/login/"
    
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var notif: UILabel!
    

    @IBAction func login(_ sender: UIButton) {
        
//        let auth = "Basic " + username.text! + ":" + password.text!
//        
//        print(auth)
//        let headers :HTTPHeaders = [
//            "Authorization": auth,
//            "Accept": "text/html"
//        ]
        
        
//        Alamofire.request(URL_SIGNIN, method:.get,  encoding: URLEncoding.queryString, headers:headers ).responseString{
//         
        let user = username.text!
        let psw = password.text!
        
        var headers: HTTPHeaders = [:]
        if let authorizationHeader = Request.authorizationHeader(user: user, password: psw) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Alamofire.request(URL_SIGNIN, headers: headers).responseString{

                response in
                //printing response
                print("request : \(String(describing:response.request))")
                print("Response String: \(String(describing:response.result.value))")
                print(response)
                print(response.response?.allHeaderFields)
                
                
                let statusCode = (response.response?.statusCode)
                
                if( statusCode == 200){
                
                
                        
                        //switching the screen
                        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                        self.navigationController?.pushViewController(profileViewController, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        self.notif.text = "Invalid username or password"
                    }
                
        }
  

        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
