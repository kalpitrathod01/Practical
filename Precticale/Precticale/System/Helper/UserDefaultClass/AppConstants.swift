//
//  API.swift
//  SmartSchoolAdmin
//
//  Created by Dataready 16 on 24/11/17.
//  Copyright © 2017 Dataready. All rights reserved.
//

import Foundation
import UIKit


//Default Declared Keys
extension DefaultsKeys {
    static let LoginResult = DefaultsKey<[String]?>("LoginResult")
    
    static func defaultFCMKeyMaker(key:String) -> DefaultsKey<Int>{
        return DefaultsKey<Int>(key)
    }
}
