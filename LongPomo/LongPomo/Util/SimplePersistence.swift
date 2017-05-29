//
//  SimplePersistence.swift
//  OSFramework
//
//  Created by Daniel Vela on 06/02/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

// To store Any object implement NSCoding protocol as:

//    class SerializableWebQuery: NSObject, NSCoding {
//        var url: String
//
//        init(url: String) {
//            self.url = url
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            self.url = aDecoder.decodeObject(forKey: "url") as! String
//        }
//
//        func encode(with aCoder: NSCoder) {
//            aCoder.encode(self.url, forKey: "url")
//        }
//
//        func start(onOk: (), onError: ()) {
//
//        }
//    }

// Simple persistence class to store and read simple data
// as Strings, Bools and Ints
// Suitable to store Settings
public class SimplePersistence {
    public static var provider: SimplePersistence = {
        return UserDefaultsSimpleProvider()
    }()

    public static func store(_ value: Double,
                             forKey key: String) {
        provider.store(value: value, forKey: key)
    }

    func store(value: Double, forKey key: String) {
    }

    public static func double(forKey key: String) -> Double {
        return provider.double(forKey: key)
    }

    func double(forKey key: String) -> Double {
        return 0
    }
}

// Simple class for storing data in UserDefaults on iOS
class UserDefaultsSimpleProvider: SimplePersistence {
    override func store(value: Double,
                        forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    override func double(forKey key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
}
