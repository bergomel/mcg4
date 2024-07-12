//
//  JSON_Manager.swift
//  teste_json
//
//  Created by Bernardo on 23/07/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let example = try? JSONDecoder().decode(Example.self, from: jsonData)

import Foundation


struct Solucao: Codable {
    let id: Int
    let droga: String
    let dose, volume, min, max: Double
    
    
    
    func calcular_diluicao() -> Double {
        return dose/volume
    }
    
    static let todasSolucoes: [Solucao] = Bundle.main.decode(file: "soluções.json")
    static let exemploSolucao: Solucao = todasSolucoes[0]
}

extension Bundle{
    func decode<T: Decodable>(file: String) -> T{
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in the project")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file)")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file)")
        }
        
        return loadedData
    }
}
