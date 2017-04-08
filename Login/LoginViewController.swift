//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    let button: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Avenir", size: 30)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = Constants.backgroundColor
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(performLogin), for: .touchDown)
        return loginButton
    }()
    
    let mainText: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Title View Controller"
        titleLabel.font = UIFont(name: "Avenir", size: 32)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = NSTextAlignment.center
        return titleLabel
    }()
    
    var login: UIView = {
        let loginView = UIView()
        loginView.backgroundColor = UIColor.white
        loginView.layer.cornerRadius = 25
        loginView.layer.borderWidth = 6
        return loginView
    }()
    
    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.backgroundColor = UIColor.white
        return textField
    }()
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = UIColor.white
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        login.addSubview(loginTextField)
        login.addSubview(passwordTextField)
        login.addSubview(button)
        view.addSubview(mainText)
        view.addSubview(login)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        login.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        mainText.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: layout your views using frames or AutoLayout
        button.translatesAutoresizingMaskIntoConstraints = false
        let myConstraints = [
            login.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            login.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            login.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3),
            login.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20),
            
            button.bottomAnchor.constraint(equalTo: login.bottomAnchor , constant: -10),
            button.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/12),
            button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/3),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.bottomAnchor.constraint(equalTo: button.topAnchor , constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: login.leadingAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            loginTextField.leadingAnchor.constraint(equalTo: login.leadingAnchor, constant: 10),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainText.bottomAnchor.constraint(equalTo: login.topAnchor, constant: -30),
            mainText.leadingAnchor.constraint(equalTo: login.leadingAnchor, constant: 0),
            mainText.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/7)
        ]
        NSLayoutConstraint.activate(myConstraints)
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func performLogin(sender: UIButton) {
        authenticateUser(username: loginTextField   .text, password: passwordTextField.text)
    }
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
