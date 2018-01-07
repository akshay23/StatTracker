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

final class Team: ALSwiftyJSONAble {
    
    let name: String?
    let location: String?
    let founded: Int?
    let conference: String?
    let division: String?
    let logoURL: String?
    
    required init?(jsonData: JSON) {
        self.name = jsonData["name"].string
        self.location = jsonData["location"].string
        self.founded = jsonData["founded"].int
        self.conference = jsonData["conference"].string
        self.division = jsonData["division"].string
        self.logoURL = jsonData["logoURL"].string
    }
}
