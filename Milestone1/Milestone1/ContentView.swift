//
//  ContentView.swift
//  Milestone1
//
//  Created by Dmitriy Shmilo on 14.09.2021.
//

import SwiftUI

struct ContentView: View {
	static let Moves = ["Rock", "Paper", "Scissors"]
	static let TotalRounds = 3

	@State private var shouldWin = Bool.random()
	@State private var currentMove = Int.random(in: 0..<Moves.count)
	@State private var score = 0
	@State private var currentRound = 0
	@State private var isGameOver = false
	

	var body: some View {
		VStack(spacing: 16) {
			if isGameOver {
				Text("Your score is \(score)")
				Button(action: {
					isGameOver = false
					score = 0
					currentRound = 0
				}) {
					Text("Again")
				}
			} else {
				
				Text(
					shouldWin
					? "You should win against:"
					: "You should lose against:"
				)
				
				Text(Self.Moves[currentMove])
					.font(.largeTitle)
				
				ForEach(0..<Self.Moves.count) { i in
					Button(action: {
						var scoreMod = -1
						
						if shouldWin && i == (currentMove + 1) % Self.Moves.count {
							scoreMod = 1
						} else if !shouldWin && currentMove == (i + 1) % Self.Moves.count {
							scoreMod = 1
						} else {
							scoreMod = -1
						}
						
						currentMove = Int.random(in: 0..<Self.Moves.count)
						shouldWin = Bool.random()
						score += scoreMod
						currentRound += 1
						
						if currentRound >= Self.TotalRounds {
							isGameOver = true
						}
					}) {
						Text(Self.Moves[i])
					}
				}
				.padding()
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
