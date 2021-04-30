//
//  HomeView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/13.
//

import SwiftUI
import Kingfisher



struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    @ObservedObject var toastViewModel: ToastViewModel = ToastViewModel()
    
    @State private var isMovie = true
    @State private var show = true
    
    @State var HomeAdd: Bool = true
    @State var showToast: Bool = false
    @State var Name: String = ""

    init(){

        viewModel.getCurPlayingMovie()
        viewModel.getTopRated_Movie()
        viewModel.getPopular_Movie()
        viewModel.getTrendingTV()
        viewModel.getPopular_Tv()
        viewModel.getTopRated_Tv()
    }

  
    var body: some View {
        
        if (self.viewModel.NowPlayingMovie.count == 0) {
            ProgressView("Fetching Data")
                .onAppear(perform:{
                    viewModel.getCurPlayingMovie()
                    viewModel.getTopRated_Movie()
                    viewModel.getPopular_Movie()
                })

        }

        else{
            NavigationView {
                if isMovie{
                    GeometryReader { g in
                        ScrollView{
                            VStack{
                                VStack(alignment:.leading){
                                    Text("Now Playing")
                                        .font(.system(.title, design: .rounded))
                                        .fontWeight(.bold).padding()
                                    GeometryReader { geometry in
                                        CarouselView(numberOfImages: viewModel.NowPlayingMovie.count) {
                                            ForEach(viewModel.NowPlayingMovie, id: \.title){ movie in
                                                CarouselImageView(id:movie.id, movie:movie.poster_path, type: "movie", width: geometry.size.width , height:geometry.size.height)
                                            }
                                        }
                                    }.frame(height:300, alignment: .center)
                             
                                }
                                
                                VStack(alignment:.leading){
                                    Text("Top Rated")
                                        .fontWeight(.bold).padding()
                                        .font(.system(.title, design: .rounded))
                                        GeometryReader { g in
                                            ScrollView(.horizontal, showsIndicators: true){
                                                HStack(alignment:.top, spacing:20){
                                                        ForEach(viewModel.topRatedMovie, id: \.id){ movie in
                                                            CardView(HomeAdd:$HomeAdd,Name:$Name,showToast:$showToast, movie: movie, type: "movie", width: g.size.width/3.7)
                                                        }
                                                    }.padding(20)
                                                }
                                        }
//                                        HorizontalScrollView(movies: viewModel.topRatedMovie, title: "Top Rated", type: "movie")
                                }.frame(height:g.size.height/1.8)
                                

                                
                                VStack(alignment:.leading){
                                    Text("Popular")
                                        .fontWeight(.bold).padding()
                                        .font(.system(.title, design: .rounded))
                                        GeometryReader { g in
                                            ScrollView(.horizontal, showsIndicators: true){
                                                HStack(alignment:.top, spacing:20){
                                                        ForEach(viewModel.PopularMovie, id: \.id){ movie in
                                                            CardView(HomeAdd:$HomeAdd,Name:$Name,showToast:$showToast,movie: movie, type: "movie", width: g.size.width/3.7)
                                                        }
                                                    }.padding(20)
                                                }
                                        }
//                                        HorizontalScrollView(movies: viewModel.PopularMovie, title: "Popular", type: "movie")
                                    
                                }.frame(height:g.size.height/1.8)

                                FooterView()
                            }
                            }
                            .navigationBarTitle("USC Films")
                            .navigationBarItems(
                                trailing: Button(action: { isMovie = false}, label: {
                                        Text("TV shows")
                                      })
                            )
                            .toast(isPresented: self.$showToast) {
                                HStack {
                                    Text("\(Name)\(self.HomeAdd ? " was added to Wachkist" : " was removed from WatchList")")
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)

                                } //HStack
                            } //toast
                        
                    }
                }
 
                else{
                    GeometryReader { g in
                        ScrollView{
                            VStack{
                                VStack(alignment:.leading){
                                    Text("Trending")
                                        .font(.system(.title, design: .rounded))
                                        .fontWeight(.bold).padding()
                                    GeometryReader { geometry in
                                        CarouselView(numberOfImages: viewModel.NowPlayingMovie.count) {
                                            ForEach(viewModel.TrendingTv, id: \.title){tv in
                                                CarouselImageView(id:tv.id, movie:tv.poster_path, type: "tv", width: geometry.size.width, height:geometry.size.height)
                                            }

                                        }
                                    }.frame(height: 300, alignment: .center)
                                }
                            
                                VStack(alignment:.leading){
                                    Text("Top Rated")
                                        .fontWeight(.bold).padding()
                                        .font(.system(.title, design: .rounded))
                                        GeometryReader { g in
                                            ScrollView(.horizontal, showsIndicators: true){
                                                HStack(alignment:.top, spacing:20){
                                                        ForEach(viewModel.topRatedTv, id: \.id){ movie in
                                                            CardView(HomeAdd:$HomeAdd,Name:$Name,showToast:$showToast,movie: movie, type: "tv", width: g.size.width/3.7)
                                                        }
                                                    }.padding(20)
                                                }
                                        }

//                                        HorizontalScrollView(movies: viewModel.topRatedTv, title: "Top Rated", type: "tv")
                                }.frame(height:g.size.height/1.8)

                                
                                
                                VStack(alignment:.leading){
                                        Text("Popular")
                                            .fontWeight(.bold).padding()
                                            .font(.system(.title, design: .rounded))
                                            GeometryReader { g in
                                                ScrollView(.horizontal, showsIndicators: true){
                                                    HStack(alignment:.top, spacing:20){
                                                            ForEach(viewModel.PopularTv, id: \.id){ movie in
                                                                CardView(HomeAdd:$HomeAdd,Name:$Name,showToast:$showToast,movie: movie, type: "tv", width: g.size.width/3.7)
                                                            }
                                                        }.padding(20)
                                                    }
                                            }
//                                        HorizontalScrollView(movies: viewModel.PopularTv, title: "Popular",type:"tv")
                                }.frame(height:g.size.height/1.8)

                                FooterView()
                            }
                            }
                            .navigationBarTitle("USC Films")
                            .navigationBarItems(
                                trailing: Button(action: { isMovie = true}, label: {
                                        Text("Movies")
                                      })
                            )
                            .toast(isPresented: self.$showToast) {
                                HStack {
                                    Text("\(Name)\(self.HomeAdd ? " was added to Wachkist" : " was removed from WatchList")")
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)

                                } //HStack
                            } //toast
                    }
                }
            }
        }
        }
   
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
