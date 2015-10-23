//
//  MedicineType.swift
//  DWM
//
//  Created by MacBook on 10/7/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import Foundation

struct Medicines {
    var sencondLevel = [String]()
    var thirdLevel = [String]()
}


class MedicineType {
    
//    let db = MedicineDB.sharedInstance()
//    
//    db.open()
//    
//    let results = db.executeQuery("select * from chinese_medicine limit 3 offset 1", withArgumentsInArray: nil)
//    
//    
//    while results.next() {
//    
//    let annouce = results.stringForColumn("annouce")
//    print(annouce)
//    }
    
    var toperLevel = [String]()
    var lowerLevel = [String]()
    
    var mordenMedicine, tradictionMedicine: Medicines!
    let db = MedicineDB.sharedInstance()
    
    init() {
        
        mordenMedicine = Medicines()
        tradictionMedicine = Medicines()
        
        db.open()
        
        var secondLevel = db.executeQuery("select * from medicine_type where parent_type_id=1", withArgumentsInArray: nil)
        
        while secondLevel.next() {
            let id = secondLevel.stringForColumn("id")
            let name = secondLevel.stringForColumn("name")
            mordenMedicine.sencondLevel.append(name)
            
            let thirdLevel = db.executeQuery("select * from medicine_type where parent_type_id=\(id)", withArgumentsInArray: nil)
            
            while thirdLevel.next() {
                let name = thirdLevel.stringForColumn("name")
                mordenMedicine.thirdLevel.append(name)
            }
        }
        
        secondLevel = db.executeQuery("select * from medicine_type where parent_type_id=12", withArgumentsInArray: nil)
        
        while secondLevel.next() {
            let id = secondLevel.stringForColumn("id")
            let name = secondLevel.stringForColumn("name")
            tradictionMedicine.sencondLevel.append(name)
            
            let thirdLevel = db.executeQuery("select * from medicine_type where parent_type_id=\(id)", withArgumentsInArray: nil)
            
            while thirdLevel.next() {
                let name = thirdLevel.stringForColumn("name")
                tradictionMedicine.thirdLevel.append(name)
            }
        }
        db.close()
    }

}
