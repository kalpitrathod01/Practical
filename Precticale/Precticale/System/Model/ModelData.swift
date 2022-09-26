//
//  ModelData.swift
//
//  Created by Kalpit Rathod on 26/09/22.
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class ModelData: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kModelDataInternalIdentifierKey: String = "_id"
	internal let kModelDataImageUrlKey: String = "image_url"
	internal let kModelDataTimeKey: String = "time"
	internal let kModelDataNameKey: String = "name"


    // MARK: Properties
	public var internalIdentifier: String?
	public var imageUrl: String?
	public var time: String?
	public var name: String?



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
		internalIdentifier <- map[kModelDataInternalIdentifierKey]
		imageUrl <- map[kModelDataImageUrlKey]
		time <- map[kModelDataTimeKey]
		name <- map[kModelDataNameKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier! as AnyObject, forKey: kModelDataInternalIdentifierKey)
		}
		if imageUrl != nil {
			dictionary.updateValue(imageUrl! as AnyObject, forKey: kModelDataImageUrlKey)
		}
		if time != nil {
			dictionary.updateValue(time! as AnyObject, forKey: kModelDataTimeKey)
		}
		if name != nil {
			dictionary.updateValue(name! as AnyObject, forKey: kModelDataNameKey)
		}

        return dictionary
    }

}
