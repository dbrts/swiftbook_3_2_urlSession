//
//  Weather.swift
//  swiftbook_3_2_urlSession
//
//  Created by dobrets on 06.11.2022.
//

// MARK: - Weather
struct Weather: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let currentWeather: CurrentWeather

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS
        case utcOffsetSeconds
        case timezone
        case timezoneAbbreviation
        case elevation
        case currentWeather
    }
}

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let temperature, windspeed: Double
    let winddirection, weathercode: Int
    let time: String
}
