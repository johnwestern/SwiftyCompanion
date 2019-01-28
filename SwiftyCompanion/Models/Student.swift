//
//  Student.swift
//  SwiftyCompanion
//
//  Created by jdavin on 24/01/2019.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class Skill: Codable {
    var id: Int?
    var name: String?
    var level: Float?
}

class Cursus: Codable {
    var grade: String?
    var level: Float?
    var skills: [Skill]
}

class ProjectDetail: Codable {
    var id: Int?
    var name: String?
}

class EZProject: NSObject {
    var id: Int?
    var finalMark: Int?
    var name: String?
    var valid: Bool?
}

class Project: Codable {
    var id: Int?
    var cursusIds: [Int]?
    var finalMark: Int?
    var project: ProjectDetail?
    var validated: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, project
        case cursusIds = "cursus_ids"
        case finalMark = "final_mark"
        case validated = "validated?"
    }
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
    var wallet: Int?
    var projects: [Project]?
    
    enum CodingKeys: String, CodingKey {
        case id, login, email, phone, wallet
        case firstName = "first_name"
        case lastName = "last_name"
        case picture = "image_url"
        case cursus = "cursus_users"
        case projects = "projects_users"
    }
}
