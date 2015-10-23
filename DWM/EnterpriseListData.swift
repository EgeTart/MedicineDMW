//
//  EnterpriseListData.swift
//  DWM
//
//  Created by 高永效 on 15/10/23.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import Foundation
import Alamofire

class EnterpriseListData {
    
    var enterprises = [Dictionary<String, AnyObject>]()
    var enterpriseType: String!
    
    init (enterpriseType: String) {
        self.enterpriseType = enterpriseType
        //getEnterprises()
    }
    
    func getEnterprises(completion completion: () -> Void) {
        
        let currentPage = enterprises.count / 15 + 1
        
        let params = ["currentPage": "\(currentPage)", "size": "15", "type": "\(enterpriseType)", "Cookie":"JSESSIONID=\(session)"]
        
        Alamofire.request(.POST, "http://112.74.131.194:8080/MedicineProject/App/user/getEnterprise", parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (_, _, result) -> Void in
            let enterprisesResult = result.value!["Enterprises"]! as! [Dictionary<String, AnyObject>]
            
            for enterprise in enterprisesResult {
                self.enterprises.append(enterprise)
            }
            completion()
        }
    }
    
}
