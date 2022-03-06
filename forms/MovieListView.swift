//
//  MovieList.swift
//  forms
//
//  Created by Hemil Patel on 2/19/22.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var movieStorage = MovieStorage()
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach(Array(movieStorage.movies.enumerated()), id: \.offset){
                    index, currentMovie in
                    NavigationLink(destination:MovieDetailView(movie: currentMovie, newMovie: false, movieIndex: index, movieStorage: movieStorage)){
                        Text(currentMovie.title)
                    }
                }.onDelete { (index) in
                    self.movieStorage.movies.remove(atOffsets: index)
                }
                
            }.navigationBarTitle("Movies").navigationBarItems(trailing:NavigationLink(destination:MovieDetailView(movie: Movie(), newMovie: true,   movieIndex: -1, movieStorage: movieStorage)){
                Text("Add")
            }
            )
        }
        
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
