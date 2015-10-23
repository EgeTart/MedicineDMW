//
//  MedicineLevel.swift
//  DWM
//
//  Created by 高永效 on 15/10/11.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import Foundation

class MedicineLevel {
    
    var subTypes = [Dictionary<String, String!>]()
    
    let db = MedicineDB.sharedInstance()
    
    init(parentTypeID: String) {
        getLevelData(parentTypeID)
    }
    
    func getLevelData(parentTypeID: String) {
        db.open()
        
        subTypes.removeAll()
        
        let results = db.executeQuery("select id, name from medicine_type where parent_type_id=\(parentTypeID)", withArgumentsInArray: nil)
        
        while (results.next()) {
            
            let id = results.stringForColumn("id")
            let name = results.stringForColumn("name")
            
            let medicine = ["id": id, "name": name]
            
            subTypes.append(medicine)
        }
        
        db.close()
    }
}


// 1: morden  12: tradiction
//class MedicineLevelData {
//    
//    let medicinesLevel: MedicineLevel
//    var subMedicinesLevel = [MedicineLevel]()
//    
//    init(parentTypeID: String) {
//        
//        medicinesLevel = MedicineLevel(parentTypeID: parentTypeID)
//        
//        for topLevel in medicinesLevel.subTypes {
//            
//            let subLevel = MedicineLevel(parentTypeID: topLevel["id"]!)
//            subMedicinesLevel.append(subLevel)
//        }
//    }
//}

