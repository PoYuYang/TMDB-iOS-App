//
//  RecommendCardView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/25.
//

import SwiftUI
import Kingfisher

struct RecommendCardView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @Environment(\.openURL) var openURL
//    @State var Add: Bool
//    @State private var showToast: Bool = false
    
    var movie: Card
    var type: String
    var width: CGFloat
    
    init(movie:Card, type:String, width:CGFloat ){
        self.movie = movie
        self.type = type
        self.width = width
//        if(UserDefaults.standard.object(forKey: String(self.movie.id)) != nil){
//
//            _Add = State(initialValue:true)
//
//        }else{
//            _Add = State(initialValue:false)
//        }
        
    }
    
    
    var body: some View {
        ZStack(alignment: .top){
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color.clear)
//                .frame(width:self.width)

            NavigationLink(destination: DetailView(id:String(movie.id),type: self.type)) {
                VStack{
                    KFImage(URL(string: movie.poster_path)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .frame(width:self.width)
                    
                }
                
            }
            
        }
        .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
       
        
//        .contextMenu{
//            Button {action:do {
//                if (!self.showToast) {
//                    self.Add.toggle()
//
//                    withAnimation {
//                        self.showToast = true
//                    }
//                    if (self.Add == true){
//                        UserDefaults.standard.set([type,movie.poster_path],forKey: String(movie.id))
//                    }else{
//                        UserDefaults.standard.removeObject(forKey: String(movie.id))
//                    }
//                    
//                }
//            }
//            } label: {
//                HStack{
//                    Text(self.Add ?"Remove from watchList" : "Add to watchList")
//                    Image(systemName: self.Add ?"bookmark.fill":"bookmark")
//                        .toast(isPresented: self.$showToast) {
//                            HStack {
//                                Text("\(self.Add ? " was added to Wachkist" : " was removed from WatchList")")
//                                    .foregroundColor(.white)
//                                    .multilineTextAlignment(.center)
//                                  
//                            } //HStack
//                        } //toast
//                }
//                
//            }
//
//            Button {openURL(URL(string: "https://www.facebook.com/sharer/sharer.php?u=https://www.themoviedb.org/\(self.type)/\(movie.id)")!)
//            } label: {
//                HStack{
//                    Text("Share on Facebook")
//                    Image("facebook-app-symbol")
//                }
//
//            }
//            
//            Button {openURL(URL(string: "http://twitter.com/intent/tweet?text=Check%20out%20this%20link%3A%20&url=https%3A%2F%2Fwww.themoviedb.org%2F\(self.type)%2F\(movie.id)&hashtags=CSCI571USCFilms")!)
//            } label: {
//                HStack{
//                    Text("Share on Twitter")
//                    Image("twitter")
//                }
//            }
//        }
    }
}

//struct RecommendCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendCardView()
//    }
//}
