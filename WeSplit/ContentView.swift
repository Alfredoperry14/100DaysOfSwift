//
//  ContentView.swift
//  WeSplit
//
//  Created by Alfredo Perry on 5/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 15
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage) / 100
        
        let tipValue = checkAmount * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal / peopleCount
        
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage) / 100
        
        return checkAmount + (checkAmount * tipSelection)

    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code:
                                                                                Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    //.pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height:150)
                    .clipped()
                }
                
                Section("Total Cost Before Split"){
                    Text(totalAmount, format: .currency(code:
                    Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount Per Person"){
                    Text(totalPerPerson, format: .currency(code:
                        Locale.current.currency?.identifier ?? "USD"))
                    
                }
            }
            .navigationTitle("We Split")
            .toolbar{
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                } 
            }
        }
    }
}


#Preview {
    ContentView()
}
