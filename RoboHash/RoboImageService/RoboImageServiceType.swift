//
//  RoboImageServiceType.swift
//  RoboHash
//

import UIKit

protocol RoboImageServiceType {
    func roboImage(name: String, callbackQueue: DispatchQueue, completion: @escaping (Result<UIImage>) -> ())
}
