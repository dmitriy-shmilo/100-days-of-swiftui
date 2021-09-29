//
//  ContentView.swift
//  Project6
//
//  Created by Dmitriy Shmilo on 28.09.2021.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
	let amount: Double
	let anchor: UnitPoint

	func body(content: Content) -> some View {
		content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
	}
}

extension AnyTransition {
	static var pivot: AnyTransition {
		.modifier(
			active: CornerRotateModifier(amount: -90, anchor: .topLeading),
			identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
		)
	}
}
struct TransitionAnimationView: View {
	@State
	private var isShowingRed = false

	var body: some View {
		VStack {
			Button("Tap Me") {
				withAnimation {
					self.isShowingRed.toggle()
				}
			}

			if isShowingRed {
				Rectangle()
					.fill(Color.red)
					.frame(width: 200, height: 200)
					.transition(.asymmetric(insertion: .pivot, removal: .opacity))
			}
		}
	}
}

struct StaggerAnimationView: View {
	let letters = Array("Hello World")
	
	@State
	private var enabled = false
	
	@State
	private var dragAmount = CGSize.zero

	var body: some View {
		HStack(spacing: 0) {
			ForEach(0..<letters.count) { num in
				Text(String(self.letters[num]))
					.padding(5)
					.font(.title)
					.background(self.enabled ? Color.blue : Color.red)
					.offset(self.dragAmount)
					.animation(Animation.default.delay(Double(num) / 20))
			}
		}
		.gesture(
			DragGesture()
				.onChanged {
					self.dragAmount = $0.translation
				}
				.onEnded { _ in
					self.dragAmount = .zero
					self.enabled.toggle()
				}
		)
	}
}

struct GestureAnimationView: View {
	@State
	private var dragAmount = CGSize.zero
	
	var body: some View {
		LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
			.frame(width: 300, height: 200)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.offset(dragAmount)
			.gesture(
				DragGesture()
					.onChanged {
						dragAmount = $0.translation
					}
					.onEnded { _ in
						dragAmount = CGSize.zero
					}
			)
			.animation(.spring())
	}
}
struct StackingAnimationsView: View {
	@State
	var amount: CGFloat = 360.0
	
	@State
	var enabled = false
	
	var body: some View {
		Button("Tap Me") {
			enabled.toggle()
		}
		.frame(width: 200, height: 200)
		.background(enabled ? Color.red : Color.blue)
		.animation(.default)
		.foregroundColor(.white)
		.clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
		.animation(.interpolatingSpring(stiffness: 10, damping: 1))
	}
}

struct ExplicitButtonView: View {
	@State
	var amount: CGFloat = 360.0
	
	var body: some View {
		Button("Tap Me") {
			withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
				amount += 360
			}
		}
		.padding(50)
		.background(Color.red)
		.foregroundColor(.white)
		.clipShape(Circle())
		.rotation3DEffect(.degrees(amount), axis: (x: 0, y: 1.0, z: 0))
	}
}

struct ImplicitStepperView: View {
	@State
	var amount: CGFloat = 1.0
	
	var body: some View {
		VStack {
			Stepper("Scale amount", value: $amount.animation(), in: 1...10)
			
			Spacer()
			
			Button("Tap Me") {
				self.amount += 1
			}
			.padding(40)
			.background(Color.red)
			.foregroundColor(.white)
			.clipShape(Circle())
			.scaleEffect(amount)
		}
	}
	
}

struct ImplicitButtonsView: View {
	@State
	var amount: CGFloat = 1.0
	var body: some View {
		VStack {
			button
				.scaleEffect(amount)
				.blur(radius: (amount - 1) * 3)
				.animation(.default)
			
			button
				.scaleEffect(amount)
				.blur(radius: (amount - 1) * 3)
				.animation(.easeOut)
			
			button
				.scaleEffect(amount)
				.blur(radius: (amount - 1) * 3)
				.animation(.easeIn(duration: 2).delay(1))
			
			button
				.scaleEffect(amount)
				.blur(radius: (amount - 1) * 3)
				.animation(.easeInOut(duration: 1).repeatCount(3, autoreverses: true))
			
			button
				.overlay(
					Circle()
						.stroke(Color.red)
						.scaleEffect(amount)
						.opacity(Double(2 - amount))
						.animation(.easeInOut(duration: 1).repeatForever(autoreverses: false))
				)
		}
	}
	
	private var button: some View {
		Button("Tap Me") {
			amount = amount.truncatingRemainder(dividingBy: 3.0) + 1.0
		}
		.padding(20)
		.background(Color.red)
		.foregroundColor(.white)
		.clipShape(Circle())
		.padding(20)
		
	}
}
