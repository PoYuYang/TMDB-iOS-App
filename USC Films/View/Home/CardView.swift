//
//  CardView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/24.
//

import SwiftUI
import Kingfisher

struct CardView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    @ObservedObject var watchList = WatchListViewModel()
    @Environment(\.openURL) var openURL

    @State var Add: Bool
//    @State private var showToast: Bool = false
    
    @Binding var HomeAdd: Bool
    @Binding var showToast: Bool
    @Binding var Name: String 
    
    var movie: Card
    var type: String
    var width: CGFloat
    
    init(HomeAdd:Binding<Bool>,Name:Binding<String>, showToast:Binding<Bool>,movie:Card, type:String, width:CGFloat ){
        self._HomeAdd = HomeAdd
        self._showToast = showToast
        self.movie = movie
        self.type = type
        self.width = width
        self._Name = Name
        
        if(UserDefaults.standard.object(forKey: String(self.movie.id)) != nil){
            
            _Add = State(initialValue:true)
          
        
        }else{
            _Add = State(initialValue:false)
            
        }
        
    }
    
    
    var body: some View {
     
        NavigationLink(destination: DetailView(id:String(movie.id),type: self.type)) {
            VStack{
                RemoteImage(url: movie.poster_path)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(width:self.width)
//                KFImage(URL(string: movie.poster_path)!)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .cornerRadius(10)
//                    .frame(width:self.width)
                Text(movie.title)
                    .font(.system(size:14, weight: .bold, design: .default))
                    .frame(width:self.width)
                    .multilineTextAlignment(.center)
                Text("("+movie.date+")")
                    .font(.system(size:13))
                    .foregroundColor(.gray)
                
            }.contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .onAppear(perform:{
                if(UserDefaults.standard.object(forKey: String(self.movie.id)) != nil){
                    
                    self.Add = true
                
                }else{
                    self.Add = false
                }
            })
            .contextMenu{
                Button {action:do {
                    if (!self.showToast) {
                        self.Add.toggle()
                        self.Name = movie.title

                        withAnimation {
                            self.showToast = true
                        }
                        if (self.Add == true){
                            self.HomeAdd = self.Add
                            watchList.addToWatchList(id: movie.id, type: type, poster_path: movie.poster_path)
                            UserDefaults.standard.set([type,movie.poster_path],forKey: String(movie.id))
                        }else{
                            self.HomeAdd = self.Add
                            watchList.removeFromWatchList(id: movie.id, type: type, poster_path: movie.poster_path)
                            UserDefaults.standard.removeObject(forKey: String(movie.id))
                        }
                        
                    }
                }
                } label: {
                    HStack{
                        Text(self.Add ?"Remove from watchList" : "Add to watchList")
                        Image(systemName: self.Add ?"bookmark.fill":"bookmark")
                            .toast(isPresented: self.$showToast) {
                                HStack {
                                    Text("\(self.Add ? " was added to Wachkist" : " was removed from WatchList")")
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)

                                } //HStack
                            } //toast
                    }
                    
                }

                Button {openURL(URL(string: "https://www.facebook.com/sharer/sharer.php?u=https://www.themoviedb.org/\(self.type)/\(movie.id)")!)
                } label: {
                    HStack{
                        Text("Share on Facebook")
                        Image("facebook-app-symbol")
                    }

                }
                
                Button {openURL(URL(string: "http://twitter.com/intent/tweet?text=Check%20out%20this%20link%3A%20&url=https%3A%2F%2Fwww.themoviedb.org%2F\(self.type)%2F\(movie.id)&hashtags=CSCI571USCFilms")!)
                } label: {
                    HStack{
                        Text("Share on Twitter")
                        Image("twitter")
                    }
                }
            }
            
        }.buttonStyle(PlainButtonStyle())

    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(movie: Card, type: "movie", width: 0)
//    }
//}
