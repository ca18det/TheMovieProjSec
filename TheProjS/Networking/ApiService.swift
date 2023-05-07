//
//  ApiService.swift
//  TheProjS
//
//  Created by Vladislav Zheleznyak on 26.04.2023.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getTrendMovie(compeletion: (Result<JsonBase, Error>) -> Void) {
    //func getTrendMovie(compeletion: @escaping (JsonBase) -> Void) {
        let trendMoviesURL = "https://api.themoviedb.org/3/trending/movie/week?api_key=aa39cecad7fa69ac2de79a24dd561ba3"
        
        guard let url = URL(string: trendMoviesURL) else {return}
        
        // Create url Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
        
            // Handle Error
            if let error = error {
                //compeletion(.failure(error))
                print("DataTast error \(error.localizedDescription)")
                return
            }
            
            // Handle Empty Response
            guard let response = response as? HTTPURLResponse else {
                print("Error Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            // Handle Empty Data
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            //Parse the data
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(JsonBase.self, from: data)
                
                DispatchQueue.main.async {
                    //compeletion(.success(jsonData))
                    print(">> >> >> \(jsonData)")
                }
            } catch let error {
                print(">Parse data: \(error)")
                //compeletion(.failure(error))
            }
         }
        dataTask?.resume()
    }
}
