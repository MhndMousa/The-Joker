//
//  Joke.swift
//  The Joker
//
//  Created by Muhannad Alnemer on 12/29/19.
//  Copyright © 2019 Muhannad Alnemer. All rights reserved.
//

import Foundation
struct Joke:Decodable {
     let id : String?
     let joke : String
     let status : Int?
}
