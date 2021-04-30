//
//  WatchListView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/13.
//

import SwiftUI
import Kingfisher

struct WatchListView: View {
    
    @StateObject var WatchList = WatchListViewModel()
    
    let columns = Array(repeating: GridItem(.flexible(), spacing:20),count:3)
   

    var body: some View {
        if(WatchList.storage.count == 0){
            
            Text("Watchlist is empty")
                .font(.system(size: 25))
                .foregroundColor(.gray)
                .onAppear(perform: {
                    WatchList.getWatchListData()

                })
       
        }
        else{

            NavigationView {
                GeometryReader { g in
                    ScrollView{
                        LazyVGrid(columns: columns, spacing:5, content:{
                            ForEach(WatchList.storage, id: \.id){ card in
                                NavigationLink(destination: DetailView(id:String(card.id),type:card.type )) {
                                    VStack{
                                        KFImage(URL(string: card.poster_path))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width:g.size.width/3.2)
                                        
                                    }
                                 
                                }
//                                Drag and Drop
                                .onDrag({
                                    WatchList.curCard = card
//                                    Sending ID for sample...
                                    return NSItemProvider(contentsOf: URL(string:"\(card.id)")!)!
                                })
                                .onDrop(of: [card.poster_path],delegate: DropViewDelegate(pic:card, picData: WatchList))
                                
                                .contextMenu{
                                    Button {action:do {
                                        WatchList.removeFromWatchList(id: Int(card.id)!, type: card.type, poster_path: card.poster_path)
                                        UserDefaults.standard.removeObject(forKey: String(card.id))
                                             
                                    }
                                    } label: {
                                        HStack{
                                            Text("Remove from watchList")
                                            Image(systemName: "bookmark.fill")
                                  
                                        }
                                        
                                    }
                                }
                            }
                        })
                        .padding()
                        .onAppear(perform: {
                            WatchList.getWatchListData()
                        
                        })
                    .navigationTitle("WatchList")
                    }
                }
            }
        
        }
    }
}


struct WatchListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
