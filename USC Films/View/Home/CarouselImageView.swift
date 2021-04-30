//
//  CarouselImageView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/19.
//

import SwiftUI
import Kingfisher


struct CarouselImageView: View {
 
    var movie:String
    var id: Int
    var type: String
    var width: CGFloat
    var height:CGFloat
    
    init(id:Int, movie:String, type:String, width:CGFloat, height:CGFloat){
        self.id = id
        self.movie = movie
        self.type = type
        self.width = width
        self.height = height
    }
    
    var body: some View {

        NavigationLink(destination: DetailView(id:String(self.id),type:self.type)) {

            ZStack{
                
                KFImage(URL(string: self.movie)!)
                    .resizable()
                    .blur(radius: 30)
                    .frame(width:self.width,height:self.height)

            
                KFImage(URL(string: self.movie)!)
                    .resizable()
                    .scaledToFit()
                    .frame(width:self.width/1.5,height:self.height)
                    .clipped()
            }

        }
    }
}

//struct CarouselImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselImageView(movie: )
//    }
//}
