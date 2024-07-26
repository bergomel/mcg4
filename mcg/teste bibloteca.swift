//
//  teste bibloteca.swift
//  mcg 2
//
//  Created by Bernardo on 05/06/24.
//

import SwiftUI

struct teste_bibloteca: View {
    @ObservedObject var medicacaoExemplo = Droga(Substancia: "Noradrenalina", Dose: 16, Volume: 250, Velocidade: 10, Maximo: 2, Minimo: 0.01)
    @State var selectedDr0ga: Dr0ga = dr0gas.first!
    @State var selectedDr0gaId: UUID = dr0gas.first!.id
    
    var body: some View {
        Text("Mínimo: "+String(selectedDr0ga.Minimo))
        Text("Maximo: "+String(selectedDr0ga.Maximo))
        
        TextField("Velocidade", value: $selectedDr0ga.Velocidade, formatter: NumberFormatter())
        
        Text(String(selectedDr0ga.calcular_infusao(Peso: 75)))
            .contentTransition(.numericText(value: Double(selectedDr0ga.Velocidade)))
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: Double(selectedDr0ga.Velocidade))
    }
}

#Preview {
    teste_bibloteca()
}
