//
//  HomeViewModel.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/19.
//

import Foundation
import Alamofire
import SwiftyJSON

class HomeViewModel: ObservableObject {
    
    
    @Published var topRatedMovie = [Card]()
    @Published var PopularMovie = [Card]()
    @Published var topRatedTv = [Card]()
    @Published var PopularTv = [Card]()
    @Published var NowPlayingMovie = [Carousel]()
    @Published var TrendingTv = [Carousel]()
    
    

    var baseURL = " http://localhost:8080/"
    
    
    
    
    func getCurPlayingMovie() {
        
        AF.request(baseURL+"cur_playing_mv",encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                var cnt = 0
                for i in json{
                    if(cnt < 5){
                        self.NowPlayingMovie.append(Carousel(id: i.1["id"].intValue,title:i.1["title"].stringValue, poster_path:i.1["poster_path"].stringValue))
                    }
                        
                    cnt += 1
                }
              
            case .failure(let error):
                print(error)
            }
            
        }
    }
//        guard let url = URL(string:  baseURL+"cur_playing_mv") else {return}
//
//        URLSession.shared.dataTask(with: url) {data, res, error in
//            do{
//                if let data = data {
//                    let result = try JSONDecoder().decode([Carousel].self, from:data)
//                    DispatchQueue.main.async {
//                        self.NowPlayingMovie = result
//
//                    }
//                }
//                else{
//                    print("No data")
//                }
//            } catch (let error) {
//                print(error.localizedDescription)
//            }
//            completion()
//        }.resume()
//    }
    
    
    func getTrendingTV() {
        
        AF.request(baseURL+"trending_tv",encoding:JSONEncoding.default).responseData {(data) in
            
            switch data.result{
            case .success(let value):
                let json = JSON(value)
                var cnt = 0
                for i in json{
                    if(cnt < 5){
                        self.TrendingTv.append(Carousel(id: i.1["id"].intValue,title:i.1["title"].stringValue, poster_path:i.1["poster_path"].stringValue))
                    }
                        
                    cnt += 1
                }
              
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func getTopRated_Movie() {

        guard let url = URL(string: baseURL+"top_rated_mv") else {return}

        URLSession.shared.dataTask(with: url) {data, res, error in
            do{
                if let data = data {
                    let result = try JSONDecoder().decode([Card].self, from:data)
                    DispatchQueue.main.async {
                        self.topRatedMovie = result
                        

                    }
                }
                else{
                    print("No data")
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    func getPopular_Movie() {
        guard let url = URL(string: baseURL+"pop_mv") else {return}
        
        URLSession.shared.dataTask(with: url) {data, res, error in
            do{
                if let data = data {
                    let result = try JSONDecoder().decode([Card].self, from:data)
                    DispatchQueue.main.async {
                        self.PopularMovie = result
                     
                    }
                }
                else{
                    print("No data")
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    func getTopRated_Tv() {
        guard let url = URL(string: baseURL+"top_rated_tv") else {return}
        
        URLSession.shared.dataTask(with: url) {data, res, error in
            do{
                if let data = data {
                    let result = try JSONDecoder().decode([Card].self, from:data)
                    DispatchQueue.main.async {
                        self.topRatedTv = result
                    
                    }
                }
                else{
                    print("No data")
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getPopular_Tv() {
        guard let url = URL(string: baseURL+"pop_tv") else {return}
        
        URLSession.shared.dataTask(with: url) {data, res, error in
            do{
                if let data = data {
                    let result = try JSONDecoder().decode([Card].self, from:data)
                    DispatchQueue.main.async {
                        self.PopularTv = result
             
                    }
                }
                else{
                    print("No data")
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    
    
    
}
