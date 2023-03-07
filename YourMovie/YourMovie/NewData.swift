//
//  NewData.swift
//  YourMovie
//
//  Created by Kripa Lamichhane on 3/6/23.
//

import Foundation
import UIKit

struct MovieReview: Codable {
    let original_title : String
    let overview: String
    let poster_path: String
    let popularity: Int
    let release_date: String
    let vote_average: Int
    let vote_count: Int
    
    
}
