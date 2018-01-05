//
//  StatTrackerProvider.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/5/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import AnimotoKit
import Moya
import Reachability
import RxSwift
import SwiftyJSON

class StatTrackerProvider {
    
    // Make a request to Animoto backend
    // Check network connectivity before making request
    static func request(withEndpoint endpoint: StatTrackerAPI) -> Single<Response> {
        return Reachability.rx.reachable
            .filter { $0 != false }  // Only proceed if we're online
            .take(1)  // Take 1 to make sure we only invoke the API once
            .flatMap { _ in
                shared.rx.request(endpoint)  // Execute request
            }
            .asSingle()
    }
    
    static func fetchTeams() -> Single<JSON> {
        let endpoint = StatTrackerAPI.teams
        return request(withEndpoint: endpoint)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .flatMap { response in
                return Single.just(JSON(response))
            }
    }
}

private extension StatTrackerProvider {
    // Init network logger
    static let networkLoggerPlugin = NetworkLoggerPlugin()
    
    // The various plugins for requests
    static var plugins: [PluginType] {
        return [networkLoggerPlugin]
    }
    
    // Add headers to each request
    static func endpointClosure(_ endpoint: StatTrackerAPI) -> Endpoint<StatTrackerAPI> {
        let request = MoyaProvider.defaultEndpointMapping(for: endpoint)
        return request.adding(newHTTPHeaderFields: endpoint.headers ?? [:])
    }
    
    // Shared instance
    static var shared: MoyaProvider<StatTrackerAPI> = MoyaProvider<StatTrackerAPI>(endpointClosure: endpointClosure, plugins: plugins)
}
