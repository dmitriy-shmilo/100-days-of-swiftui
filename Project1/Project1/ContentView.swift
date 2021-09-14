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
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 2
	
	var totalPerPerson: Double {
		let people = Double(numberOfPeople + 2)
		let tip = Double(tipPercentages[tipPercentage])
		let orderTotal = Double(checkAmount) ?? 0.0
		
		let tipMod = 1 + tip / 100.0
		let grandTotal = orderTotal * tipMod
		
		return grandTotal / people
	}
	
	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Total amount:", text: $checkAmount)
						.keyboardType(.decimalPad)
				}
				Section {
					Picker("Number of People", selection: $numberOfPeople) {
						ForEach(2..<10) {
							Text("\($0) people")
						}
					}
				}
				Section(header: Text("Tip %")) {
					Picker("Tip %", selection: $tipPercentage) {
						ForEach(0..<tipPercentages.count) {
							Text("\(self.tipPercentages[$0])")
						}
					}
					.pickerStyle(SegmentedPickerStyle())
				}
				Section {
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
