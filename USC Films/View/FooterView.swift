//
//  FooterView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/17.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        VStack(alignment:.center){
            Link("Powered by TMDB", destination: URL(string: "https://www.themoviedb.org/")!)
                .font(.system(size: 12)).foregroundColor(.gray)
            
            Text("Developed by Po Yu Yang").font(.system(size: 12)).foregroundColor(.gray)
        }
        
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
