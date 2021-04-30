//
//  CarouselView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/15.
//

import SwiftUI
import Kingfisher
import Combine

struct CarouselView<Content:View> : View {
    private var numberOfImages: Int
    private var content: Content
//    var title:String
    @State private var currentIndex: Int = 0

    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
       self.numberOfImages = numberOfImages
       self.content = content()
    }

    var body: some View {
        
        GeometryReader { geometry in
            HStack(spacing: 0) {
                   self.content
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
            .animation(.spring())
            .onReceive(self.timer) { _ in

               self.currentIndex = (self.currentIndex + 1) % 5
            }
        }
    }
}


//struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView(numberOfImages: 0, content: CarouselImageView(movies:[]))
//    }
//}
