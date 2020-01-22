//
//  Movie.swift
//  Movies
//
//  Created by curs on 1/2/19.
//  Copyright © 2019 curs. All rights reserved.
//

import SwiftyJSON

class Movie {
    
    var title: String?
    var image: String?
    var price: String?
    var director: String?
    var duration: String?
    var summary: String?
    var releaseDate: String?
    var category: String?
    
    init(json: JSON) {
        // Coger una imagen con más resolución que la que nos da la api
        let imageAux = json["im:image"][2]["label"].stringValue
        self.image = imageAux.replacingOccurrences(of: "113x170", with: "300x300")
    
        self.summary = json["summary"]["label"].stringValue
        self.price = json["im:price"]["label"].stringValue
        self.duration = json["link"][1]["im:duration"]["label"].stringValue
        self.director = json["im:artist"]["label"].stringValue
        self.category = json["category"]["attributes"]["label"].stringValue
        self.releaseDate = json["im:releaseDate"]["attributes"]["label"].stringValue
        self.title = json["title"]["label"].stringValue
    }
}
