//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Victor Colen on 11/12/21.
//

import Foundation
import SwiftUI

extension Bundle {
    
    func decode(_ file: String) -> [String: Astonaut] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in Bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Couldn't load \(file) from Bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode([String: Astonaut].self, from: data) else {
            fatalError("Failed to decode data from \(file)")
        }
        
        return loaded
    }
}
