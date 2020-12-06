//
//  PersonWS.swift
//  InputConConstraints
//
//  Created by Dominique Verellen on 12/2/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation


typealias Persons = (_ arrayPersons: [Person]) -> Void

class PersonWS {
    
    class func getPersonByUserId(_ personId: String, success: @escaping Person, error: @escaping ErrorMessage) {
        
        CSWebServiceManager.shared.request.getRequest(urlString: WebServicesURL.getProfileByUserId(personId), parameters: nil) { (response) in
            
            if let personws = response.JSON?.array.first, response.errorCode == 200 {
                success(PersonBE(json: personws))
            }else{
                error(StatusCodeBE.getErrorMessageByStatusCode(response.errorCode))
            }
        }
    }
    
    
    class func getPersonByPersonId(_ personId: String, success: @escaping Person, error: @escaping ErrorMessage) {
        
        CSWebServiceManager.shared.request.getRequest(urlString: WebServicesURL.getProfileByPersonId(personId), parameters: nil) { (response) in
            
            if let personws = response.JSON?.array.first, response.errorCode == 200 {
                success(PersonBE(json: personws))
            }else{
                error(StatusCodeBE.getErrorMessageByStatusCode(response.errorCode))
            }
        }
    }
    
}
