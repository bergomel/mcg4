//
//  teste bibloteca.swift
//  mcg 2
//
//  Created by Bernardo on 05/06/24.
//

import SwiftUI

struct teste_bibloteca: View {
    @ObservedObject var medicacaoExemplo = Droga(Substancia: "Noradrenalina", Dose: 16, Volume: 250, Velocidade: 10, Maximo: 2, Minimo: 0.01)
    
    var body: some View {
        Text("Mínimo: "+String(medicacaoExemplo.Minimo))
        Text("Maximo: "+String(medicacaoExemplo.Maximo))
        
        TextField("Velocidade", value: $medicacaoExemplo.Velocidade, formatter: NumberFormatter())
        
        Text(String(medicacaoExemplo.calcular_infusao(Peso: 75)))
            .contentTransition(.numericText(value: Double(medicacaoExemplo.Velocidade)))
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: Double(medicacaoExemplo.Velocidade))
    }
}

#Preview {
    teste_bibloteca()
}
