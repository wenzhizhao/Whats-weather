//
//  WWConstants.swift
//  WhatsWeather
//
//  Created by Wenzhi Zhao on 8/14/18.
//  Copyright © 2018 Wenzhi Zhao. All rights reserved.
//

import Foundation

struct WWConstants {
    static let baseURL = "https://api.darksky.net/forecast/61dc3bba1535a6bd8c977891a27cc632/%@,%@?exclude=currently,minutely,hourly,alerts,flags"
    static let httpMethodGet = "GET"
    static let latitude = "47.6062"
    static let longitude = "-122.3321"
}
