//
//  ContentView.swift
//  Cat App
//
//  Created by administrator on 27.09.21.
//

import SwiftUI

struct ListView: View {
    
    @State var cats: [Cat] = []
    
    @State var selectedCat: Cat?
    
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                List(searchResults) { cat in

                    CatImageRow(cat: cat)
                        .onTapGesture {
                            self.selectedCat = cat
                        }
                }
                .sheet(item: self.$selectedCat) { article in
                    CatDetailView(cat: selectedCat)
                }
                .onAppear(perform: {
                    CatAPIService().getCats { (cats) in
                        self.cats = cats
                    }
                })
                .navigationBarTitle("Katzen")
                .searchable(text: $searchText)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var searchResults: [Cat] {
            if searchText.isEmpty {
                return cats
            } else {
                return cats.filter { $0.name.contains(searchText) }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

struct CatImageRow: View {
    
    var cat: Cat
    
    var body: some View {
        
        ZStack {

            if let image = cat.image, let urlString = image.url {
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: urlString)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 300, maxHeight: 200)
                            .cornerRadius(10)
                            .overlay(
                                Rectangle()
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .opacity(0.2)
                                    .shadow(color: Color.black.opacity(5.0), radius: 5, x: 5, y: 5)
                            )
                    } placeholder: {
                        ProgressView()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 300, maxHeight: 200)
                            .cornerRadius(10)
                            .overlay(
                                Rectangle()
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .opacity(0.2)
                                    .shadow(color: Color.black.opacity(5.0), radius: 5, x: 5, y: 5)
                            )
                    }
                }
            }
            
            Text(cat.name)
                .font(.system(.title, design: .rounded))
                .foregroundColor(.white)
                .fontWeight(.black)
        }
        .listRowBackground(Color.clear)
    }
}
