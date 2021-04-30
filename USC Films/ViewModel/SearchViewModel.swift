//
//  SearchViewModel.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/21.
//

import Foundation
import Alamofire
import SwiftyJSON



class SearchViewModel:ObservableObject{
    @Published var results = [SearchRes]()
    @Published var NoResult = false

    var baseURL = "https://hw-8-backend.wl.r.appspot.com/apis/"
    //    var baseURL = " http://127.0.0.1:8080/"


    func getSearchResult(name:String) {
        self.results = [SearchRes]()
        self.NoResult = false
        let originalString = name
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        AF.request(baseURL+"multi_search/"+escapedString!,encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                for i in json{
                    self.results.append(SearchRes(id: i.1["id"].intValue,
                                                  date: i.1["date"].stringValue, name:i.1["name"].stringValue, media_type:i.1["media_type"].stringValue, vote_average: i.1["vote_average"].doubleValue, backdrop_path: i.1["backdrop_path"].stringValue))
                    
                   
                    
                }
                if (self.results.count == 0){
                    self.NoResult = true
                }
            case .failure(let error):
                print(error)
                
            }
           
        }
        
    }
}
