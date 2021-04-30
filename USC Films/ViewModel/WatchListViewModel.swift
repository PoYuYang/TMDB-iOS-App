//
//  WatchListViewModel.swift
//  USC Films
//
//  Created by 楊博宇 on 2021/4/23.
//

import Foundation
import SwiftyJSON
class WatchListViewModel: ObservableObject{
    
    @Published var storage = [Storage]()
    @Published var curCard :Storage?
    

    
    func getWatchListData(){
        //        clean the USerDefaults data
        
        
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()
        
//        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)



        if let savedData = UserDefaults.standard.object(forKey: "watchList") as? Data {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode([Storage].self, from: savedData) {
                self.storage = loadedData

            }
        }

        
    }
    
    
    func addToWatchList(id:Int, type:String, poster_path:String){
        //        create new data
        let newData = Storage(id: String(id), type: type, poster_path: poster_path)

        //        if no watchList, put new data for the value
        if UserDefaults.standard.object(forKey: "watchList") == nil {
            self.storage.append(newData)
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.storage) {
                
                UserDefaults.standard.set(encoded, forKey: "watchList")
                
            }
        }
        //        else retrieve old data and concat with new data
        else{

            if let savedData = UserDefaults.standard.object(forKey: "watchList") as? Data {
                let decoder = JSONDecoder()
                if let loadedData = try? decoder.decode([Storage].self, from: savedData) {
                    self.storage = loadedData
                    self.storage.append(newData)
         
                }
            }
            //        encode again
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.storage) {

                UserDefaults.standard.set(encoded, forKey: "watchList")
            }
        }
    }
    
    func removeFromWatchList(id:Int, type:String, poster_path:String){
        
        if let savedData = UserDefaults.standard.object(forKey: "watchList") as? Data {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode([Storage].self, from: savedData) {
                
                var newWatchList = [Storage]()
                for data in loadedData {
                   
                    if data.id != String(id) {
                        newWatchList.append(data)

                    }
                }
                self.storage = newWatchList
            }
        }
        
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.storage) {

            UserDefaults.standard.set(encoded, forKey: "watchList")
        }
        
        
    }

    


}



