//
//  Movies.swift
//  TMDB
//
//  Created by Veerababu Mulugu on 3/28/22.
//

import Foundation

struct Movies {
    let items: [Movie]
}

extension Movies: Decodable {

    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}
