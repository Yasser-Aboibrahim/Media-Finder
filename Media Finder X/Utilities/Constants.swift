//
//  Constants.swift
//  Media Finder X
//
//  Created by yasser on 8/5/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct UserDefaultsKeys{
    static var user = "UserData"
    static var isLoggedIn = "IsLoggedIn"
    static var userArray = "UserDataArray"
    static var userEmail = "UserEmail"
}

struct ViewController{
    
    static var signInVC = "SignInVC"
    static var signUpVC = "SignUpVC"
    static var profileVC = "ProfileVC"
    static var mapScreen = "MapScreen"
    static var mediaListVC = "MediaListVC"
}

struct Cells{
    static var movieCell = "MoviesCell"
}

struct Urls {
    static let base = "https://api.androidhive.info/json/movies.json"
    static let media = "https://itunes.apple.com/search?"
}

struct Params{
    static let term = "term"
    static let media = "media"
}

struct mediaKindKeys{
    static var song = "song"
    static var movie = "feature-movie"
    static var tvShow = "tv-episode"
}
