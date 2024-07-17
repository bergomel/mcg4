import Foundation

class Droga: ObservableObject {
    //   ESTÁTICOS
        
        var Minimo: Double
        var Maximo: Double
        var id = UUID()
        
    //    VARIÁVEIS
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
        
    //    CALCULADOS
        
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
    
    init(Substancia: String, Dose: Int, Volume: Int, Velocidade: Int, Maximo: Double, Minimo: Double) {
           self.Substancia = Substancia
           self.Dose = Dose
           self.Volume = Volume
           self.Velocidade = Velocidade
           self.Maximo = Maximo
           self.Minimo = Minimo
       }
}

struct DrogaData: Codable {
    let Substancia: String
    let Dose: Int
    let Volume: Int
    let Velocidade: Int
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

