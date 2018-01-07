//
//  Team.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/6/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import Foundation
import Moya_SwiftyJSONMapper
import SwiftyJSON

struct Team: ALSwiftyJSONAble, Equatable {
    
    let id: Int?
    let name: String?
    let location: String?
    let founded: Int?
    let conference: String?
    let division: String?
    let logoURL: String?

    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
    
    init?(jsonData: JSON) {
        self.id = jsonData["id"].int
        self.name = jsonData["name"].string
        self.location = jsonData["location"].string
        self.founded = jsonData["founded"].int
        self.conference = jsonData["conference"].string
        self.division = jsonData["division"].string
        self.logoURL = jsonData["logoURL"].string
    }
}
