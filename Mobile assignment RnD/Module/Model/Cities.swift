//
//  CitiesList.swift
//  Mobile assignment RnD
//
//  Created by Hazem Maher on 8/6/18.
//  Copyright © 2018 Hazem Maher. All rights reserved.
//

import Foundation

struct Cities: Codable {
    
    var cities: [City]
}

struct City: Codable {
    
    var country: String
    var name: String
    var _id: Int
    var coord: Coord
    
    private enum CodingKeys: CodingKey {
        case name
        case country
        case _id
        case coord
    }

}

struct Coord: Codable {
    
    var lon: Double
    var lat: Double
}

class CitiesList {
    
    var cities: [City] = [City]()
    var trie = Trie()
    var isTrieSearch: Bool = false
    
    func fetchData() -> [City]? {
        cities = self.loadJson(filename: "cities")!
        cities = sortAlphapitically()
        fillTrie()
        return cities
    }
    
    func fillTrie() {
        for city in cities {
            trie.insert(word: city.name + " , " + city.country)
        }
    }
    
    func searchTri(letters: String) -> [String] {
        isTrieSearch = true
        return trie.findWordsWithPrefix(prefix: letters)
    }
    
    private func sortAlphapitically() -> [City]{
        let result = cities.sorted {
            if $0.name != $1.name {
                
               return $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending
            } else {
               return $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending && $0.country.localizedCaseInsensitiveCompare($1.country) == ComparisonResult.orderedAscending
            }
            
        }
        return result
    }
    
    private func loadJson(filename fileName: String) -> [City]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Array<City>.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        
        return nil
    }
    
    func searchCities(letters: String) -> [City] {
        
        let res = cities.filter {
            $0.name.hasPrefix(letters)
        }
        return res
    }
}
