//
//  MovieViewModel.swift
//  TheProjS
//
//  Created by Vladislav Zheleznyak on 26.04.2023.
//

import Foundation

class MovieViewModel {
    
    private var apiService = ApiService()
    private var trendMovie = [Results]()
    
    func fetchTrendMovieData(completion: @escaping () -> ()) {
        apiService.getTrendMovie { [weak self] (result) in
            
                switch result {
                case .success(let listOf) :
                    self?.trendMovie = listOf.results!
                    print(" # # # # # # # # # # # # # # # #\(trendMovie.count)")
                    completion()
                case.failure(let error) :
                    print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowInSection(section: Int) -> Int {
        if trendMovie.count != 0 {
            return trendMovie.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Results {
        print(" ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##")
        return trendMovie[indexPath.row]
    }
}
