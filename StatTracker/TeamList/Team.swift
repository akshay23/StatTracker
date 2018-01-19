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
    
    let id: Int
    let name: String
    let location: String
    let founded: Int
    let conference: String
    let division: String
    let logoURL: String

    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
    
    init?(jsonData: JSON) {
        self.id = jsonData["id"].intValue
        self.name = jsonData["name"].stringValue
        self.location = jsonData["location"].stringValue
        self.founded = jsonData["founded"].intValue
        self.conference = jsonData["conference"].stringValue
        self.division = jsonData["division"].stringValue
        self.logoURL = jsonData["logoURL"].stringValue
    }
}
