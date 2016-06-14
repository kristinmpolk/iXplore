//
//  RegisterViewController.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/14/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var email:String?
    var password:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerButtonTapped(sender: UIButton) {
        email = emailTextField.text!
        password = passwordTextField.text!
        UserController.sharedInstance.registerUser(email!, newPassword: password!)
        
    }


}
