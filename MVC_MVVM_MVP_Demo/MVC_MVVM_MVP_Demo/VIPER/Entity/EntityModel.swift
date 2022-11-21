//
//  EntityModel.swift
//  MVC_MVVM_MVP_Demo
//

//

import Foundation

struct EntityTouristListModel: Codable {
    let page, perPage, totalrecord, totalPages: Int?
    let data: [EntityTourist]?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalrecord
        case totalPages = "total_pages"
        case data
    }
}

// MARK: - Tourist data
struct EntityTourist: Codable {
    let id: Int?
    let touristName, touristEmail: String?
    let touristProfilepicture: String?
    let touristLocation: String?
    let createdat: String?

    enum CodingKeys: String, CodingKey {
        case id
        case touristName = "tourist_name"
        case touristEmail = "tourist_email"
        case touristProfilepicture = "tourist_profilepicture"
        case touristLocation = "tourist_location"
        case createdat
    }
}
