//
//  ContentView.swift
//  Project1
//
//  Created by Dmitriy Shmilo on 14.09.2021.
//

import SwiftUI

struct ContentView: View {
	let tipPercentages = [10, 15, 20, 25, 0]
	
	@State private var checkAmount = ""
	@State private var numberOfPeople = ""
	@State private var tipPercentage = 2
	
	var totalPerPerson: Double {
		let people = Double(numberOfPeople) ?? 2
		return grandTotal / people
	}
	
	var grandTotal: Double {
		let tip = Double(tipPercentages[tipPercentage])
		let orderTotal = Double(checkAmount) ?? 0.0
		
		let tipMod = 1 + tip / 100.0
		return orderTotal * tipMod
	}
	
	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Total amount:", text: $checkAmount)
						.keyboardType(.decimalPad)
					TextField("People", text: $numberOfPeople)
						.keyboardType(.numberPad)
				}
				Section(header: Text("Tip %")) {
					Picker("Tip %", selection: $tipPercentage) {
						ForEach(0..<tipPercentages.count) {
							Text("\(self.tipPercentages[$0])")
						}
					}
					.pickerStyle(SegmentedPickerStyle())
				}
				Section(header: Text("Total with tip:")) {
					Text("\(grandTotal, specifier: "%.2f")")
				}
				Section(header: Text("Per person:")) {
					Text("\(totalPerPerson, specifier: "%.2f")")
				}
			}
			.navigationBarTitle("WeSplit")
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
