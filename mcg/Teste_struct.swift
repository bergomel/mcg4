import Foundation

class Droga: ObservableObject {
    
//    VALORES ESTÁTICOS
    
    var Minimo: Double
    var Maximo: Double
    
//    VALORES VARIÁVEIS
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
    
//    CÁLCULOS
    
    var Concentracao: Double {
        return Double(Dose)/Double(Volume)
    }
    
    func calcular_infusao(Peso: Int) -> Double {
        return Double(Velocidade) / Double(Volume) * Double(Dose) / 60 * 1000 / Double(Peso)
    }
    
    func calcular_range_velocidade(Peso:Int) -> ClosedRange<Double> {
        let velocidade_min = 2 / Double(Volume) * Double(Dose) / 60 * 1000 / Double(Peso)
        let velocidade_max = 20 / Double(Volume) * Double(Dose) / 60 * 1000 / Double(Peso)
        return velocidade_min...velocidade_max
    }
    
//    INIT
    
    init(Substancia: String, Dose: Int, Volume: Int, Velocidade: Int, Maximo: Double, Minimo: Double) {
        self.Substancia = Substancia
        self.Dose = Dose
        self.Volume = Volume
        self.Velocidade = Velocidade
        self.Maximo = Maximo
        self.Minimo = Minimo
    }
    
}
