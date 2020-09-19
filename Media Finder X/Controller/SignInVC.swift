//
//  SignInVC.swift
//  Media Finder X
//
//  Created by yasser on 8/5/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//


import UIKit

class SignInVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK:- Properties
    var user: User?
    var usersArray: [User] = []
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsersDataBase()
        UserDefaultManager.shared().isLoggedIn = false
        self.navigationItem.hidesBackButton = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setUsersDataBase()
        UserDefaultManager.shared().isLoggedIn = false
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK:- Public Methods
    private func setUsersDataBase(){
        UserDatabaseManager.Shared().setupConnection()
        UserDatabaseManager.Shared().createTable()
        UserDatabaseManager.Shared().getUsersDatabase{ usersArr in
            if let usersArrCheck = usersArr{
                self.usersArray = usersArrCheck
                
            }else{
                self.usersArray = []
            }
        }
    }
    
    private func isDataEntered()-> Bool{
        
        guard emailTextField.text != "" else{
            showAlertWithCancel(alertTitle: "Incompleted Data Entry",message: "Please Enter Email",actionTitle: "Dismiss")
            return false
        }
        guard passwordTextField.text != "" else{
            showAlertWithCancel(alertTitle: "Incompleted Data Entry",message: "Please Enter Password",actionTitle: "Dismiss")
            return false
        }
        
        return true
    }
    
    private func isValidRegex() -> Bool{
        guard isValidEmail(email: emailTextField.text) else{
            showAlertWithCancel(alertTitle: "Alert",message: "Please Enter Valid Email",actionTitle: "Dismiss")
            return false
        }
        guard isValidPassword(testStr: passwordTextField.text) else{
            showAlertWithCancel(alertTitle: "Alert",message: "Password is Incorect",actionTitle: "Dismiss")
            return false
        }
        return true
    }
    
    private func checkUserData(_ usersArr: [User]) -> Bool{
        for (index ,element) in usersArr.enumerated(){
            if emailTextField.text == element.email && passwordTextField.text == element.password {
                user = usersArr[index]
                UserDefaultManager.shared().userEmail = user!.email
                return true
            }
        }
        return false
    }
    
    private func goToMovieListVC(){
        let movieListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.mediaListVC) as! MediaListVC
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    private func goToSignUpVC(){
        let signUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.signUpVC ) as! SignUpVC
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    // MARK:- Actions
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        if isDataEntered(){
            if isValidRegex(){
                if checkUserData(usersArray){
                    goToMovieListVC()
                }else{
                    showAlertWithCancel(alertTitle: "Alert",message: "Password and Email not valid",actionTitle: "Dismiss")
                }
            }
        }
    }
    
    @IBAction func deleteUserData(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.isLoggedIn)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userEmail)
        goToSignUpVC()
    }
}
