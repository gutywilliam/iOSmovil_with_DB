//
//  LoginViewController.swift
//  FoodTracker
//
//  Created by Diego Alejandro Orellana Lopez on 8/16/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    
    var realmReg: Realm?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmReg = try! Realm()
        loadDB()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDB(){
        for me in (realmReg?.objects(UserDB.self))! {
            // let count = MealDB?
            let userLogin = User(userEmail: me.email, userPassword: me.password)
            //meals.append(meal!)
            print("Usuarios ")
            
            
            
        }
        
    }

    
    
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        let userEmail = userEmailTextField.text
        let userPass =  userPasswordTextField.text
        
       
      
        
        
        
        
    }
    
   /* override func viewDidAppear(animated: Bool) {
        self.performSegueWithIdentifier("loginView", sender: self)
    }
    */
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
