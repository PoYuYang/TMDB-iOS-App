//
//  HorizontalScroll.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/13.
//

import SwiftUI
import Kingfisher



//struct HorizontalScrollView: View {
////    @ObservedObject var viewModel = HomeViewModel()
//
////    @Environment(\.openURL) var openURL
//
////    @State private var Add: Bool = false
////    @State private var showToast: Bool = false
//
//    var movies:[Card]
//    var title:String
//    var type: String
//
//    var body: some View {
//        VStack(alignment:.leading){
//            Text("\(self.title)")
//                .fontWeight(.bold).padding()
//                .font(.system(.title, design: .rounded))
//                GeometryReader { g in
//                    ScrollView(.horizontal, showsIndicators: true){
//                        HStack(alignment:.top, spacing:20){
//                                ForEach(self.movies, id: \.id){ movie in
//                                    CardView(movie: movie, type: self.type, width: g.size.width/3.7)
//                                }
//                            }.padding(20)
//                        }
//                }
//        }
//
//    }
//}
//
//struct HorizontalScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        HorizontalScrollView(movies: [],title: "",type:"")
//    }
//}
