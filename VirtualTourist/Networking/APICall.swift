//
//  APICall.swift
//  VirtualTourist
//
//  Created by manar Aldossari on 09/06/1440 AH.
//  Copyright © 1440 MacBook Pro. All rights reserved.
//

import Foundation
import Alamofire
class APICall{
    let pp = "  https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=6f749b93294e708fdd725225f63d3e60&lat=52.5095347703273&lon=-7.470703125000001&per_page=30&page=1&format=json&auth_token=72157706664296255-7289448134a8857e&api_sig=7eb7c8875bd0d25e9d895eb4229ed85f"
    
    
    static func getPhotosId(latitude:Double , longitude: Double){
        let parameters: [String:String] = [
            "method" : "flickr.photos.search",
            "api_key": "83fbf19cb959bb776caf46f18efe0174",
            "lat": "\(latitude)",
            "lon": "\(longitude)",
            "format": "json",
            "per_page": "10",
            "page": "1"
        ]
        
        Alamofire.request(URL(string: "https://api.flickr.com/services/rest/")!, method: .get, parameters: parameters).response { (response) in
            print( String(data: response.data!, encoding: .utf8))
            let decoder = JSONDecoder()
            do{
            let photosArray = try decoder.decode( FlicerPhoto.self, from: response.data!)
                print(photosArray)
            }catch{
               print(error)
            }
            
        }
        
    
        
    }
}


struct FlicerPhoto: Codable{
    let  photos:PhotosInfo?
}
        
struct PhotosInfos: Codable{
    let photo : [PhotosInfo]?
}

struct PhotosInfo: Codable{
    let id:String?
    let secret:String?
    let server:String?
    let title:String?
}

