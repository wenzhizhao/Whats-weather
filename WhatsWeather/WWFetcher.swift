//
//  WWFetcher.swift
//  WhatsWeather
//
//  Created by Wenzhi Zhao on 8/13/18.
//  Copyright © 2018 Wenzhi Zhao. All rights reserved.
//

import Foundation


class WWFetcher: NSObject {
    typealias SuccessClosure = (Data) -> Void
    typealias FailureClosure = (Error) -> Void
    
    var url: URL?
    init(_ url: URL?) {
        self.url = url
    }
    func fetchWeather( _ sucess: @escaping SuccessClosure, _ failure: @escaping FailureClosure) {
        guard let requst = self.createRequest() else {
            return
        }
        let session = URLSession.shared
        session.dataTask(with: requst) { (result, response, error) in
            if let error = error {
                print(error.localizedDescription)
                failure(error)
            }
            if let data = result {
                sucess(data)
            }
        }.resume()
    }
    
    fileprivate func createRequest() -> URLRequest?  {
        guard let url = self.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = WWConstants.httpMethodGet
        return request
    }
    
}
