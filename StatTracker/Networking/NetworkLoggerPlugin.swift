//
//  NetworkLoggerPlugin.swift
//  AnimotoKit
//
//  Created by Akshay Bharath on 8/17/17.
//  Copyright © 2017 Animoto Inc. All rights reserved.
//

import AnimotoKit
import Moya
import Result

struct NetworkLoggerPlugin: PluginType {

    func willSend(_ request: RequestType, target: TargetType) {
        ANLog.verbose("Sending request: \(request.request?.url?.absoluteString ?? String()), Method: \(request.request?.httpMethod ?? "UNKNOWN")")
    }
    
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            if 200..<400 ~= (response.statusCode ) {
                ANLog.verbose("Received response (\(response.statusCode )) from \(response.response?.url?.absoluteString ?? "unknown request").")
            } else {
                ANLog.error("Received response (\(response.statusCode )) from \(response.response?.url?.absoluteString ?? "unknown request").")
            }
        case .failure(let error):
            ANLog.error("Received networking error: \(error)")
        }
    }
}
