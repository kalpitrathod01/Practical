//
//  ModelBaseClass.swift
//
//  Created by Kalpit Rathod on 26/09/22.
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class ModelBaseClass: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kModelBaseClassDataKey: String = "data"
	internal let kModelBaseClassMessageKey: String = "message"
	internal let kModelBaseClassSuccessKey: String = "success"


    // MARK: Properties
	public var data: [ModelData]?
	public var message: String?
	public var success: Bool = false



    // MARK: ObjectMapper Initalizers
    /**
        Map a JSON object to this class using ObjectMapper
        - parameter map: A mapping from ObjectMapper
    */
    required convenience init?(map: Map) {
        self.init()
    }


    /**
        Map a JSON object to this class using ObjectMapper
        - parameter map: A mapping from ObjectMapper
    */
    func mapping(map: Map) {
		data <- map[kModelBaseClassDataKey]
		message <- map[kModelBaseClassMessageKey]
		success <- map[kModelBaseClassSuccessKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
        if (data?.count ?? 0) > 0 {
			var temp: [AnyObject] = []
			for item in data! {
				temp.append(item.dictionaryRepresentation() as AnyObject)
			}
			dictionary.updateValue(temp as AnyObject, forKey: kModelBaseClassDataKey)
		}
		if message != nil {
			dictionary.updateValue(message! as AnyObject, forKey: kModelBaseClassMessageKey)
		}
		dictionary.updateValue(success as AnyObject, forKey: kModelBaseClassSuccessKey)

        return dictionary
    }

}
