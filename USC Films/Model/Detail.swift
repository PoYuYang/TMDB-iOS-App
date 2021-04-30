//
//  Detail.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/16.
//

import Foundation
import SwiftyJSON
struct DetailData: Codable, Identifiable {
    
    let id: Int
    let release_date:String
    let title: String
    let overview:String
    let vote_average:Double

    
}

//struct VideoData: Codable {
//    let type: String
//    let key: String
//
//}

struct ReviewData:Codable {
    let author: String
    let content:String
    let created_at:String
    let rating: Double
    
}


struct CastData:Codable {
    let name:String
    let profile_path:String
}

struct Genres:Codable {
    let gen:String
}
