//
//  ViewController.swift
//  Hier
//
//  Created by P.R.K on 6/20/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController{
    
    
    let URL_USER_REGISTER = "http://127.0.0.1:5000/signup/"
    
    var trash = "www"


    
    @IBOutlet weak var EnterEmail: UITextField!

    @IBOutlet weak var EnterPassword: UITextField!
    
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    @IBOutlet weak var Label: UILabel!
    
    @IBAction func Register(_ sender: UIButton) {
        
        
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: EnterPassword.text)
        if(!isMatched){
            Label.text = "The Password should contain at least a upperCase letter, a digit, or a speical character"
        }else if( EnterPassword.text != ConfirmPassword.text){
            
            Label.text = "Please make sure you are entering same passwords!"
            
        
        }else{
            //creating parameters for the post request
            let parameters: Parameters=[
                "email":EnterEmail.text!,
                "password":EnterPassword.text!
            ]
            
            
            
            
            //Sending http post request
            Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON
                {
                    response in
                    //printing response
                    print(response)
                    
                    //getting the json value from the server
                    if let result = response.result.value {
                        
                        print("JSON: \(result)")
                    }
            }
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
