//
//  ContentView.swift
//  Project2
//
//  Created by Dmitriy Shmilo on 14.09.2021.
//

import SwiftUI

struct ContentView: View {
	@State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
	@State var correctAnswer = Int.random(in: 0...2)
	@State var alertPresented = false
	@State var alertTitle = ""
	
    var body: some View {
		ZStack {
			LinearGradient(
				gradient: Gradient(colors: [Color.blue, Color.black]),
				startPoint: .top,
				endPoint: .bottom
			)
			.edgesIgnoringSafeArea(.all)
			
			VStack (spacing: 30) {
				Text("Tap the flag of")
				Text("\(countries[correctAnswer])")
					.font(.largeTitle)
					.fontWeight(.black)
				
				VStack {
					ForEach(0..<3) { n in
						Button(action: {
							showAlert(isWrong: n != correctAnswer)
						}) {
							Image(self.countries[n])
								.renderingMode(.original)
								.clipShape(Capsule())
								.overlay(Capsule().stroke(Color.black, lineWidth: 1))
								.shadow(color: .black, radius: 2)
						}
					}
					Spacer()
				}
			}
			.foregroundColor(.white)
		}
		.alert(isPresented: $alertPresented) {
			Alert(title: Text(alertTitle), message: nil, dismissButton: .default(Text("Continue")) {
				askQuestion()
			})
		}
    }
	
	private func showAlert(isWrong: Bool) {
		alertTitle = isWrong ? "Wrong" : "Correct"
		alertPresented = true
	}
	
	private func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
