//
//  SearchResultView.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/21.
//

import SwiftUI
import Kingfisher


struct SearchResultView: View {
    @ObservedObject var viewModel:SearchViewModel
    @State var searchText = ""
    
    init(vm: SearchViewModel){
        self.viewModel = vm

    }
    
    var body: some View {
        if(self.viewModel.NoResult == true){
            VStack{
                Text("No Results")
                    .font(.system(size:24))
                    .foregroundColor(.gray)
                Spacer()
            }
        }
        else{
            ScrollView{
                GeometryReader { g in
                    VStack(alignment:.leading){
                        ForEach(self.viewModel.results, id: \.id){ res in
                            ZStack{

                                NavigationLink(destination: DetailView(id:String(res.id),type: res.media_type)){
                                    VStack(){
                                        KFImage(URL(string:res.backdrop_path)!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .cornerRadius(20)
                                            .frame(width:g.size.width*0.9, height: 190)
                                         
                                    }
                                }
                                VStack{
                                    HStack{
                                        Text(res.media_type.uppercased()+"(\(res.date))")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                        Spacer()

                                        Image(systemName: "star.fill").foregroundColor(.red)
                                        Text("\(String(format:"%.1f",(res.vote_average/2)))")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    .padding(20)
                                    Spacer()

                                    HStack{
                                        Text(res.name)
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                        Spacer()
                                    }.padding(20)

                                }
                                .padding(.horizontal)

                            }.padding(.vertical,8)
                         
                        }
                    }
                    
                    
                }.frame(height: CGFloat(self.viewModel.results.count) * 215)
            }
        }

    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(vm: SearchViewModel())
    }
}
