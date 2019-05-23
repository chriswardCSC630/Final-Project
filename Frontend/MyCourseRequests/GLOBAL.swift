//
//  GLOBAL.swift
//  MyCourseRequests
//
//  Created by Eric on 5/22/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation

class GLOBAL {
    // from https://stackoverflow.com/questions/26804066/does-swift-have-class-level-static-variables
    static let BASE_API = "http://localhost:8000/"
    static var HAS_LOADED = true // change this flag if you want to wipe the database and reset it
}
