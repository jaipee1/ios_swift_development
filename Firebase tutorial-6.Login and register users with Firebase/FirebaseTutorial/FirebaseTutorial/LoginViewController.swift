//
//  LoginViewController.swift
//  FirebaseTutorial
//
//  Created by Nguyen Duc Hoang on 4/24/17.
//  Copyright © 2017 Nguyen Duc Hoang. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!;
    @IBOutlet weak var txtPassword: UITextField!;
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail?.translatesAutoresizingMaskIntoConstraints = false
        txtPassword?.translatesAutoresizingMaskIntoConstraints = false
        btnLogin?.translatesAutoresizingMaskIntoConstraints = false
        btnRegister?.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.isNavigationBarHidden = true
        
        view.addConstraint(NSLayoutConstraint(item: txtEmail, attribute: .width, relatedBy: .equal,
                                              toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200))
        view.addConstraint(NSLayoutConstraint(item: txtEmail, attribute: .height, relatedBy: .equal,
                                              toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        
        view.addConstraint(NSLayoutConstraint(item: txtEmail, attribute: .centerX, relatedBy: .equal,
                                              toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: txtEmail, attribute: .centerY, relatedBy: .equal,
                                              toItem: view, attribute: .centerY, multiplier: 1, constant: -100))
        
        view.addConstraint(NSLayoutConstraint(item: txtPassword, attribute: .top, relatedBy: .equal,
                                              toItem: txtEmail, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstraint(NSLayoutConstraint(item: txtPassword, attribute: .width, relatedBy: .equal,
                                              toItem: txtEmail, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: txtPassword, attribute: .height, relatedBy: .equal,
                                              toItem: txtEmail, attribute: .height, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: txtPassword, attribute: .centerX, relatedBy: .equal,
                                              toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: btnLogin, attribute: .top, relatedBy: .equal,
                                              toItem: txtPassword, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstraint(NSLayoutConstraint(item: btnLogin, attribute: .width, relatedBy: .equal,
                                              toItem: txtEmail, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: btnLogin, attribute: .height, relatedBy: .equal,
                                              toItem: txtEmail, attribute: .height, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: btnLogin, attribute: .centerX, relatedBy: .equal,
                                              toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        btnLogin.addTarget(self, action: #selector(btnLogin(sender:)), for: .touchUpInside)
        
        view.addConstraint(NSLayoutConstraint(item: btnRegister, attribute: .top, relatedBy: .equal,
                                              toItem: btnLogin, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstraint(NSLayoutConstraint(item: btnRegister, attribute: .width, relatedBy: .equal,
                                              toItem: txtEmail, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: btnRegister, attribute: .height, relatedBy: .equal,
                                              toItem: txtEmail, attribute: .height, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: btnRegister, attribute: .centerX, relatedBy: .equal,
                                              toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        btnRegister.addTarget(self, action: #selector(btnRegister(sender:)), for: .touchUpInside)
        
        view.backgroundColor = UIColor(red: 68 / 255, green: 169 / 255, blue: 128 / 255, alpha: 1)
        btnLogin.backgroundColor = UIColor.orange
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnRegister.backgroundColor = UIColor.orange
        btnRegister.setTitleColor(UIColor.white, for: .normal)
        
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.masksToBounds = true
        btnRegister.layer.cornerRadius = 5
        btnRegister.layer.masksToBounds = true
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                let petViewController: PetViewController = PetViewController(nibName: "PetViewController", bundle: nil)
                self.navigationController?.pushViewController(petViewController, animated: true)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogin(sender: AnyObject) {
        FIRAuth.auth()!.signIn(withEmail: self.txtEmail.text!,
                               password: self.txtPassword.text!){ (firUser, error) in
                                if firUser != nil {
                                    let petViewController: PetViewController = PetViewController(nibName: "PetViewController", bundle: nil)
                                    self.navigationController?.pushViewController(petViewController, animated: true)
                                }
        }
        
        let petViewController: PetViewController = PetViewController(nibName: "PetViewController", bundle: nil)
        self.navigationController?.pushViewController(petViewController, animated: true)
    }
    
    @IBAction func btnRegister(sender: AnyObject) {
        if(txtEmail.text?.isEmpty == true) {
            print("Email is blank")
            return
        }
        FIRAuth.auth()!.createUser(withEmail: txtEmail.text!,
                                   password: txtPassword.text!) { user, error in
                                    if error == nil {
                                        FIRAuth.auth()!.signIn(withEmail: self.txtEmail.text!,
                                                               password: self.txtPassword.text!)
                                        let petViewController: PetViewController = PetViewController(nibName: "PetViewController", bundle: nil)
                                        self.navigationController?.pushViewController(petViewController, animated: true)
                                    }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}