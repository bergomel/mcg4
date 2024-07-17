//
//  ContentView.swift
//  mcg 2
//
//  Created by Bernardo on 16/07/23.
//

import SwiftUI

func formatNumber(_ number: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.minimumSignificantDigits = 2
    numberFormatter.maximumSignificantDigits = 2
    
    return numberFormatter.string(from: NSNumber(value: number)) ?? ""
}

struct ContentView: View {
    
    @State private var cor1:Color = Color("Color1")
    @State private var cor2:Color = Color("Color2")
    @State var peso:Int = 75
    
   
    @State var drogaSelecionada_ID: Droga.ID = drogas.first?.id ?? UUID() // Ajuste o tipo de ID conforme necessário
    @StateObject var drogaSelecionada = drogas.first!
    
    
    var body: some View {
        
        
        @State var mcgkgmin = drogaSelecionada.calcular_infusao(Peso: peso)

        VStack {
            
            VStack{
                Text(formatNumber(drogaSelecionada.calcular_infusao(Peso: peso)))
                //                    .font(.largeTitle)
                    .font(.system(size: 54))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .contentTransition(.numericText(value: mcgkgmin))
                    .animation(.easeInOut(duration: 0.3), value: mcgkgmin)
                
                Text("mcg/kg/min")
                    .font(.caption)
                    .padding(.bottom, 12)
                
                ZStack {
                    Gauge(value: mcgkgmin, in: drogaSelecionada.Minimo...drogaSelecionada.Maximo) {
                        Text("mcg/kg/min")
                    } currentValueLabel: {
                        Text("\(mcgkgmin)")
                    } minimumValueLabel: {
                        Text(formatNumber(drogaSelecionada.Minimo))
                            .foregroundColor(cor1)
                    } maximumValueLabel: {
                        Text(formatNumber(drogaSelecionada.Maximo))
                            .foregroundColor(cor2)
                    }
                    .gaugeStyle(.accessoryLinear)
                .tint(Gradient(colors: [cor1, cor2]))
                    
                    Slider(value: $drogaSelecionada.Velocidade, in:drogaSelecionada.calcular_range_velocidade(Peso: peso))
                        .opacity(0.5)
                        .padding(.horizontal, 35)
                }
                
            }
            .padding(40.0)
            .background(Color(UIColor.secondarySystemFill)
                        
            )
            
            Form {
                Section() {
                    
                    LabeledContent {
                        Stepper("", value: $drogaSelecionada.Velocidade,in: 1...100, onEditingChanged: {_ in
                            DispatchQueue.main.async {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            }
                        })
                    } label: {
                        TextField("", value: $drogaSelecionada.Velocidade, formatter: NumberFormatter())
                            .keyboardType(/*@START_MENU_TOKEN@*/.asciiCapableNumberPad/*@END_MENU_TOKEN@*/)
                        Text("mL/h")
                    }
                } header: {
                    HStack{
                        Image(systemName: "gauge")
                        Text("Velocidade")
                    }
                }
                
                Section() {
                    
                    Picker("Select Droga", selection: $drogaSelecionada_ID){
                                            ForEach(drogas) { droga in
                                                Text(droga.Substancia).tag(droga.id)
                                            }
                                        }.onChange(of: drogaSelecionada_ID) { oldValue, newValue in
                                            if let novaDroga = drogas.first(where: {$0.id == newValue}) {
                                                drogaSelecionada.update(from: novaDroga)
                                            }
                                        }
                    
                    //                    Picker("droga", selection: $idSolSelecionada) {
                    //                        Text("KKK").tag(0)
                    //                        Text("LLL").tag(1)
                    //                        Picker("Noradrenalina", selection: $idSolSelecionada){
                    //                            Text("16mg (4 ampolas)").tag(2)
                    //                            Text("32mg (8 ampolas)").tag(2)
                    //                        }.tag(2)
                    //                        Divider()
                    //                        Button(role: .destructive, action: delete) {
                    //                                Label("Delete", systemImage: "trash")
                    //                            }
                    //                    }
                    
                    LabeledContent {
                        Stepper("", value: $drogaSelecionada.Dose,in: 0...2000, step: 10)
                    } label: {
                        TextField("", value: $drogaSelecionada.Dose, formatter: NumberFormatter())
                            .keyboardType(/*@START_MENU_TOKEN@*/.asciiCapableNumberPad/*@END_MENU_TOKEN@*/)
                        Text("mg")
                    }
                    
                    LabeledContent {
                        Stepper("", value: $drogaSelecionada.Volume,in: 0...2000, step: 50)
                    } label: {
                        TextField("", value: $drogaSelecionada.Volume, formatter: NumberFormatter())
                            .keyboardType(/*@START_MENU_TOKEN@*/.asciiCapableNumberPad/*@END_MENU_TOKEN@*/)
                        Text("mL")
                    }
                    
                    LabeledContent {
                        Text(formatNumber(drogaSelecionada.Concentracao))
                    } label: {
                        Text("Diluição")
                        Text("mg/mL")
                    }
                    
                } header: {
                    HStack{
                        Image(systemName: "ivfluid.bag.fill")
                        Text("Solução")
                    }
                }
                
                
                Section() {
                    LabeledContent {
                        Stepper("", value: $peso,in: 0...200, step: 5)
                    } label: {
                        TextField("", value: $peso, formatter: NumberFormatter())
                            .keyboardType(/*@START_MENU_TOKEN@*/.asciiCapableNumberPad/*@END_MENU_TOKEN@*/)
                        Text("kg")
                    }
                } header: {
                    HStack{
                        Image(systemName: "person")
                        Text("Paciente")
                    }
                }
                
                
                DisclosureGroup {
                    ColorPicker("Início", selection: $cor1)
                    ColorPicker("Fim", selection: $cor2)
                } label: {
                    HStack{
                        Image(systemName: "paintbrush")
                        Text("Cor")
                        
                    }
                }
                
            }}
        .scrollDismissesKeyboard(.interactively)

    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
