//
//  Student.swift
//  SwiftyCompanion
//
//  Created by jdavin on 24/01/2019.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class Cursus: Codable {
    var grade: String?
    var level: Float?
}

class Student: Codable {
    var id: Int?
    var login: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var phone: String?
    var picture: String?
    var cursus: [Cursus]?
    
    enum CodingKeys: String, CodingKey {
        case id, login, email, phone
        case firstName = "first_name"
        case lastName = "last_name"
        case picture = "image_url"
        case cursus = "cursus_users"
    }
}
