//
//  NetworkController.swift
//  Movies
//
//  Created by curs on 1/2/19.
//  Copyright © 2019 curs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkController {
    
    static var itunesUrl = "https://itunes.apple.com/us/rss/topmovies/limit=30/json"
    
    class func getUrlWithOffset(offset: Int, url: String) -> String {
        let limit = offset + 30
        let offsetUrl = url.replacingOccurrences(of: "30", with: String(limit))
        return offsetUrl
    }
    
    class func getTopMovies(offset: Int,
                            completion: @escaping ([Movie]) -> (),
                            onError: @escaping () -> ()) {
        
        let url = getUrlWithOffset(offset: offset, url: itunesUrl)
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let entries = json["feed"]["entry"].arrayValue
                var movies = [Movie]()
                
                for i in offset ..< entries.count {
                    let movieJson = entries[i]
                    let movie = Movie(json: movieJson)
                    movies.append(movie)
                }
                
                completion(movies)
                
            case .failure(let error):
                print(error)
                onError()
            }
        }
    }
}
