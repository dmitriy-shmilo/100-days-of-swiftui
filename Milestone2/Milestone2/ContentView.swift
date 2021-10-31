//
//  ContentView.swift
//  Milestone2
//
//  Created by Dmitriy Shmilo on 29.09.2021.
//

import SwiftUI

struct QuestionsView: View {
	var body: some View {
		EmptyView()
	}
}

struct BorderButton: View {
	let text: String
	let rotation: Double
	let highlighted: Bool

	let action: () -> Void
	
	var body: some View {
		Button(action: action) {
			Text(text)
				.padding()
				.frame(width: 80, height: 80)
				.background(Color.white)
				.clipShape(RoundedRectangle(cornerRadius: 16))
				.overlay(RoundedRectangle(cornerRadius: 16)
							.stroke(Color.blue, lineWidth: highlighted ? 3 : 1))
				.shadow(color: Color.secondary, radius: 5, x: 0, y: 3)
				.padding()
				.rotationEffect(.degrees(rotation))
		}
	}
}

enum QuestionCount: Hashable {
	case number(count: UInt)
	case all
}

struct HomeView: View {
	private static let min = 2
	private static let max = 10
	private static let questionCounts = [
		QuestionCount.number(count: 5),
		QuestionCount.number(count: 10),
		QuestionCount.number(count: 20),
		QuestionCount.all
	]

	@State
	private var selectedNumber = Self.min
	@State
	private var selectedQuestionCount = Self.questionCounts[0]

	var body: some View {
		let cols = [
			GridItem(.flexible()),
			GridItem(.flexible()),
			GridItem(.flexible())
		]

		NavigationView {
			ScrollView {
				VStack(alignment: .leading) {
					HStack {
						Spacer()
						NavigationLink(destination: QuestionsView()) {
							Text("GO")
								.font(.system(size: 20, weight: .bold))
						}
						.padding()
					}
					Text("Up to:")
						.font(.system(size: 14, weight: .semibold))
						.padding()
					LazyVGrid(columns: cols) {
						ForEach(Self.min...Self.max, id: \.self) { num in
							BorderButton(
								text: "\(num)",
								rotation: 30 - Double(num * 133 % 60),
								highlighted: num == selectedNumber
							) {
								selectedNumber = num
							}
						}
					}

					Text("Questions:")
						.font(.system(size: 14, weight: .semibold))
						.padding()
					LazyVGrid(columns: cols) {
						ForEach(Self.questionCounts, id: \.self) { questionCount in
							makeNumberButton(for: questionCount)
						}
					}
				}
			}
			.navigationBarHidden(true)
		}
	}

	private func makeNumberButton(
		for questionCount: QuestionCount
	) -> BorderButton {
		let text: String
		let rotation: Double
		switch questionCount {
		case .number(let count):
			text = "\(count)"
			rotation = 30 - Double((count * 133 / 6) % 60)
		case .all:
			text = "All"
			rotation = 30 - Double(133 % 60)
		}
		return BorderButton(
			text: text,
			rotation: rotation,
			highlighted: questionCount == selectedQuestionCount
		) {
			selectedQuestionCount = questionCount
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
