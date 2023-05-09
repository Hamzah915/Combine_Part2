//
//  PlanetsModel.swift
//  CombineSwiftUI
//
//  Created by Hamzah Azam on 05/05/2023.
//

import Foundation

struct Planetinfo:Decodable{
    let results:[Planets]
    
}

struct Planets:Decodable {
    
    let name:String
    let climate: String
    let rotation_period, orbital_period, diameter: String
}

extension Planets:Identifiable{
    var id: UUID{UUID()}
}
