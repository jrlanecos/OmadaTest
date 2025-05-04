//
//  Movies.swift
//  OmadaTest
//
//  Created by James Lane on 5/4/25.
//

import Foundation

class Movies: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {

    let id: Int
    let title: String
    let overview: String
    private let releaseDate: String // yyyy-MM-dd format
    private let posterPath: String? // relative path
    let voteAverage: Float

    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self.releaseDate) else { return "Unknown date" }

        let longDateFormatter = DateFormatter()
        longDateFormatter.dateStyle = .long
        return longDateFormatter.string(from: date)
    }

    var ratingString: String {
        return "\(String(format:"%.1f", self.voteAverage))/10"
    }

    var yearString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self.releaseDate) else { return "Unknown year" }

        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        return yearFormatter.string(from: date)
    }

    var posterUrlString: String? {
        guard let posterPath else { return nil }
        return "https://image.tmdb.org/t/p/original\(posterPath)"
    }
}
