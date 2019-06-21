//
//  Result.swift
//  RoboHash
//
//  Created by Saveliy Leontyev on 21/06/2019.
//  Copyright © 2019 Saveliy Leontyev. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}
