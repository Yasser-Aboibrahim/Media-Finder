//
//  MediaResponse.swift
//  Media Finder X
//
//  Created by yasser on 9/6/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct MediaResponse: Decodable {
    var resultCount: Int
    var results: [Media]
}
