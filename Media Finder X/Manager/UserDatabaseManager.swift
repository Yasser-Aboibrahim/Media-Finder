//
//  UserDatabaseManager.swift
//  Media Finder X
//
//  Created by yasser on 9/11/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import SQLite

class UserDatabaseManager {
    private static let sharedInstance = UserDatabaseManager()
    
    private init(){}
    
    static func  Shared() -> UserDatabaseManager {
        return UserDatabaseManager.sharedInstance
    }
    
    var dataBase: Connection!
    
    let usersTable = Table("users2") // Create Table with name
    let id = Expression<Int>("id") // create column named id
    let name = Expression<String>("name") // create column named name
    let email = Expression<String>("email") // create column named email
    let image = Expression<Data>("image") // create column named image
    let password = Expression<String>("password") // create column named password
    let address = Expression<String>("address") // create column named address
    let gender = Expression<String>("gender") // create column named gender
    
    func setupConnection(){
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) // database location
            let fileUrl = documentDirectory.appendingPathComponent("users2").appendingPathExtension("sqlite3") // database name and extension
            let dataBase = try Connection(fileUrl.path) // open file with this path
            self.dataBase = dataBase // connect the vc database to the inner connection (open this file)
        } catch{
            print(error)
        }
    }
    
    func createTable(){
        let createTable = self.usersTable.create { (table) in
            table.column(self.id, primaryKey: true) // specific num for each row
            table.column(self.name)
            table.column(self.email, unique:true) // to avoid the duplication for eamil
            table.column(self.image)
            table.column(self.password)
            table.column(self.address)
            table.column(self.gender)
        }
        do{
            try self.dataBase.run(createTable) // run the created table
            print("Created Table")
        }catch{
            print(error)
        }
    }

    func insertUser(user: User){
        let insertUser = self.usersTable.insert(self.name <- user.name,self.email <- user.email ,self.image <- user.image ,self.password <- user.password ,self.address <- user.address ,self.gender <- user.gender.rawValue ) // what to be inserted into the database
            do{
                try self.dataBase.run(insertUser) // try to insert data
                print("Inserted User")
            }catch{
                print(error)
            }
        }
 
    func deleteUser(email: String ,present: (_ Alert: UIViewController) -> Void){
        print("Update Tapped")
        let alert = UIAlertController(title: "Update User",message:  nil,preferredStyle: .alert) // UIalert implementation
        alert.addTextField { (tf) in tf.placeholder = "User Email"} // name textfield
        let action = UIAlertAction(title: "Submit", style: .default){(_) in
            guard let userEmail = alert.textFields?.first?.text else { return }
            print(userEmail)
            let user = self.usersTable.filter(self.email == userEmail)
            let deleteUser = user.delete() // what to be deleted
            do{
                try self.dataBase.run(deleteUser) // try to insert data
                print("Updated User")
            }catch{
                print(error)
            }
        }
        alert.addAction(action) // add action of submittion button to alert
        present(alert)
        
    }
    
    func getUsersDatabase(completion: (_ usersArr: [User]?)-> Void){
        var usersArr = [User]()
        do{
            let users = try self.dataBase.prepare(self.usersTable)
            for user in users{
                let userData = User(image: user[self.image], name: "\(user[self.name])", email: "\(user[self.email])", password: "\(user[self.password])", address: "\(user[self.address])", gender: Gender(rawValue: "\(user[self.gender])"))
                usersArr.append(userData)
            }
        }catch{
            print(error)
            completion(nil)
        }
        completion(usersArr)
    }
}



