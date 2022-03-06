//
//  ContentView.swift
//  forms
//
//  Created by Hemil Patel on 2/19/22.
//

import SwiftUI

struct MovieDetailView: View {
    
    @State var movie : Movie
    @Environment(\.presentationMode) var presentationMode
    let newMovie: Bool
    let movieIndex: Int
    @ObservedObject var movieStorage : MovieStorage
    
    var body: some View {
        
        List{
            Section{
                Text("Movie Title")
                TextField("Enter Movie Name",text:$movie.title )
            }
            
            Section{
                Text("Rating")
                HStack{
                    Spacer()
                    Text(String(repeating: "*", count: Int(movie.rating))).font(.largeTitle).foregroundColor(.yellow)
                    Spacer()
                }
                Slider(value:$movie.rating, in:1...5, step:1)
            }
            
            Section{
                Text("Seen")
                Toggle(isOn: $movie.seen){
                    if(movie.title == ""){
                        Text("I have \(movie.seen == true ? "" : "not") seen this movie")
                    } else {
                        Text("I have \(movie.seen == true ? "" : "not") seen \(movie.title)")
                    }
                }
            }
            
            Section {
                Button(action: {
                    if newMovie {
                        movieStorage.movies.append(movie)
                        movieStorage.saveData()
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    HStack{
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                }
            }
            if(!newMovie){
                Section {
                    Button(action: {
                        if !newMovie {
                            print(movie.id)
                            movieStorage.movies.remove(at:movieIndex)
                            movieStorage.saveData()
                        }
                    }){
                        HStack{
                            Spacer()
                            Text("Delete")
                            Spacer()
                        }
                    }
                }
            }
        }.listStyle(GroupedListStyle())
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MovieDetailView(movie: Movie(), newMovie: true, movieIndex: 0, movieStorage:MovieStorage())
        }
    }
}
