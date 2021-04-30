//
//  DropViewDelegate.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/25.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    var pic: Storage
    var picData: WatchListViewModel
    
    func performDrop(info: DropInfo) -> Bool{
        return true
    }
//    When User Dragged Into New Card
    func dropEntered(info: DropInfo) {
//        Getting from And to Index...
        
//        From Index...
        let fromIndex = picData.storage.firstIndex { (pic) -> Bool in
            return pic.id == picData.curCard?.id
        } ?? 0
//        To Index...
        let toIndex = picData.storage.firstIndex { (pic) -> Bool in
            return pic.id == self.pic.id
        } ?? 0
        
//        Safe Check if Both are the same...
        if fromIndex != toIndex{
            withAnimation(.default){
//                Swapping data...
                let fromPic = picData.storage[fromIndex]
                picData.storage[fromIndex] = picData.storage[toIndex]
                picData.storage[toIndex] = fromPic
            
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(picData.storage) {

                    UserDefaults.standard.set(encoded, forKey: "watchList")
                }

            }

        }
        print(pic.poster_path)
    }
    
    

    
//    setting Action as Move
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
}


