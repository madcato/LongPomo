//
//  SimplePersistence.swift
//  OSFramework
//
//  Created by Daniel Vela on 06/02/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

/**
 Simple persistence class to store and read simple data
 as Strings, Bools and Ints
 **Suitable to store Settings**

 To store Any object implement NSCoding protocol as:
````
class SerializableWebQuery: NSObject, NSCoding {
    var url: String

    init(url: String) {
        self.url = url
    }

    required init?(coder aDecoder: NSCoder) {
        self.url = aDecoder.decodeObject(forKey: "url") as! String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.url, forKey: "url")
    }

    func start(onOk: (), onError: ()) {

    }
}
 ````
*/
public class SimplePersistence {
    /// Persistance provider, by default uses **UserDefaultsSimpleProvider** it can
    /// be changed
    public static var provider: SimplePersistence = {
        return UserDefaultsSimpleProvider()
    }()
    /**
     Store a Double
     - Parameter value: Double value to store
     - Parameter key: Key associated to the store location to recover the stored value
    */
    public static func store(_ value: Double,
                             forKey key: String) {
        provider.store(value: value, forKey: key)
    }
    /**
     Blank method used to define the protocol of the function to override by the
     concrete descendant. Don't use it directly.
     - Parameter value: Double value to store
     - Parameter key: Key associated to the store location to recover the stored value
     */
    func store(value: Double, forKey key: String) {
    }
    /**
     Recover a Double previously persisted
     - Parameter key: Key associated to the store location to recover the stored value
     - Returns: The previously stored Double value
    */
    public static func double(forKey key: String) -> Double {
        return provider.double(forKey: key)
    }
    /**
     Blank method used to define the protocol of the function to override by the
     concrete descendant. Don't use it directly.
     - Parameter key: Key associated to the store location to recover the stored value
     - Returns: The previously stored Double value
     */
    func double(forKey key: String) -> Double {
        return 0
    }
}

/**
 Simple class for storing data in UserDefaults on iOS
*/
class UserDefaultsSimpleProvider: SimplePersistence {
    /**
     Store a Double
     - Parameter value: Double value to store
     - Parameter key: Key associated to the store location to recover the stored value
    */
    override func store(value: Double,
                        forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    /**
     Recover a Double previously persisted
     - Parameter key: Key associated to the store location to recover the stored value
     - Returns: The previously stored Double value
    */
    override func double(forKey key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
}
