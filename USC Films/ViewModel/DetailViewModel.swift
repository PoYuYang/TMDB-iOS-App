//
//  DetailViewModel.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/16.
//

import Foundation
import Alamofire
import SwiftyJSON

class DetailViewModel:ObservableObject{
    @Published var detail = [DetailData]()
    @Published var title = String()
    @Published var casts = [CastData]()
    @Published var reviews = [ReviewData]()
    @Published var movies = [Card]()
    @Published var recommends = [Card]()
    @Published var vid = String()
    @Published var genres = String()
    @Published var poster_path = String()
    

    var baseURL = " http://127.0.0.1:8080/"
    

    func getMovieDetail(id:String) {
        self.detail = [DetailData]()
        self.genres = String()
        self.title = String()
        AF.request(baseURL+"mv_detail/"+id,encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                for i in json{
                 
                    self.detail.append(DetailData(id: i.1["id"].intValue,
                                                  release_date: i.1["release_date"].stringValue, title:i.1["title"].stringValue, overview:i.1["overview"].stringValue, vote_average: i.1["vote_average"].doubleValue))
                    self.title.append(i.1["title"].stringValue)
                    self.poster_path.append(i.1["poster_path"].stringValue)
                    for j in i.1["genres"]{
                        if(Int(j.0) == Int(i.1["genres"].count)-1 ){
                            self.genres += j.1.stringValue
                        }else{
                            self.genres += j.1.stringValue + ","
                        }
                    }
                    
                }
            case .failure(let error):
                print(error)
                
            }
     
        }
        
    }
    
    
    
    func getMovieReview(id:String,completion: @escaping() -> Void) {
        self.reviews = [ReviewData]()
        AF.request(baseURL+"mv_review/"+id,encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                var cnt = 0
                for i in json{
                    if(cnt < 3){
                        self.reviews.append(ReviewData(author: i.1["author"].stringValue,content:i.1["content"].stringValue, created_at:i.1["created_at"].stringValue, rating:i.1["rating"].doubleValue))
                    }
                    cnt += 1
                }
            case .failure(let error):
                print(error)
            }
         
            completion()
        }

    }
    
    
    func getMovieCast(id:String) {
        self.casts = [CastData]()
        
        AF.request(baseURL+"mv_cast/"+id,encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                var cnt = 0
                for i in json{
                    if(cnt < 10){
                        self.casts.append(CastData(name: i.1["name"].stringValue,profile_path:i.1["profile_path"].stringValue))
                    }
                    cnt += 1
                }
            case .failure(let error):
                print(error)
                
            }
        }

    }
    
    
    func getMovieVid(id:String, completion: @escaping() ->Void) {
        self.vid = String()
        AF.request(baseURL+"mv_vid/"+id,encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                if(json.count == 0){
                    return
                }
                print(id)
                var cnt = 0
                for i in json{
                    if(cnt < 1){
                        
                        self.vid.append(i.1["key"].stringValue)
                    }
                    cnt += 1
                }
                
                
            case .failure(let error):
                print(error)
                break
            }
            completion()
        }

//        guard let url = URL(string: baseURL+"mv_vid/"+id) else {return}
//
//        URLSession.shared.dataTask(with: url) {data, res, error in
//            do{
//                if let data = data {
//                    let result = try JSONDecoder().decode([Card].self, from:data)
//                    DispatchQueue.main.async {
//                        self.movies = result
//                    }
//                }
//                else{
//                    print("No data")
//                }
//            } catch (let error) {
//                print(error.localizedDescription)
//            }
//        }.resume()
    }
    
    func getRecommendMovie(id:String) {
        self.recommends = [Card]()
        AF.request(baseURL+"recommend_mv/"+id,encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                for i in json{
                    
                    self.recommends.append(Card(id: i.1["id"].intValue,
                                                  title:i.1["title"].stringValue, poster_path:i.1["poster_path"].stringValue, date: i.1["date"].stringValue))
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    
    
//Tv Part
    
    
    
    
    
    func getTvDetail(id:String) {
        self.detail = [DetailData]()
        self.genres = String()
        self.title = String()
        AF.request(baseURL+"tv_detail/"+id,encoding:JSONEncoding.default).responseData {(data) in
            switch data.result{
            case .success(let value):
                let json = JSON(value)
               
                for i in json{
                    
                    self.detail.append(DetailData(id: i.1["id"].intValue,
                                                  release_date: i.1["release_date"].stringValue, title:i.1["title"].stringValue, overview:i.1["overview"].stringValue, vote_average: i.1["vote_average"].doubleValue))
                    self.title.append(i.1["title"].stringValue)
                    self.poster_path.append(i.1["poster_path"].stringValue)
                    for j in i.1["genres"]{
                        if(Int(j.0) == Int(i.1["genres"].count)-1 ){
                            self.genres += j.1.stringValue
                        }else{
                            self.genres += j.1.stringValue + ","
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
            
        }

    }
    
    
    
    func getTvReview(id:String, completion: @escaping() -> Void) {
        self.reviews = [ReviewData]()
        AF.request(baseURL+"tv_review/"+id,encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                var cnt = 0
                for i in json{
                    if(cnt < 3){
                        self.reviews.append(ReviewData(author: i.1["author"].stringValue,content:i.1["content"].stringValue, created_at:i.1["created_at"].stringValue, rating:i.1["rating"].doubleValue))
                    }
                    cnt += 1
                }
            case .failure(let error):
                print(error)
            }
            completion()
        }

    }
    
    
    func getTvCast(id:String) {
        
        self.casts = [CastData]()
        AF.request(baseURL+"tv_cast/"+id,encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                var cnt = 0
                for i in json{
                    if(cnt < 10){
                        self.casts.append(CastData(name: i.1["name"].stringValue,profile_path:i.1["profile_path"].stringValue))
                    }
                    cnt += 1
                }
            case .failure(let error):
                print(error)
            }
        }

    }
    
    
    
    func getTvVid(id:String,completion: @escaping() -> Void) {
        self.vid = String()
        AF.request(baseURL+"tv_vid/"+id,encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                if(json.count == 0){
                    return
                }
                var cnt = 0
                for i in json{
                    if(cnt < 1){
                        self.vid.append(i.1["key"].stringValue)
                    }
                    cnt += 1
                }
                
            case .failure(let error):
                print(error)
                break
            }
            completion()
        }
    }
    
    func getRecommendTv(id:String) {
        self.recommends = [Card]()
        AF.request(baseURL+"recommend_tv/"+id,encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                for i in json{
                    
                    self.recommends.append(Card(id: i.1["id"].intValue,
                                                  title:i.1["title"].stringValue, poster_path:i.1["poster_path"].stringValue, date: i.1["date"].stringValue))
                }
                
            case .failure(let error):
                print(error)
            }
           
        }

    }
    
    
}

