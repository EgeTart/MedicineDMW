//
//  MedicineController.swift
//  DWM
//
//  Created by MacBook on 9/26/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit

class MedicineController: UIViewController {
    
    @IBOutlet weak var medicineTableView: UITableView!
    
    var parentType = ""
    var medicineTypeID = ""
    var medicineCategory = 1
    
    var fiveLevelMedicine = [Dictionary<String, String!>]()
    
    let db = MedicineDB.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        medicineTableView.tableFooterView = UIView()
     
        
        getFifthLevelMedicine()
        
        print(medicineTypeID)

    }

    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        
    }

}


extension MedicineController: UITableViewDataSource {

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiveLevelMedicine.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("medicineCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = fiveLevelMedicine[indexPath.row]["name"]
        cell.detailTextLabel!.text = parentType
        
        return cell
    }
    
    func getFifthLevelMedicine() {
        
        db.open()
        
        var tableName = "west_medicine"
        if (medicineCategory == 2) {
            tableName = "chinese_medicine"
        }
        
        let results = db.executeQuery("select id, name from \(tableName) where medicine_type_id=\(medicineTypeID)", withArgumentsInArray: nil)
      
        while(results.next()) {
            
            let id = results.stringForColumn("id")
            let name = results.stringForColumn("name")
            let medicine = ["id": id, "name": name]
            fiveLevelMedicine.append(medicine)
        }
        db.close()
    }
    
}

extension MedicineController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("detail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! DetailController
        destinationVC.medicineCategory = medicineCategory
        destinationVC.medicineID = fiveLevelMedicine[medicineTableView.indexPathForSelectedRow!.row]["id"]!
    }
}