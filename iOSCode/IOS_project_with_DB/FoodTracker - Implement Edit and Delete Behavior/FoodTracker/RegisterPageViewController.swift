//
//  RegisterPageViewController.swift
//  FoodTracker
//
//  Created by Diego Alejandro Orellana Lopez on 8/16/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import RealmSwift


class RegisterPageViewController: UIViewController,UITextFieldDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    var user: User?
    var realm : Realm?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        realm = try! Realm()
        print (" the path real is \(realm?.path)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
        
        realm = try! Realm()        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let userEmail1 = userEmailTextField.text!
        let userPassword1 = userPasswordTextField.text!
        let userRepeatPass1 = repeatPasswordTextField.text!
        
        print("user Email \(userEmail1)")
        print("user userPassword \(userPassword1)")
        print("user userRepeatPass \(userRepeatPass1)")
        
        // verificar si los campos esta vacio
        if(userEmail1.isEmpty || userPassword1.isEmpty || userRepeatPass1.isEmpty){
            // mostrar alerta de mensage
            displayMyAlertMensage("All fields are required")
            
            return
        
        }
        if(userPassword1 != userRepeatPass1){
            // mostrar alerta de mensaje
            displayMyAlertMensage("Password do not match")
            return
            
        }
        else{
        user = User(userEmail: userEmail1 , userPassword: userPassword1)
            
            
            let newUserBD = UserDB()
            newUserBD.email = userEmail1
            newUserBD.password = userPassword1
            newUserBD.id = NSUUID().UUIDString
            
            // Guardar en BD
            try! self.realm?.write{
                self.realm?.add(newUserBD)
                print("BASE DATOS \(newUserBD.email)")
            }
          //  displayMensageAlert("Regitred Succefull Satisfactori")
            var myAlert = UIAlertController(title: "Alert", message: "Registration is suncessfull yout!", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){
                action in self.dismissViewControllerAnimated(true, completion: nil)
                }
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            for usuario in (realm?.objects(UserDB.self))!{
                user = User(userEmail: usuario.email, userPassword: usuario.password)
                print("este es el BD usuairo:\(usuario.email) , \(usuario.password)")
            }

        
       }
        
        
        
   }
   
    
 // funcion de lo smensajes de alerta
    func displayMyAlertMensage(userMessage: String){
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
   
    
    
    @IBAction func IhaveAccountTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }


        
    /*    NSUserDefaults.standardUserDefaults().setObject(useremail, forKey: "useremail")
         NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword")*/
        // NSUserDefaults.standardUserDefaults().setObject(userRepeatPass, forKey: "userRepeatPass")
       // NSUserDefaults.standardUserDefaults().synchronize()
        
        /*
        var myAlert = UIAlertController(title: "Alert", message: "Registration is Successful", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){action in self.dismissViewControllerAnimated(true, completion: nil)}
        

        myAlert.addAction(okAction)
        self.presentViewController(myAlert,animated: true, completion: nil)
        */
        
        //muestra alerta de mensaje de confimacion

    
    
    
    func displayMensageAlert(userMenseger: String){
        print("user Alert ini")
    
        var myAlert = UIAlertController(title: "Alert", message: userMenseger, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil )
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert,animated: true, completion: nil)
        print("user Alert fin")
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}