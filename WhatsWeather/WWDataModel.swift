//
//  WWDataModel.swift
//  WhatsWeather
//
//  Created by Wenzhi Zhao on 8/14/18.
//  Copyright © 2018 Wenzhi Zhao. All rights reserved.
//

import Foundation

struct WWSummary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case summaryList = "daily"
    }
    var summaryList : WWSummaryList
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        summaryList = try container.decode(WWSummaryList.self, forKey: .summaryList)
    }
}

struct WWWeather : Decodable {
    private enum CodingKeys: String, CodingKey {
        case date = "time"
        case minTemperature = "temperatureMin"
        case maxTemperature = "temperatureMax"
        case summary
        case visibility
        case windSpeed
        case humidity
    }
    var date : Date
    var minTemperature : Decimal
    var maxTemperature : Decimal
    var summary: String
    var visibility: Decimal
    var windSpeed: Decimal
    var humidity: Decimal
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Date.self, forKey: .date)
        minTemperature = try container.decode(Decimal.self, forKey: .minTemperature)
        maxTemperature = try container.decode(Decimal.self, forKey: .maxTemperature)
        summary = try container.decode(String.self, forKey: .summary)
        visibility = try container.decode(Decimal.self, forKey: .visibility)
        windSpeed = try container.decode(Decimal.self, forKey: .windSpeed)
        humidity = try container.decode(Decimal.self, forKey: .humidity)
    }
}

struct WWSummaryList: Decodable {
    private enum CodingKeys: String, CodingKey {
        case weatherList = "data"
    }
    var weatherList: [WWWeather]
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        weatherList = try container.decode([WWWeather].self, forKey: .weatherList)
    }
}

