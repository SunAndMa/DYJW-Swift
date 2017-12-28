//
//  ModelUtil.swift
//  DYJW
//
//  Created by 国投 on 2016/12/8.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit
import RealmSwift

public let DBPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("/DB/")

extension Realm {
    
    static func getDB() throws -> Realm {
        let dbPath = DBPath.appending("db.realm")
        do {
            return try Realm(fileURL: URL(fileURLWithPath: dbPath))
        } catch {
            throw error
        }
    }
    
    static func setup() throws {
        try? FileManager.default.createDirectory(atPath: DBPath, withIntermediateDirectories: true, attributes: nil)
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 0, migrationBlock: { (migration, oldSchemaVersion) in
            
        })
    }
    
}
