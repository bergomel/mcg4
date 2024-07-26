import SwiftUI



struct TestContentView: View {
    
    
    @State var selectedPerson: Person = people.first!
    @State var selectedPersonID: UUID = people.first!.id
    
    var body: some View {
        VStack {
            Text("🤩")
            
            Picker("Select a person", selection: $selectedPersonID) {
                ForEach(people) { person in
                    Text(person.name).tag(person.id)
                }
            }
            .pickerStyle(.automatic)
            .onChange(of: selectedPersonID) {
                selectedPerson = people.first(where: { $0.id == selectedPersonID})!
                print(selectedPerson)
            }

                Text("Selected person: \(selectedPerson.name)")
                Text("Years left: \(selectedPerson.yearsLeft)")
            TextField("Enter age", value: $selectedPerson.age, formatter: NumberFormatter()).onSubmit {
                print(selectedPerson)
            }
            
        }

    }
}



struct TestContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestContentView()
        }
}
