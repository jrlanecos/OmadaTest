//
//  MovieDetailView.swift
//  OmadaTest
//
//  Created by James Lane on 5/4/25.
//

import SwiftUI

struct MovieDetailView: View {

    let movie: Movie

    init(_ movie: Movie) {
        self.movie = movie
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: movie.posterUrlString ?? "")) { image in
                    image.resizable()
                        .frame(width: 80, height: 140)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Rectangle().fill(.gray)
                        .frame(width: 80, height: 140)
                }
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.title3)
                        .bold()
                    Text(movie.dateString).foregroundColor(.gray).font(.subheadline)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                    Text("Viewer Rating")
                        .foregroundColor(.gray)
                    Text(movie.ratingString)
                        .font(.title)
                        .bold()
                    ProgressView(value: movie.voteAverage, total: 10.0)
                }
            }
            Divider()
            Text("OVERVIEW")
                .font(.title2)
                .bold()
                .foregroundColor(.gray)
            Text(movie.overview)
            Divider()
            Spacer()
        }.padding()
    }
}
