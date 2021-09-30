//
//  ContentView.swift
//  Cat App
//
//  Created by Maximilian Goch on 27.09.21.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var catFetcher = CatAPIService()
    
    @State private var selectedCat: Cat?
    
    @State private var searchText = ""
    
    var searchResults: [Cat] {
        if searchText.isEmpty {
            return catFetcher.cats
        } else {
            return catFetcher.cats.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List(searchResults) { cat in

                CatImageRow(cat: cat)
                    .onTapGesture {
                        self.selectedCat = cat
                    }
            }
            .task {

                await self.catFetcher.fetchCats()
            }
            .refreshable {
                
                await self.catFetcher.fetchCats()
            }
            .sheet(item: self.$selectedCat) { cat in
                CatDetailView(cat: selectedCat)
            }

            .navigationBarTitle("Katzen")
            .searchable(text: $searchText)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

struct CatImageRow: View {
    
    @State var cat: Cat
    
    var body: some View {
        
        ZStack {

            if let urlString = cat.image?.url {
                if #available(iOS 15.0, *) {
                    
                    AsyncImage(url: URL(string: urlString)) { phase in
                        
                        switch phase {
                            case .empty:
                                ProgressView()
                                .scaledToFill()
                                .frame(maxWidth: 300, maxHeight: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 300, maxHeight: 200)
                                    .cornerRadius(10)
                                    .overlay(
                                        Rectangle()
                                            .foregroundColor(.black)
                                            .cornerRadius(10)
                                            .opacity(0.2)
                                            .shadow(color: Color.black.opacity(5.0), radius: 5, x: 5, y: 5))
                            
                            
                                Text(cat.name)
                                    .font(.system(.title, design: .rounded))
                                    .foregroundColor(.white)
                                    .fontWeight(.black)
                            
                                
                            
                            case .failure(_):
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                            @unknown default:
                                EmptyView()
                        }
                    }
                }
            }
            
            
        }
        .listRowBackground(Color.clear)
    }
}
