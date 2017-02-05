//
//  WebService.swift
//  Dependinator
//
//  Created by Rod Schmidt on 2/3/17.
//  Copyright © 2017 infiniteNIL. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class WebService {

    func getDate(completionHandler: @escaping (Result<Date>) -> Void) {
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            Thread.sleep(forTimeInterval: 5)
            DispatchQueue.main.async {
                let date = Date()
                completionHandler(.success(date))
            }
        }
    }

}
