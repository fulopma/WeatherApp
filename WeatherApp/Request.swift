//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Marcell Fulop on 5/7/25.
//

import Foundation

/// This will be for cities
struct CitiesRequest: Request {
    var baseURL: String = "https://dataservice.accuweather.com"
    var path: String = "/locations/v1/topcities/50"
    var httpMethod: HttpMethod = .get
    var params: [String: String] = [
        "apikey": "kAP3jGb5EV3XvxVxV6xfmXoNSjGovsvD"
    ]
    var header: [String: String]?

    static func createRequest() -> CitiesRequest {
        return CitiesRequest()
    }

}

struct WeatherRequest: Request {
    var baseURL: String = "https://dataservice.accuweather.com"
    var path: String = "/forecasts/v1/hourly/1hour/"
    var httpMethod: HttpMethod = .get
    var params: [String: String] = [
        "apikey": "kAP3jGb5EV3XvxVxV6xfmXoNSjGovsvD"
    ]
    var header: [String: String]?

    static func createRequest(cityKey: String) -> WeatherRequest {
        var wr = WeatherRequest()
        wr.path += cityKey
        return wr
    }

}
