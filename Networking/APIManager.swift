//
//  APIManager.swift
//  Media Finder X
//
//  Created by yasser on 8/30/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager{
    static func loadMovies(mediaType: String ,criteria: String ,completion: @escaping (_ error : Error?, _ movies: [Media]?) -> Void){
        
        let param = [Params.media: mediaType,Params.term: criteria]
        
        Alamofire.request(Urls.media, method: HTTPMethod.get, parameters: param , encoding: URLEncoding.default, headers: nil).response{ response in
            guard response.error == nil else{
                completion(response.error,nil)
                return
            }
            guard let data = response.data else{
                print("didn't any data from the server")
                return
            }
            do{
            let mediaArr = try? JSONDecoder().decode(MediaResponse.self,from: data).results
            completion(nil,mediaArr)
            }catch let error {
                print(error)
            }
        }
        
    }
    
}

