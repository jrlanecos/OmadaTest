//
//  MoviesViewModel.swift
//  OmadaTest
//
//  Created by James Lane on 5/4/25.
//

import Foundation
import Combine

let baseUrl = "https://api.themoviedb.org/3/search/movie?api_key=b11fc621b3f7f739cb79b50319915f1d&language=en-US" // Assume we don't need to handle fetching additional pages as we scroll down ????? I hope that's ok

@MainActor
class MoviesViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorString: String? = nil
    @Published var searchText: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchText.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                Task {
                    await self?.fetchMovies(query)
                }
            }
            .store(in: &cancellables)
    }

    func fetchMovies(_ query: String) async {
        if query.isEmpty {
            return
        }

        let percentEncodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        guard let url = URL(string: "\(baseUrl)&query=\(percentEncodedQuery)") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            // decoder.dateDecodingStrategy = . maybe later
            let response = try decoder.decode(Movies.self, from: data)
            self.movies = response.results
        } catch {
            errorString = String(describing: error) // gives more detailed I think, will see.
        }
    }
}
