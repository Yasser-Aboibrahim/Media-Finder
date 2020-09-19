//
//  User.swift
//  Media Finder X
//
//  Created by yasser on 8/5/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import UIKit

enum Gender: String{
    case male, female
}
struct User {
    //var id: Int?
    var image: Data!
    var name: String!
    var email: String!
    var password: String!
    var address: String!
    var gender: Gender!
}

struct CodableImage: Codable{
    var imageData: Data?
    
     static func setImage(image: UIImage) -> Data? {
         let data = image.jpegData(compressionQuality: 1.0)
        return data
    }
    
    static func getImage(imageData: Data?)-> UIImage?{
        guard let Data = imageData else {
            return nil
        }
        let image = UIImage(data: Data)
        return image
    }
}

