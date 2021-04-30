//
//  RecommendHorizontalView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/25.
//

import SwiftUI

struct RecommendHorizontalView: View {
    var movies:[Card]
    var title:String
    var type: String
 
    var body: some View {
        VStack(alignment:.leading){
            Text("\(self.title)")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold).padding()
                GeometryReader { g in
                    ScrollView(.horizontal, showsIndicators: true){
                        HStack(spacing:20){
                                ForEach(self.movies, id: \.id){ movie in
                                    RecommendCardView(movie: movie, type: self.type, width: g.size.width/3.8)
                                }
                            }.padding(20)
                        }
                }
        }
        
    }
}

struct RecommendHorizontalView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendHorizontalView(movies: [],title: "",type:"")
    }
}
