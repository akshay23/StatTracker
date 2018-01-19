//
//  StatTrackerAPI.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/5/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import AnimotoKit
import Moya

public enum StatTrackerAPI {
    case teams
    case players(teamId: Int)
}

extension StatTrackerAPI: TargetType {
    public var baseURL: URL {
        let base = "http://localhost:8080"
        //let base = "https://nameless-fortress-69681.herokuapp.com"
        return URL(string: base)!
    }
    
    public var path: String {
        switch self {
        case .teams:
            return "/api/teams"
            
        case let .players(teamId):
            return "/api/teams/\(teamId)/players"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .teams,
             .players:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .teams,
             .players:
            return .requestPlain
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
