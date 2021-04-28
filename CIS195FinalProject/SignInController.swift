//
//  SignInController.swift
//  CIS195FinalProject
//
//  Created by Ryan Sathianathen on 4/27/21.
//

import UIKit
import FirebaseAuth


class SignInController : UIViewController {
    
    private let logLabel: UILabel = {
        let logLabel = UILabel()
        logLabel.textAlignment = .center
        logLabel.text = "Log In"
        logLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        return logLabel
    } ()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email Address"
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.autocapitalizationType = .none
        emailField.backgroundColor = .white
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
        return emailField
    } ()
    
    private let passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.black.cgColor
        passwordField.backgroundColor = .white
        passwordField.leftViewMode = .always
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return passwordField
    } ()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log In", for: .normal)
        return button
    } ()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log Out", for: .normal)
        return button
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(button)
        view.backgroundColor = .systemPurple
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            logLabel.isHidden = true
            emailField.isHidden = true
            passwordField.isHidden = true
            button.isHidden = true
            
            view.addSubview(signOutButton)
            signOutButton.frame = CGRect(x: 20, y: 150, width: view.frame.size.width-40, height: 52)
            signOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        }

    }
    
    @objc func logOutTapped () {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            logLabel.isHidden = false
            emailField.isHidden = false
            passwordField.isHidden = false
            button.isHidden = false
            
            signOutButton.removeFromSuperview()
        } catch {
            print ("An error occurred")
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logLabel.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 80)
        
        emailField.frame = CGRect(x: 20,
                                  y: logLabel.frame.origin.y+logLabel.frame.size.height + 10,
                                  width: view.frame.size.width - 40,
                                  height: 50)

       passwordField.frame = CGRect(x: 20,
                                    y: emailField.frame.origin.y+emailField.frame.size.height + 10,
                                    width: view.frame.size.width-40,
                                    height: 50)
        
        button.frame = CGRect(x: 20,
                              y: passwordField.frame.origin.y+emailField.frame.size.height + 30,
                              width: view.frame.size.width-40,
                              height: 52)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FirebaseAuth.Auth.auth().currentUser == nil {
            emailField.becomeFirstResponder()
        }
        
    }
    
    @objc private func didTapButton(){
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            print ("Missing Data")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            
            guard let strongSelf = self else {
                return
            }
            
            
        
            guard error == nil else {
                let errCode = error! as NSError
                if errCode.code == AuthErrorCode.wrongPassword.rawValue {
                    let alert = UIAlertController (title: "Wrong Password", message: "An incorrect password has been entered. Please enter the correct password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in}))
                    strongSelf.present(alert, animated: true)
                    return
                } else if errCode.code == AuthErrorCode.invalidEmail.rawValue {
                    let alert = UIAlertController (title: "Invalid Email", message: "An invalid email has been entered. Please enter a valid email", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in}))
                    strongSelf.present(alert, animated: true)
                    return
                } else {
                    strongSelf.showCreateAccount(email: email, password: password)
                    return
                }
                
            }
            
            print ("you have signed in")
            strongSelf.logLabel.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.button.isHidden = true
            
            strongSelf.emailField.resignFirstResponder()
            strongSelf.passwordField.resignFirstResponder()
            strongSelf.performSegue(withIdentifier: "loggedIn", sender: self)
        })
        
        
        
    }
    
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController (title: "Create Account", message: "Would you like to create an account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Create",
                                      style: .default,
                                      handler: {_ in
                                        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self] result, error in
                                            guard let strongSelf = self else {
                                                return
                                            }
                                            guard error == nil else {
                                                let errCode = error! as NSError
                                                if errCode.code == AuthErrorCode.weakPassword.rawValue{
                                                    let alert = UIAlertController (title: "Weak Password", message: "Your password is too weak. Please enter a more complex password", preferredStyle: .alert)
                                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in}))
                                                    strongSelf.present(alert, animated: true)
                                                    return
                                                } else {
                                                    let alert = UIAlertController (title: "Error", message: "An error has occured. Please try inputting your information in again.", preferredStyle: .alert)
                                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in}))
                                                    strongSelf.present(alert, animated: true)
                                                    return
                                                }
                                                
                                            
                                            }
                                            
                                            
                                            strongSelf.logLabel.isHidden = true
                                            strongSelf.emailField.isHidden = true
                                            strongSelf.passwordField.isHidden = true
                                            strongSelf.button.isHidden = true
                                            
                                            strongSelf.emailField.resignFirstResponder()
                                            strongSelf.passwordField.resignFirstResponder()
                                            self?.performSegue(withIdentifier: "loggedIn", sender: self)
                                        })
                                      }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
        present(alert, animated:true)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
