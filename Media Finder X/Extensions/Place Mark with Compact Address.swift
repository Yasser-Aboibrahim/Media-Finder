//
//  Place Mark with Compact Address.swift
//  Media Finder X
//
//  Created by yasser on 8/13/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import MapKit

extension CLPlacemark{
    var compactAddress: String? {
        if let name = name{
            var result = name
            if let street = thoroughfare{
                result += ",\(street)"
            }
            if let city = locality{
                result += ",\(city)"
            }
            if let country = country{
                result += ",\(country)"
            }
            return result
        }
        return nil
    }
}
