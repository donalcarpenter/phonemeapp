//
//  AuthenticationViewController.swift
//  Phoneme
//
//  Created by donal on 02/08/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import Parse

class AuthenticationViewController: BaseUIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgotPAssword: UIButton!
    
    @IBOutlet weak var successMessage: UILabel!
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: "handleButtonsEnableState", name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        
        handleButtonsEnableState()
        
        if(PFUser.current() != nil){
            self.performSegue(withIdentifier: "dataentry", sender: self)
        }
    }
    
    func handleButtonsEnableState(){
        let enabled:Bool = !(email.text!.isEmpty || password.text!.isEmpty)
        
        loginButton.isEnabled = enabled
        signUpButton.isEnabled = enabled
        
        forgotPAssword.isEnabled = !email.text!.isEmpty
    }
    
    func isValidEmail(_ testStr:String) -> Bool {
    // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func loginUser(_ sender: UIButton) {
        
        if(!isValidEmail(email.text!)){
            showErrorMessage("\(String(describing: email.text)) is not a valid email address", userError: true)
            return
        }
        
        PFUser.logInWithUsername(inBackground: email.text!, password: password.text!) { (user, error) -> Void in
        
            if((user) != nil){
                
                if let approved: Bool = user!["approved"] as? Bool{
                    if(approved){
                        self.password.text = ""
                        self.performSegue(withIdentifier: "dataentry", sender: self)
                        return;
                    }
                }
                
                self.showErrorMessage("your login details were correct, but your account has not been approved yet", userError: false)

            }else{
                if(error != nil){
                    self.showErrorMessage(error!.localizedDescription, userError: true)
                }
                else{
                    self.showErrorMessage("not sure what happened, but you're not logged in", userError: false)
                }
            }
        }
    }
    
    @IBAction func signUpUser(_ sender: UIButton) {
        
        if(!isValidEmail(email.text!)){
            showErrorMessage("\(email.text) is not a valid email address", userError: true)
            return
        }
        
        let user = PFUser()
        user.username = email.text
        user.email = email.text
        user.password = password.text
        user["approved"] = false
        
        user.signUpInBackground { (success, error) -> Void in
            if(success){
                
                self.signUpButton.isEnabled = false
                
                self.successMessage.text = "Your registration was successful, however it must be approved before you an sign in"
                
                self.successMessage.isHidden = false
                
                PFUser.logOut()
            }
            else
            {
                if(error != nil){
                    self.showErrorMessage(error!.localizedDescription, userError: true)
                }
                else{
                    self.showErrorMessage("not sure what happened, but registration failed", userError: false)
                }
            }
        }
        
    }
    
    @IBAction func userForgotPassword(_ sender: AnyObject) {
        if(!isValidEmail(email.text!)){
            showErrorMessage("\(email.text) is not a valid email address",  userError: true)
            return
        }
        
        PFUser.requestPasswordResetForEmail(inBackground: email.text!, block: { (success, err) -> Void in
            if(success){
                self.successMessage.text = "Please check your email, you shuld receive instructions on how to reset your password"
                
                self.successMessage.isHidden = false
            }
            else
            {
                if(err != nil){
                    self.showErrorMessage(err!.localizedDescription, userError: true)
                }
                else{
                    self.showErrorMessage("not sure what happened, but password reset failed", userError: false)
                }
            }
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
