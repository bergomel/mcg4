import Foundation

class Droga: ObservableObject {
    @Published var Substancia: String {
        willSet { objectWillChange.send() }
    }

    var Dose: Int {
        willSet { objectWillChange.send() }
    }
    var Volume: Int {
        willSet { objectWillChange.send() }
    }
    var Velocidade: Int {
        willSet { objectWillChange.send() }
    }
    
    var Concentracao: Double {
        return Double(Dose)/Double(Volume)
    }
    
    init(Substancia: String, Dose: Int, Volume: Int, Velocidade: Int) {
        self.Substancia = Substancia
        self.Dose = Dose
        self.Volume = Volume
        self.Velocidade = Velocidade
    }
    
    func calcular_infusao(Peso: Int) -> Double {
        return Double(Velocidade) / Double(Volume) * Double(Dose) / 60 * 1000 / Double(Peso)
    }
}
