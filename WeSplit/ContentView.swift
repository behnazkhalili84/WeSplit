//
//  ContentView.swift
//  WeSplit
//
//  Created by behnaz Khalili on 2024-03-24.
//

import SwiftUI

struct ContentView: View {
    @State var tapCount = 0
    @State private var name = ""
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    var tipValue :Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return tipValue
    }
    var grandTotal : Double{
        return checkAmount + tipValue
    }
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
//        let tipSelection = Double(tipPercentage)
//        let tipValue = checkAmount / 100 * tipSelection
//        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    @FocusState private var amountIsFocused: Bool
    var body: some View {
        NavigationStack{
            NavigationStack{
                Form {
                    Section {
                        Text("Please Enter Amount")
                        TextField("Total Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)
                    }
                    Section{
                        Picker("Number of people",selection: $numberOfPeople){
                            ForEach(2..<100){
                                Text("\($0) people")
                            }
                        }.pickerStyle(.navigationLink)
                    }
                    Section{
                        Text("How much tip do you want to leave?")
                        Picker("Tip percentage",selection: $tipPercentage){
                            ForEach(0..<101){
                                Text("\($0)")
                            }
                        }.pickerStyle(.navigationLink)
                    }
                    
                    Section {
                        Text("Total Amount with tip")
                        Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    
                   
                    Section{
                        Text("Amount per person")
                        Text(totalPerPerson,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                
            }.navigationTitle("WeSplit")
                .toolbar{
                    if amountIsFocused{
                        Button("Done"){
                            amountIsFocused = false
                        }
                    }
                }
            
            .padding()
        }
    }
}


#Preview {
    ContentView()
}
