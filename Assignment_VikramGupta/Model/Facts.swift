//
//  Country.swift
//  Assignment_VikramGupta
//
//  Created by Vikram Gupta on 7/23/20.
//  Copyright © 2020 Vikram Gupta. All rights reserved.
//

import Foundation

// Api Response Structure
struct Facts: Codable {
    let title: String?
    let rows: [Row]?
}

// MARK: - Row
struct Row: Codable {
    let title: String?
    let description: String?
    let imageHref: String?
}
