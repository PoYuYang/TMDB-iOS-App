//
//  ContentView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/12.
//

import SwiftUI

struct ContentView: View {

    @State private var selection = 2

    init() {
        UITabBar.appearance().barTintColor = UIColor.systemGray5
    }
    
    var body: some View {
        
        
        TabView(selection:$selection) {
            SearchView()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            
            HomeView()
                
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }.tag(2)
            
            
            WatchListView()
                .tabItem{
                    Image(systemName: "heart")
                    Text("WatchList")
                }.tag(3)
            
        }


    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
