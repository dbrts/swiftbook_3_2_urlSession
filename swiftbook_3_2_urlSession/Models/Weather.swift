//
//  Weather.swift
//  swiftbook_3_2_urlSession
//
//  Created by dobrets on 06.11.2022.
//

// MARK: - Weather
struct Weather: Decodable {
    let latitude, longitude, generationtime_ms: Double?
    let utc_offset_seconds: Int?
    let timezone, timezone_abbreviation: String?
    let elevation: Int?
    let current_weather: CurrentWeather?
}

// MARK: - CurrentWeather
struct CurrentWeather: Decodable {
    let temperature, windspeed: Double?
    let winddirection, weathercode: Int?
    let time: String?
}
