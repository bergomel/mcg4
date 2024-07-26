import Foundation

class Droga: ObservableObject, Identifiable, Equatable, Hashable {

    
    //   ESTÁTICOS
        
        var Minimo: Double
        var Maximo: Double
        var id = UUID()
        
    //    VARIÁVEIS
        @Published var Substancia: String {
            willSet { objectWillChange.send() }
        }

        @Published var Dose: Int {
            willSet { objectWillChange.send() }
        }
        var Volume: Int {
            willSet { objectWillChange.send() }
        }
        var Velocidade: Double {
            willSet { objectWillChange.send() }
        }
        
    //    CALCULADOS
        
        var Concentracao: Double {
            return Double(Dose)/Double(Volume)
        }
        
        func calcular_infusao(Peso: Int) -> Double {
            return Double(Velocidade) / Double(Volume) * Double(Dose) / 60 * 1000 / Double(Peso)
        }
        
        func calcular_range_velocidade(Peso:Int) -> ClosedRange<Double> {
            let velocidade_min = (Minimo * Double(Peso) * 60 * Double(Volume)) / (Double(Dose) * 1000)
            let velocidade_max = (Maximo * Double(Peso) * 60 * Double(Volume)) / (Double(Dose) * 1000)
            return velocidade_min...velocidade_max
        }
    
    init(Substancia: String?, Dose: Int?, Volume: Int?, Velocidade: Double?, Maximo: Double?, Minimo: Double?) {
        self.Substancia = Substancia ?? "Dobutamina"
        self.Dose = Dose ?? 1000
        self.Volume = Volume ?? 250
        self.Velocidade = Velocidade ?? 10
        self.Maximo = Maximo ?? 20
        self.Minimo = Minimo ?? 2
    }
    

        // Conform to Equatable
        static func == (lhs: Droga, rhs: Droga) -> Bool {
            return lhs.id == rhs.id &&
                   lhs.Substancia == rhs.Substancia &&
                   lhs.Dose == rhs.Dose &&
                   lhs.Volume == rhs.Volume &&
                   lhs.Velocidade == rhs.Velocidade &&
                   lhs.Minimo == rhs.Minimo &&
                   lhs.Maximo == rhs.Maximo
        }
        
        // Conform to Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(Substancia)
            hasher.combine(Dose)
            hasher.combine(Volume)
            hasher.combine(Velocidade)
            hasher.combine(Minimo)
            hasher.combine(Maximo)
        }
    
    func update(from outraDroga: Droga) {
        self.id = outraDroga.id
        self.Substancia = outraDroga.Substancia
        self.Dose = outraDroga.Dose
        self.Volume = outraDroga.Volume
        self.Velocidade = outraDroga.Velocidade
        self.Minimo = outraDroga.Minimo
        self.Maximo = outraDroga.Maximo
        // Atualize outras propriedades conforme necessário
    }
    
}

struct DrogaData: Codable {
    let Substancia: String
    let Dose: Int
    let Volume: Int
    let Velocidade: Double
    let Minimo: Double
    let Maximo: Double
}

func loadJson(filename fileName: String) -> [DrogaData]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([DrogaData].self, from: data)
            return jsonData
        } catch {
            print("Error loading JSON data: \(error)")
        }
    }
    return nil
}

func createDrogasFromJson(filename: String) -> [Droga] {
    var drogas = [Droga]()
    if let drogaDataArray = loadJson(filename: filename) {
        for drogaData in drogaDataArray {
            let droga = Droga(Substancia: drogaData.Substancia, Dose: drogaData.Dose, Volume: drogaData.Volume, Velocidade: drogaData.Velocidade, Maximo: drogaData.Maximo, Minimo: drogaData.Minimo)
            drogas.append(droga)
        }
    }
    return drogas
}

// Example usage
let drogas = createDrogasFromJson(filename: "soluções - cópia")
// Now you have an array of Droga instances

