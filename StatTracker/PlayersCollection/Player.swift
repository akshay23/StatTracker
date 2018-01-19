//
//  Player.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/19/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import Foundation
import Moya_SwiftyJSONMapper
import SwiftyJSON

struct Player: ALSwiftyJSONAble, Equatable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let position: String
    let age: Int
    let jerseyNumber: Int
    let yearsPro: Int
    let teamID: Int
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.firstName == rhs.firstName
            && lhs.lastName == rhs.lastName
            && lhs.id == rhs.id
    }
    
    init?(jsonData: JSON) {
        self.id = jsonData["id"].intValue
        self.firstName = jsonData["firstName"].stringValue
        self.lastName = jsonData["lastName"].stringValue
        self.position = jsonData["position"].stringValue
        self.age = jsonData["age"].intValue
        self.jerseyNumber = jsonData["jerseyNumber"].intValue
        self.yearsPro = jsonData["yearsPro"].intValue
        self.teamID = jsonData["team_id"].intValue
    }
}
