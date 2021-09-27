//
//  ContentView.swift
//  Project5
//
//  Created by Dmitriy Shmilo on 27.09.2021.
//

import SwiftUI

struct ContentView: View {
	@State
	private var usedWords = [String]()
	@State
	private var rootWord = ""
	@State
	private var newWord = ""
	
	@State
	private var errorTitle = ""
	@State
	private var errorMessage = ""
	@State
	private var showingError = false
	
	var body: some View {
		NavigationView {
			VStack {
				TextField("Word:", text: $newWord, onCommit:  {
					addWord()
				})
				.textFieldStyle(RoundedBorderTextFieldStyle())
				.padding()
				
				List(usedWords, id: \.self) {
					Image(systemName: "\($0.count).circle")
					Text($0)
				}
			}
			.navigationTitle(rootWord)
		}
		.onAppear {
			startGame()
		}
		.alert(isPresented: $showingError) {
			Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
		}
	}
	
	private func startGame() {
		if let url = Bundle.main.url(forResource: "start", withExtension: "txt") {
			if let words = try? String(contentsOf: url).components(separatedBy: "\n") {
				rootWord = words.randomElement()!
				return
			}
		}
		
		fatalError()
	}
	
	private func addWord() {
		let answer = newWord
			.lowercased()
			.trimmingCharacters(in: .whitespacesAndNewlines)
		
		guard !answer.isEmpty else {
			return
		}
		
		guard isOriginal(word: answer) else {
			showError(title: "Word used already", message: "There's such word in the list already")
			return
		}
		
		guard isReal(word: answer) else {
			showError(title: "Not a word", message: "This is not a valid word")
			return
		}
		
		guard isPossible(word: answer) else {
			showError(title: "Incorrect word", message: "Not made up of original letters")
			return
		}
		
		usedWords.insert(answer, at: 0)
		newWord = ""
	}
	
	private func isOriginal(word: String) -> Bool {
		!usedWords.contains(word)
	}
	
	private func isReal(word: String) -> Bool {
		let checker = UITextChecker()
		let range = NSRange(location: 0, length: word.count)
		let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
		return misspelledRange.location == NSNotFound
	}
	
	private func isPossible(word: String) -> Bool {
		var tmp = rootWord
		
		for letter in word {
			if let pos = tmp.firstIndex(of: letter) {
				tmp.remove(at: pos)
			} else {
				return false
			}
		}
		return true
	}
	
	private func showError(title: String, message: String) {
		errorTitle = title
		errorMessage = message
		showingError = true
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
