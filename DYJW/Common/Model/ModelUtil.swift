//
//  ModelUtil.swift
//  DYJW
//
//  Created by 国投 on 2016/12/8.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit
import CoreData

class ModelUtil: NSObject {
    
    fileprivate static let app = UIApplication.shared.delegate as! AppDelegate
    
    public class func insert<T: NSManagedObject>(_ handler: (T) -> Void) -> Bool {
        let className = NSStringFromClass(T.self)
        guard let model = NSEntityDescription.insertNewObject(forEntityName: className, into: app.managedObjectContext) as? T else {
            return false
        }
        handler(model)
        do {
            try app.managedObjectContext.save()
        } catch let error as NSError {
            print(error)
        }
        return false
    }
    
    public class func query<T: NSManagedObject>(_ modelClass: T.Type, condition: String = "") -> [T]? {
        let className = NSStringFromClass(modelClass)
        let request = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: className, in: app.managedObjectContext)
        request.entity = entity
        let models = (try? app.managedObjectContext.fetch(request)) as? [T]
        return models
    }
    
    public class func delete<T: NSManagedObject>(_ model: T) {
        let className = NSStringFromClass(T.self)
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: className)
        let condition = "name='周杰伦'"
        let predicate = NSPredicate(format: condition, "")
        request.predicate = predicate
        do{
            //查询满足条件的联系人
            let resultsList = try app.managedObjectContext.fetch(request) as! [User] as NSArray
            if resultsList.count != 0 { //若结果为多条，则只删除第一条，可根据你的需要做改动
                app.managedObjectContext.delete(resultsList[0] as! NSManagedObject)
                try app.managedObjectContext.save()
                print("delete success ~ ~")
            }else{
                print("删除失败！ 没有符合条件的联系人！")
            }
        }catch{
            print("delete fail !")
        }
    }
}
