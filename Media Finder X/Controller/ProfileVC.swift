//
//  ProfileVC.swift
//  Media Finder X
//
//  Created by yasser on 8/5/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    // MARK:- Properties
    var userEmail: String = ""
    var user: User?
    var usersArray: [User] = []
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsersDataBase()
        setupData()
        setNavigationBar()
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: <#T##UIImage?#>, style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUsersDataBase()
        setupData()
        UserDefaultManager.shared().isLoggedIn = true
        setNavigationBar()
        
    }
    
    // MARK:- Public Methods
    @objc private func tapBtn(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setNavigationBar(){
        self.navigationItem.hidesBackButton = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Movie List", style: .plain, target: self, action: #selector(tapBtn))
    }
    
    private func setUsersDataBase(){
        userEmail = UserDefaultManager.shared().userEmail ?? ""
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
    
    private func setupData(){
        if getUserData(usersArray){
        userImageView.image = CodableImage.getImage(imageData: user?.image)
        addressLabel.text = user?.address
        emailLabel.text = user?.email
        nameLable.text = user?.name
        genderLabel.text = user?.gender.rawValue
        }else{return}
    }
    
    private func getUserData(_ usersArr: [User]) -> Bool{
        for (index ,element) in usersArr.enumerated(){
            if userEmail == element.email  {
                user = usersArr[index]
                
                return true
            }
        }
        return false
    }
    
    private func goToSignInVC(){
        let sginInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.signInVC) as! SignInVC
        
        UserDefaultManager.shared().isLoggedIn = false
        self.navigationController?.pushViewController(sginInVC, animated: true)
    }
    
    // MARK:- Actions
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
        goToSignInVC()
    }
}

