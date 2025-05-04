//
//  ContentView.swift
//  OmadaTest
//
//  Created by James Lane on 5/4/25.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = MoviesViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if viewModel.movies.isEmpty {
                        Text("No results")
                            .foregroundColor(.gray)
                    } else {
                        List(viewModel.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie)) {
                                MovieRow(movie)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Movie Search")
            .searchable(text: $viewModel.searchText)
            .padding()
        }
    }
}

// MARK: - MovieRow

struct MovieRow: View {

    private let movie: Movie

    init(_ movie: Movie) {
        self.movie = movie
    }

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: movie.posterUrlString ?? "")) { image in
                image.resizable()
                     .frame(width: 60, height: 100)
                     .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle().fill(.gray)
                    .frame(width: 60, height: 100)
            }
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.title3)
                    .bold()
                Text(movie.yearString).foregroundColor(.gray).font(.subheadline)
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
