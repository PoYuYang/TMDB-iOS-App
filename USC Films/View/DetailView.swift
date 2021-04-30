//
//  DetailView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/16.
//

import SwiftUI
import Kingfisher
import youtube_ios_player_helper





struct DetailView: View {
    
    @ObservedObject var viewModel = DetailViewModel()
    @ObservedObject var watchList = WatchListViewModel()
    
    @Environment(\.openURL) var openURL
    @State private var isExpanded: Bool = false
    @State private var isExpandedReview: Bool = false
    @State private var show: Bool = false
    @State var Add: Bool
    @State private var showToast: Bool = false
    
    let playerView = YTPlayerView()
    var id: String
    var type: String = "movie"
    
    
    init(id:String, type:String){
    
        self.id = id
        self.type = type

        if(UserDefaults.standard.object(forKey: String(self.id)) != nil){
            
            _Add = State(initialValue:true)
            
        }else{
            _Add = State(initialValue:false)
        }
        
    }
    

    var body: some View {
        if (self.show == false) {
            ProgressView("Fetching Data")
                .onAppear(perform:{
                    
                    if (self.type == "movie"){
                        
                        viewModel.getMovieVid(id: id ,completion: {
                            viewModel.getMovieReview(id: id, completion: {
                                self.show.toggle()
                            })
                        })
                            
                        viewModel.getMovieDetail(id: id)
                        viewModel.getMovieCast(id: id)
                        viewModel.getRecommendMovie(id: id)
                    }
                    else{
                        viewModel.getTvVid(id: id, completion: {
                            viewModel.getTvReview(id: id, completion: {
                                self.show.toggle()
                            })
  
                        })
                        viewModel.getTvDetail(id: id)
                        viewModel.getTvCast(id: id)
                        viewModel.getRecommendTv(id: id)
                    }
                })

        }
        else{
            GeometryReader { g in
            ScrollView(.vertical){
                
                VStack{
                    if(viewModel.vid.count != 0 && viewModel.vid != "/tzkWB85ULJY"){
                        YouTubeWrapper(vidID: viewModel.vid)
                            .padding()
                            .frame(height:g.size.height/2.5)

                    }else{
                        Image("backdrop_path_placeholder")
                            .resizable()
                            .frame(height:g.size.height/2.5)
                            .padding()

                    }
                    HStack{
                        VStack(alignment:.leading){
                            ForEach(viewModel.detail, id: \.id){ d in
                                Text(d.title).font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom,10)
                                Text("\(d.release_date) | \(viewModel.genres)")
                                    .padding(.bottom,5)

                                HStack{
                                    Image(systemName: "star.fill").foregroundColor(.red)
                                    Text("\(String(format:"%.1f",(d.vote_average/2)))/5.0")
                                }.padding(.bottom,5)
                                Text(d.overview)
                                    .padding(.bottom,20)
                                    .lineLimit(isExpanded ? nil : 3)
                                                .overlay(
                                                    GeometryReader { proxy in
                                                        Button(action: {
                                                            isExpanded.toggle()
                                                        }) {Spacer()
                                                            Text(isExpanded ? "Show less" : "Show more..")
                                                                .font(.caption).bold()

                                                                .foregroundColor(.gray)

                                                        }
                                                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomTrailing)
                                                    }
                                                )
                            }
                        }.padding()
                        Spacer()
                    }

    
                    if(viewModel.casts.count>0){
                        VStack(alignment:.leading) {
                            Text("Cast & Crew")
                                .font(.system(.title, design: .rounded))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding()
                            GeometryReader { g in
                                ScrollView(.horizontal, showsIndicators: true){
                                    HStack(spacing:3){
                                        ForEach(viewModel.casts, id: \.name) { cast in
                                            VStack{
                                                KFImage(URL(string:cast.profile_path)!)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .clipShape(Circle())
                                                    .shadow(radius: 10)
                                                    .padding(.horizontal)
                                                Text(cast.name)
                                                    .font(.system(size: 14, design: .rounded))
                                                    
                                            }
                                        }
                                    }
                                }
                            }
                        }.frame(height:250)
                       
                    }
                    
                    if(viewModel.reviews.count>0){
                        VStack(alignment:.leading) {
                            Text("Reviews")
                                .font(.system(.title, design: .rounded))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding()
                            GeometryReader { g in
                                VStack{
                                    ForEach(viewModel.reviews, id: \.author) { review in
                                        VStack(alignment:.leading){
                                            
                                                ZStack{
                                                   
                                                    
                                                    HStack{
                                                        VStack(alignment:.leading){

                                                                Text("A review by \(review.author)")
                                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)


                                                                Text("Written by \(review.author) on \(review.created_at)")
                                                                    .font(.system(size: 14))
                                                                    .foregroundColor(.gray)

                                                                HStack{
                                                                    Image(systemName: "star.fill")
                                                                        .foregroundColor(.red)
                                                                    Text("\(String(format:"%.1f",(review.rating/2)))/5.0")

                                                                }

                                                                Text(review.content)
                                                                    .lineLimit(isExpanded ? nil : 3)



                                                        }.padding(.horizontal,18)
                                                        Spacer()
                                                    }
                                                    NavigationLink(destination: ReviewView(title: viewModel.title, author: review.author, date: review.created_at, rate:review.rating, content: review.content)) {
                                                        RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1)
//                                                            .fill(Color.clear)
                                                            .frame(width:g.size.width/1.05, height: 160)
                                                            .padding(.horizontal,10)
                                                            .padding(.vertical,5)
                                                    }

                                                }
                                            }
                                        
                                    }
                                }

                            }.frame(height: CGFloat(viewModel.reviews.count) * 180)

                        }
                    }

                    if(viewModel.recommends.count>0){
                        VStack(alignment:.leading){
                            RecommendHorizontalView(movies:viewModel.recommends , title: "Recommended Movies", type: self.type)
                        }
                        .frame(height:300)
                        
                    }
                    
                }
                
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                            Text("")
                        }
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        
                        HStack{
               
                            Button(action: {
                                if (!self.showToast) {
                                    self.Add.toggle()

                                    withAnimation {
                                        self.showToast = true
                                    }
                                    
                                    if (self.Add == true){
                                        watchList.addToWatchList(id: Int(id)!, type: type, poster_path: viewModel.poster_path)
                                        UserDefaults.standard.set([type,viewModel.poster_path],forKey: String(id))
                                    }else{
                                        watchList.removeFromWatchList(id: Int(id)!, type: type, poster_path: viewModel.poster_path)
                                         UserDefaults.standard.removeObject(forKey: String(id))
                                    }
                                    
                                }
                            }){

                                Image(systemName: self.Add ?"bookmark.fill":"bookmark")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(self.Add ?.blue: .black)

                                         
                                    
                            }
                            Button(action: {openURL(URL(string: "https://www.facebook.com/sharer/sharer.php?u=https://www.themoviedb.org/\(self.type)/\(id)")!)

                            }) {
                                Image("facebook-app-symbol")
                                    .resizable()
                                    .scaledToFit()
                                    
                                    
                            }
                            Button(action: {openURL(URL(string: "http://twitter.com/intent/tweet?text=Check%20out%20this%20link%3A%20&url=https%3A%2F%2Fwww.themoviedb.org%2F\(self.type)%2F\(id)&hashtags=CSCI571USCFilms")!)
                            }) {
                                Image("twitter")
                                    .resizable()
                                    .scaledToFit()

                                    
                            }
                        }
                        .frame(height:25)
                    }
                }
    //            toolbar
                
            }.toast(isPresented: self.$showToast) {
                HStack {
                    Text("\(viewModel.title)\(self.Add ? " was added to Wachkist" : " was removed from WatchList")")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                      
                } //HStack
            } //toast
            
            }
    
        }
        }
}


struct YouTubeWrapper: UIViewRepresentable {
    
    var vidID : String
    let playvarsDic = ["controls": 1, "playsinline": 1, "autohide": 1, "showinfo": 1, "autoplay": 1, "modestbranding": 1]
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: self.vidID, playerVars: self.playvarsDic)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context:Context){
        
    }
    
    
}
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: "", type: "")
    }
}


