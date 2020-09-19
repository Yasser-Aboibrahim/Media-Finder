//
//  Media.swift
//  Media Finder X
//
//  Created by yasser on 9/6/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

public enum MediaTypes: String {
    case music = "music"
    case movie = "movie"
    case tvShow = "tvShow"
}

struct Media: Decodable{
    var artworkUrl100: String
    var artistName: String?
    var trackName: String?
    var previewUrl: String
    var kind: String?
    var longDescription: String?
    var email: String!
    
    func getType()-> MediaTypes{
        switch self.kind{
        case mediaKindKeys.song:
            return MediaTypes.music
        case mediaKindKeys.movie:
            return MediaTypes.movie
        case mediaKindKeys.tvShow:
            return MediaTypes.tvShow
        default:
            return MediaTypes.music
        }
    }
    
}
