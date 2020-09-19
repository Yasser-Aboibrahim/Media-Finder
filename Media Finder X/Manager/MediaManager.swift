//
//  MediaManager.swift
//  Media Finder X
//
//  Created by yasser on 9/11/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import SQLite

class MediaManager {
    private static let sharedInstance = MediaManager()
    
    private init(){}
    
    static func  Shared() -> MediaManager {
        return MediaManager.sharedInstance
    }
    
    var dataBase: Connection!
    
    let mediaTable = Table("media4") // Create Table with name
    let artworkUrl100 = Expression<String>("artworkUrl100") // create column named artworkUrl100
    let artistName = Expression<String>("artistName") // create column named artistName
    let trackName = Expression<String>("trackName") // create column named trackName
    let previewUrl = Expression<String>("previewUrl") // create column named previewUrl
    let kind = Expression<String>("kind") // create column named kind
    let longDescription = Expression<String>("longDescription") // create column longDescription
    let email = Expression<String>("email") // create column email
    
    func setupConnection(){
        do{
            let documentDirectory = try FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true) // database location
            let fileUrl = documentDirectory.appendingPathComponent("media4").appendingPathExtension("sqlite3") // database name and extension
            let dataBase = try Connection(fileUrl.path) // open file with this path
            self.dataBase = dataBase // connect the vc database to the inner connection (open this file)
        } catch{
            print(error)
        }
    }
    
    func createTable(){
        let createTable = self.mediaTable.create { (table) in
            table.column(self.artworkUrl100)
            table.column(self.artistName)
            table.column(self.trackName)
            table.column(self.previewUrl)
            table.column(self.kind)
            table.column(self.longDescription)
            table.column(self.email)
        }
        do{
            try self.dataBase.run(createTable) // run the created table
            print("Created Table")
        }catch{
            print(error)
        }
    }
    
    func insertMedia(mediaArr: [Media]){
        let userEmail = UserDefaultManager.shared().userEmail!
            for media in mediaArr{
                let insertmedia = self.mediaTable.insert(self.artworkUrl100 <- media.artworkUrl100,self.artistName <- media.artistName ?? "",self.trackName <- media.trackName ?? "",self.previewUrl <- media.previewUrl,self.kind <- media.kind ?? "",self.longDescription <- media.longDescription ?? "",self.email <- userEmail)
                do{
                    try self.dataBase.run(insertmedia) // try to insert data
                    print("Inserted Media")
                }catch{
                    print(error.localizedDescription)
                }
            }
    }

    func deleteMedia(){
        let userEmail = UserDefaultManager.shared().userEmail!
            let media = self.mediaTable.filter(self.email == userEmail)
            let deleteMedia = media.delete() // what to be deleted
            do{
                try self.dataBase.run(deleteMedia) // try to insert data
                print("Deleted Media")
            }catch{
                print(error)
                return
            }
        }

    func getMediaDatabase(completion: (_ mediaArr: [Media]?)-> Void){
        var mediaArr = [Media]()
        let userEmail = UserDefaultManager.shared().userEmail!
        do{
            let media = try self.dataBase.prepare(self.mediaTable.filter(self.email == userEmail))
            for mediaIndex in media{
                let mediaData = Media(artworkUrl100: "\(mediaIndex[self.artworkUrl100])", artistName: "\(mediaIndex[self.artistName])", trackName: "\(mediaIndex[self.trackName])", previewUrl: "\(mediaIndex[self.previewUrl])", kind: "\(mediaIndex[self.kind])", longDescription: "\(mediaIndex[self.longDescription])", email: "\(mediaIndex[self.email])")
                
                
                mediaArr.append(mediaData)
            }
        }catch let error{
            print(error)
            completion(nil)
            
        }
        completion(mediaArr)
    }
    
    
    
}

