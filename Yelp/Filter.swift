//
//  Filter.swift
//  Yelp
//
//  Created by Adam Crabtree on 2/20/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

var filterTypes = [
    Filter("Most Popular", options: [
        Option(displayName: "Deals", value: "true")
        ]),
    Filter("Sort by", selectedIndex: 0, key: "sort", options: [
        Option(displayName: "Best Match", value: "0"),
        Option(displayName: "Distance", value: "1"),
        Option(displayName: "Highest Rated", value: "2")
        ]),
    Filter("Distance", selectedIndex: 0, key: "radius_filter", options: [
        Option(displayName: "Best Match", value: "40000"),
        Option(displayName: "0.3 miles", value: "483"),
        Option(displayName: "1 mile", value: "1610"),
        Option(displayName: "5 miles", value: "8050"),
        Option(displayName: "20 miles", value: "32200")
        ]),
    Filter("Category", selectedIndex: 0, key: "category_filter", options: [
        Option(displayName: "All", value: "all"),
        Option(displayName: "Active Life", value: "active"),
        Option(displayName: "Arts & Entertainment", value: "arts"),
        Option(displayName: "Automotive", value: "auto"),
        Option(displayName: "Beauty & Spas", value: "beautysvc"),
        Option(displayName: "Education", value: "education"),
        Option(displayName: "Event Planning & Services", value: "eventservices"),
        Option(displayName: "Financial Services", value: "financialservices"),
        Option(displayName: "Food", value: "food"),
        Option(displayName: "Health & Medical", value: "health"),
        Option(displayName: "Home Services", value: "homeservices"),
        Option(displayName: "Hotels & Travel", value: "hotelstravel"),
        Option(displayName: "Local Flavor", value: "localflavor"),
        Option(displayName: "Local Services", value: "localservices"),
        Option(displayName: "Mass Media", value: "massmedia"),
        Option(displayName: "Nightlife", value: "nightlife"),
        Option(displayName: "Pets", value: "pets"),
        Option(displayName: "Professional Services", value: "professional"),
        Option(displayName: "Public Services & Government", value: "publicservicesgovt"),
        Option(displayName: "Real Estate", value: "realestate"),
        Option(displayName: "Religious Organizations", value: "religiousorgs"),
        Option(displayName: "Restaurants", value: "restaurants"),
        Option(displayName: "Shopping", value: "shopping")
        ])
]

class Filter {
    let options: [Option]
    let name: String
    var selectedIndex: Int
    var isOpen = false
    var key: String
    
    init(_ name: String, selectedIndex: Int = 0, key: String = "", options: [Option]) {
        self.name = name
        self.options = options
        self.selectedIndex = selectedIndex
        self.key = key
    }
}

class Option {
    var displayName: String
    var value: String

    init(displayName: String, value: String) {
        self.displayName = displayName
        self.value = value
    }
}