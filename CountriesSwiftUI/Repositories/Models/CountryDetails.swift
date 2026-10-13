//
//  CountryDetails.swift
//  CountriesSwiftUI
//
//  Created by Alexey on 7/11/24.
//  Copyright © 2024 Alexey Naumov. All rights reserved.
//

import SwiftData

// MARK: - Database Model

extension DBModel {

    @Model final class CountryDetails {
        @Attribute(.unique) var alpha3Code: String
        var capital: String
        var currencies: [Currency]
        var neighbors: [Country]?

        init(alpha3Code: String, capital: String, currencies: [Currency], neighbors: [Country]) {
            self.alpha3Code = alpha3Code
            self.capital = capital
            self.currencies = currencies
            self.neighbors = neighbors
        }
    }
}

// MARK: - Web API Model

extension ApiModel {
    struct CountryDetails: Codable, Equatable {
        let capital: String?
        let currencies: [Currency]
        let borders: [String]?

        enum CodingKeys: String, CodingKey {
            case capital, currencies, borders
        }
    }
}

extension ApiModel.CountryDetails {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        capital = try container.decodeIfPresent(String.self, forKey: .capital)
        currencies = try container.decodeIfPresent([ApiModel.Currency].self, forKey: .currencies) ?? []
        borders = try container.decodeIfPresent([String].self, forKey: .borders)
    }
}
