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
	@State var alertMessage = ""
	@State var score = 0
	@State var flagsEnabled = true
	
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
						FlagView(
							isEnabled: $flagsEnabled,
							isCorrect: n == correctAnswer,
							image: self.countries[n]
						) {
							postAnswer(index: n)
						}
					}
					Text("Score: \(score)")
						.font(.title)
					Spacer()
				}
			}
			.foregroundColor(.white)
		}
		.alert(isPresented: $alertPresented) {
			Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
				flagsEnabled = true
				askQuestion()
			})
		}
    }
	
	private func postAnswer(index: Int) {
		withAnimation {
			flagsEnabled = false
		}
		let isCorrect = index == correctAnswer
		alertTitle = isCorrect ? "Correct" : "Wrong"
		score += isCorrect ? 1 : 0
		alertMessage = "Your new score is \(score)"
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
