//
//  OmadaTestTests.swift
//  OmadaTestTests
//
//  Created by James Lane on 5/4/25.
//

import XCTest
@testable import OmadaTest

class MovieDecodingTests: XCTestCase {

    func testMovieDecodingFromJSON() throws {
        let json = """
        {
            "id": 1,
            "title": "Inception",
            "overview": "A mind-bending thriller",
            "releaseDate": "2010-07-16",
            "posterPath": "/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            "voteAverage": 8.8
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let movie = try decoder.decode(Movie.self, from: json)

        // Assert direct properties
        XCTAssertEqual(movie.id, 1)
        XCTAssertEqual(movie.title, "Inception")
        XCTAssertEqual(movie.overview, "A mind-bending thriller")
        XCTAssertEqual(movie.voteAverage, 8.8)

        // Assert computed properties
        XCTAssertEqual(movie.ratingString, "8.8/10")
        XCTAssertEqual(movie.yearString, "2010")
        XCTAssertEqual(movie.dateString, "July 16, 2010")
        XCTAssertEqual(movie.posterUrlString, "https://image.tmdb.org/t/p/original/qJ2tW6WMUDux911r6m7haRef0WH.jpg")


        // Assert false values now
        XCTAssertNotEqual(movie.id, 0)
        XCTAssertNotEqual(movie.title, "Inceferjfoerjferption")
        XCTAssertNotEqual(movie.overview, "A mind-bendiffoerwfoierjforeing thriller")
        XCTAssertNotEqual(movie.voteAverage, 8.9)
    }
}
