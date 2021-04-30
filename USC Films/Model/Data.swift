//
//  Data.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/12.
//

import Foundation


struct Card: Codable, Identifiable {
    let id: Int
    let title: String
    let poster_path: String
    let date: String
}


struct Carousel: Codable, Identifiable {
    let id: Int
    let title: String
    let poster_path: String

}

struct SearchRes:Codable, Identifiable {
    let id: Int
    let date: String
    let name: String
    let media_type: String
    let vote_average: Double
    let backdrop_path: String
}

struct Storage: Codable, Identifiable {
    let id: String
    let type: String
    let poster_path: String

}
