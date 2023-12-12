//
//  ServiceAPI.swift
//  4206_IOSproject_TsangKaPo_ChowChingHo_NgKaKin
//
//  Created by user on 11/12/2023.
//

import UIKit

import Foundation

class APIService{
    static let shared = APIService()

    private init() {}

    func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        var components = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather?")

        let latString = String(lat)
        let lonString = String(lon)
        
        // Add query items
        let queryItems = [
            URLQueryItem(name: "appid", value: "a9c1f1c45c94c6c0f9d5b13948b74431"),
            URLQueryItem(name: "lat", value: latString),
            URLQueryItem(name: "lon", value: lonString)
        ]
        components?.queryItems = queryItems

        // Construct the final URL
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            do{
                let currentweather = try JSONDecoder().decode(CurrentWeather.self,from: data)
                completion(.success(currentweather))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
