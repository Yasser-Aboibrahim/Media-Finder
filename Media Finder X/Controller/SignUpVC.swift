//
//  SignUpVC.swift
//  Media Finder X
//
//  Created by yasser on 8/5/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!

    // MARK:- Properties
    var gender = Gender.male
    var user: User?
    var usersArray: [User] = []
    let imagepicker = UIImagePickerController()
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsersDataBase()
        imagepicker.delegate = self
        setNavigationBar()
        
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
    
    private func setNavigationBar(){
        self.navigationItem.hidesBackButton = true
    }
    
    private func isDataEntered()-> Bool{
        guard nameTextField.text != "" else{
            showAlertWithCancel(alertTitle: "Incompleted Data Entry",message: "Please Enter Name",actionTitle: "Dismiss")
            return false
        }
        guard emailTextField.text != "" else{
            showAlertWithCancel(alertTitle: "Incompleted Data Entry",message: "Please Enter email",actionTitle: "Dismiss")
            return false
        }
        guard passwordTextField.text != "" else{
            showAlertWithCancel(alertTitle: "Incompleted Data Entry",message: "Please Enter Password",actionTitle: "Dismiss")
            return false
        }
        guard addressTextField.text != "" else{
            showAlertWithCancel(alertTitle: "Incompleted Data Entry",message: "Please Enter address",actionTitle: "Dismiss")
            return false
        }
        guard userImageView.image != UIImage(named: "empty_profile_picture") else{
            showAlertWithCancel(alertTitle: "Incompleted Data Entry",message: "Please add photo",actionTitle: "Dismiss")
            return false
        }
        return true
    }

    private func isValidRegex() -> Bool{
        guard isValidEmail(email: emailTextField.text) else{showAlertWithCancel(alertTitle: "Wrong Email Form",message: "Please Enter Valid email(a@a.com)",actionTitle: "Dismiss")
            return false
        }
        guard isValidPassword(testStr: passwordTextField.text) else{
            showAlertWithCancel(alertTitle: "Wrong Password Form",message: "Password need to be : \n at least one uppercase \n at least one digit \n at leat one lowercase \n characters total",actionTitle: "Dismiss")
            return false
        }
        return true
    }
    
    private func userEmailCheck(_ usersArr:[User]) -> Bool {
        for element in usersArr{
            if emailTextField.text == element.email{
                showAlertWithCancel(alertTitle: "Alert",message: "The email is already taken",actionTitle: "Dismiss")
                return false
            }
        }
        return true
    }
    
    private func goToSignInVC(){
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sginInVC = mainStoryboard.instantiateViewController(withIdentifier: ViewController.signInVC) as! SignInVC
        let imageToData = CodableImage.setImage(image: userImageView.image!)
        let user = User(image: imageToData,name: nameTextField.text,email: emailTextField.text, password: passwordTextField.text, address: addressTextField.text,gender: gender)
        
        UserDatabaseManager.Shared().insertUser(user: user)
        
        self.navigationController?.pushViewController(sginInVC, animated: true)
    }
    
    // MARK:- Actions
    @IBAction func genderSwitchChange(_ sender: UISwitch) {
        if sender.isOn{
            gender = .male
        }else{
            gender = .female
        }
    }
    
    @IBAction func userImageBtnPressed(_ sender: UIButton) {
        imagepicker.allowsEditing = true
        imagepicker.sourceType = .photoLibrary
        present(imagepicker, animated: true, completion: nil)
    }
    
    @IBAction func goToSignInBtn(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sginInVC = mainStoryboard.instantiateViewController(withIdentifier: ViewController.signInVC) as! SignInVC
        self.navigationController?.pushViewController(sginInVC, animated: true)
    }
    
    @IBAction func addressBtnTapped(_ sender: UIButton) {
        let mapScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.mapScreen) as! MapScreen
        //4-
        mapScreen.delegate = self
        self.present(mapScreen, animated: true, completion: nil)
        
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        if isDataEntered(){
            if isValidRegex(){
                if userEmailCheck(usersArray){
                goToSignInVC()
                }
            }
        }
    }
    
}

// MARK:- Image Picker extension
extension SignUpVC: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            //userImageView.contentMode = .scaleAspectFit
            userImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK:- AddressSendingDelegate
extension SignUpVC: AddressSendingDelegate {
    //5-
    func sendAdress(_ address: String){
        addressTextField.text = address
    }
}
