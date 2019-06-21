//
//  RoboImageService.swift
//  RoboHash
//

import Foundation
import UIKit

enum RoboImageServiceError {
    case technical

    var message: String {
        switch self {
        case .technical:
            return "Technical error"
        }
    }
}

extension RoboImageServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .technical:
            return "Technical error"
        }
    }
}

class RoboImageService {
    let baseURL = URL(string: "https://robohash.org")!
}

extension RoboImageService: RoboImageServiceType {
    func roboImage(name: String, callbackQueue: DispatchQueue = .main, completion: @escaping (Result<UIImage>) -> ()) {
        let url = baseURL.appendingPathComponent(name)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                callbackQueue.async {
                    completion(.error(error))
                }
                return
            }

            if let data = data, let image = UIImage(data: data) {
                callbackQueue.async {
                    completion(.success(image))
                }
            } else {
                callbackQueue.async {
                    completion(.error(RoboImageServiceError.technical))
                }
            }
        }
        task.resume()
    }
}
