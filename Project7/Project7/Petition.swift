//
//  Petition.swift
//  Project7
//
//  Created by Lucas Rocha on 2020-08-17.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

// the Codable protocol matches the names of the variables below against the JSON directly
struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
