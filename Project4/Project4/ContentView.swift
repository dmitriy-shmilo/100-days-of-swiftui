//
//  ContentView.swift
//  Project4
//
//  Created by Dmitriy Shmilo on 15.09.2021.
//

import SwiftUI
import CoreML

struct ContentView: View {
	
	private static var defaultWakeTime: Date {
		var components = DateComponents()
		components.hour = 7
		components.minute = 0
		return Calendar.current.date(from: components) ?? Date()
	}
	
	@State private var sleepAmount = 8.0
	@State private var wakeUp = defaultWakeTime
	@State private var coffee = 1
	
	@State private var alertTitle = ""
	@State private var alertMessage = ""
	@State private var showingAlert = false
	
	var body: some View {
		NavigationView {
			Form {
				Section(
					header:Text("Wake up time:")
						.font(.headline)
				) {
					DatePicker("Enter wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
						.labelsHidden()
						.datePickerStyle(WheelDatePickerStyle())
				}
				
				Section(
					header:Text("Time to sleep:")
						.font(.headline)
				) {
					Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
						Text("\(sleepAmount, specifier: "%.2f") hours")
					}
				}
				
				
				Section(
					header:Text("Coffee cups per day:")
						.font(.headline)
				) {
					Picker(
						selection: $coffee,
						label: Text("Picker")
					) {
						ForEach(1...20, id: \.self) { n in
							if n == 1 {
								Text("1 cup").tag(n)
							} else {
								Text("\(n) cups").tag(n)
							}
						}
					}
				}
				
				Section(
					header:Text("You should go to bed at:")
						.font(.headline)
				) {
					Text(calculateBedTime())
						.font(.title)
				}
			}
			.navigationTitle("BetterRest")
		}
	}
	
	
	private func calculateBedTime() -> String{
		if let mlModel = try? SleepCalculator(configuration: MLModelConfiguration()) {
			let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
			let hour = (components.hour ?? 0) * 60 * 60
			let minute = (components.minute ?? 0) * 60
			
			if let prediction = try? mlModel.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffee)) {
				let sleepTime = wakeUp - prediction.actualSleep
				let formatter = DateFormatter()
				formatter.timeStyle = .short
				return "\(formatter.string(from: sleepTime))"
			}
		}
		
		return "There was an error calculating bedtime."
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
