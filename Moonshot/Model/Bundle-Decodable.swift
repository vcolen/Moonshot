//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Victor Colen on 11/12/21.
//

import Foundation
import SwiftUI

extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T{
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in Bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Couldn't load \(file) from Bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-DD"
        
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode data from \(file)")
        }
        
        return loaded
    }
}
