//
//  Car.swift
//  ArabamAssignment
//
//  Created by Batuhan Baran on 28.01.2021.
//

import Foundation


struct CarModel: Decodable{

    var id: Int
    var title: String
    var location: Location
    var priceFormatted: String
    var dateFormatted: String
    var photo: String
    
}


struct CarDetail: Decodable{

    var title: String
    var location: Location
    var modelName: String
    var priceFormatted: String
    var dateFormatted: String
    var photos: [String]
    var properties: [Properties]
    var userInfo: User
}

struct Location: Decodable{
    
    var cityName: String
    var townName: String
}

struct Category: Decodable{
    
    var id: Int
    var name: String
}

struct Properties: Decodable{
    
    var name: String
    var value: String
}

struct User: Decodable{
    
    var nameSurname: String
    var phone: String
}
