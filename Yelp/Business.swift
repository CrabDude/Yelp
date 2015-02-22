//
//  Business.swift
//  Yelp
//
//  Created by Adam Crabtree on 2/17/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import Foundation

enum Keys: String {
    case ThumbImageUrl = "image_url"
    case Name = "name"
    case RatingImageUrl = "rating_img_url"
    case ReviewCount = "review_count"
    case Location = "location"
    case Addresses = "address"
    case Neighborhoods = "neighborhoods"
    case Categories = "categories"
    case Distance = "distance"
}

class Business: NSObject {
    
    var thumbImageUrl: NSURL?
    var name: String?
    var ratingImageUrl: NSURL?
    var reviewCount: Int?
    var address: String?
    var categories: String?
    var distance: Float?

    override init() {
        super.init()
    }
    
    convenience init(data: NSDictionary) {
        self.init()
        
        let json = JSON(data)
        
        self.thumbImageUrl = NSURL(string: json["image_url"].string ?? "")
        self.name = json["name"].string!
        self.ratingImageUrl = NSURL(string: json["rating_img_url"].string!)
        self.reviewCount = json["review_count"].int
        println(json)
        self.distance = json["distance"].float!
        
        let categoryList = json["categories"].arrayObject!
        var categoryNames: [String] = []
        for category in categoryList {
            categoryNames.append((category as! [String])[0])
        }
        self.categories = ", ".join(categoryNames)
        
        let street = json["location"]["address"][0].string
        self.address = street ?? ""
        if let neighborhood = json["location"]["neighborhoods"][0].string {
            self.address = self.address!+", \(neighborhood)"
        }
        
    }
    
    class func initWithBusinesses(data: [NSDictionary]) -> [Business] {
        var businesses: [Business] = []
        for business in data {
            businesses.append(Business(data: business))
        }
        return businesses
    }
}


struct BusinessData {
    let thumbImageUrl: String
    let name: String
    let ratingImageUrl: String
    let reviewCount: Int
    let location: BusinessLocation
    let categories: [[String]]
    let distance: Float
}

struct BusinessLocation {
    var addresses: [String]
    var neighborhoods: [String]
}