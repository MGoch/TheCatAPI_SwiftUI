//
//  ArticleDetailView.swift
//  SwiftUIModal
//
//  Created by Maximilian Goch on 27.09.21.
//

import SwiftUI

struct CatDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
     
    @State var cat: Cat?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let urlString = cat?.image?.url {
                    AsyncImage(url: URL(string: urlString)) { phase in
                        
                        switch phase {
                            case .empty:
                                Color.purple.opacity(0.1)
                            case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            case .failure(_):
                                Image(systemName: "exclamationmark.icloud")
                                    .resizable()
                                    .scaledToFit()
                            @unknown default:
                                Image(systemName: "exclamationmark.icloud")
                        }
                    }
                    
                }
                    
                Group {
                    Text(cat?.name ?? "")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.black)
                        .lineLimit(3)
                        
                    Text(cat?.origin.uppercased() ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 0)
                .padding(.horizontal)
                
                Text(cat?.description ?? "")
                    .font(.body)
                    .padding()
                    .lineLimit(1000)
                    .multilineTextAlignment(.leading)
            }
        }
        .overlay(
            HStack {
                
                Spacer()
    
                VStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    })
                    .padding(.trailing, 20)
                    .padding(.top, 40)
                    
                    Spacer()
                }
            }
        )
    }
}

struct CatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CatDetailView()
    }
}
