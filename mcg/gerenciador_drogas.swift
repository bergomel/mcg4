//
//  gerenciador_drogas.swift
//  mcg
//
//  Created by Bernardo on 26/07/24.
//

import Foundation

struct Dr0ga: Identifiable, Codable {
    //    ESTÁTICOS
    var id = UUID()
    var Minimo: Double
    var Maximo: Double
    
    //    VARIÁVEIS
    var Substancia: String
    var Dose: Double
    var Volume: Double
    var Velocidade: Double
    
    //    CALCULADOS
    var Concentracao: Double {
        return Dose / Volume
    }
    
    func calcular_infusao(Peso: Double) -> Double {Velocidade / Volume * Dose / 60 * 1000 / Peso
    }
    
    func calcular_range_velocidade(Peso:Double) -> ClosedRange<Double> {
        let velocidade_min = (Minimo * Peso * 60 * Volume) / (Dose * 1000)
        let velocidade_max = (Maximo * Peso * 60 * Volume) / (Dose * 1000)
        return velocidade_min...velocidade_max
    }
}
    
    func loadJs0n(filename fileName: String) -> [Dr0ga]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Dr0ga].self, from: data)
                return jsonData
            } catch {
                print("Error loading JSON data: \(error)")
            }
        }
        return nil
    }
    
let dr0gas:[Dr0ga] = loadJs0n(filename: "soluções - cópia") ?? [Dr0ga(Minimo: 2, Maximo: 20, Substancia: "Dobutamina", Dose: 10, Volume: 250, Velocidade: 10)]

