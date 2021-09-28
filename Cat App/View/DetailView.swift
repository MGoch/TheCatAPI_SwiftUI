//
//  ArticleDetailView.swift
//  SwiftUIModal
//
//  Created by Simon Ng on 19/8/2020.
//

import SwiftUI

struct CatDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
     
    var cat: Cat?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let urlString = cat?.image?.url {
                    if #available(iOS 15.0, *) {
                        AsyncImage(url: URL(string: urlString)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 300, maxHeight: 200)
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
