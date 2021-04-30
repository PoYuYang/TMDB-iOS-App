//
//  ReviewView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/21.
//

import SwiftUI

struct ReviewView: View {
    @ObservedObject var viewModel = DetailViewModel()
    var title: String
    var author: String
    var date: String
    var rate: Double
    var content: String
//    var id: String
//    var type: String
    
    init(title:String, author:String, date:String, rate:Double, content:String){
        self.title = title
        self.author = author
        self.date = date
        self.rate = rate
        self.content = content

    }
    
    var body: some View {
        ScrollView {
            HStack{
                VStack(alignment:.leading){
                    Text(self.title).font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.bottom,5)
                    Text("By \(self.author) on \(self.date)")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                        .padding(.bottom,5)
                    HStack{
                        Image(systemName: "star.fill")
                            .foregroundColor(.red)
                        Text("\(String(format:"%.1f",(self.rate/2)))/5.0")
//                            .foregroundColor(.black)
                    }.padding(.bottom,5)
                    
                    Text(self.content)
//                        .foregroundColor(.black)
                
                    Spacer()
                }
                .padding(.top,10)
                .padding(.horizontal, 10)
                
                Spacer()
            }
       
            
        }

        
        
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(title:"",author:"",date:"",rate: 0, content:"")
    }
}
