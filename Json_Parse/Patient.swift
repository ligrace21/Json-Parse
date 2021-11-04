//
//  Patient.swift
//  Json_Parse
//
//  Created by user on 10/7/21.
//

import Foundation

struct Patient {
    let givenName: String
    let familyName: String
    let gender: String
    let birthDate: String
    let lastUpdated: String
}

extension Patient {
    init(from entry: Entry) {
        givenName = entry.resource.name[0].given[0]
        familyName = entry.resource.name[0].family
        gender = entry.resource.gender.rawValue
        birthDate = entry.resource.birthDate ?? "Unknown"
        lastUpdated = entry.resource.meta.lastUpdated
    }
}



// MARK: - PatientDataService
struct PatientDataService: Decodable {
    let entry: [Entry]
}

// MARK: - Entry
struct Entry: Decodable {
    let fullURL: String
    let resource: Resource
    let search: Search

    enum CodingKeys: String, CodingKey {
        case fullURL = "fullUrl"
        case resource, search
    }
}

// MARK: - Resource
struct Resource: Decodable {
    let resourceType: ResourceType
    let id: String
    let meta: ResourceMeta
    let text: Text
    let identifier: [Identifier]
    let name: [Name]
    let gender: Gender
    let birthDate: String?
    let deceasedDateTime: String?
}

enum Gender: String, Decodable {
    case female = "female"
    case male = "male"
    case unknown = "unknown"
}

// MARK: - Identifier
struct Identifier: Decodable {
    let use: Use?
    let system: System
    let value: String
}

enum System: String, Decodable {
    case myHospital = "MyHospital"
    case urnOID1220817612 = "urn:oid:1.2.208.176.1.2"
}

enum Use: String, Decodable {
    case official = "official"
}

// MARK: - ResourceMeta
struct ResourceMeta: Decodable {
    let versionID, lastUpdated, source: String

    enum CodingKeys: String, CodingKey {
        case versionID = "versionId"
        case lastUpdated, source
    }
}

// MARK: - Name
struct Name: Decodable {
    let use: Use
    let family: String
    let given: [String]
}

enum ResourceType: String, Decodable {
    case patient = "Patient"
}

// MARK: - Text
struct Text: Decodable {
    let status: Status
    let div: String
}

enum Status: String, Decodable {
    case generated = "generated"
}

// MARK: - Search
struct Search: Decodable {
    let mode: Mode
}

enum Mode: String, Decodable {
    case match = "match"
}
