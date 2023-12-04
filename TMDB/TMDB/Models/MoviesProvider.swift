//
//  MoviesProvider.swift
//  TMDB
//
//  Created by Veerababu Mulugu on 3/28/22.
//

import Foundation

struct ApiConstants {
    
    static let apiKey = "2a61185ef6a27f400fd92820ad9e8537"
    static let baseUrl = URL(string: "https://api.themoviedb.org/3")!
    static let smallImageUrlString = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/"
    static let originalImageUrlString =  "https://image.tmdb.org/t/p/original"
    
}

final class MusicProvider {
    
    static func fetchMusicAlbums(searchText: String, completion: @escaping (_ albums:[Movie])-> Void) {
        
        let searchTextEn = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        if let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=2a61185ef6a27f400fd92820ad9e8537&query=\(searchTextEn ?? "")") {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let jsonFeedData = try decoder.decode(Movies.self, from: data)
                    print("Response JSON Data : \(jsonFeedData)")
                    DispatchQueue.main.async {
                        
                        completion(jsonFeedData.items)
                    }
                } catch let jsonError {
                    print("Error Json Serialization : \(jsonError.localizedDescription)")
                }
            }.resume()
        } else {
            print("wrong url")
        }        
    }
}
