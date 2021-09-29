//
//  FlagView.swift
//  Project2
//
//  Created by Dmitriy Shmilo on 14.09.2021.
//

import SwiftUI

struct FlagView: View {
	@Binding
	var isEnabled: Bool

	let isCorrect: Bool
	let image: String
	let action: () -> Void
	

	var body: some View {
		Button(action: self.action) {
			Image(self.image)
				.renderingMode(.original)
				.clipShape(Capsule())
				.overlay(Capsule().stroke(Color.black, lineWidth: 1))
				.shadow(color: .black, radius: 2)
		}
		.opacity(isEnabled || isCorrect ? 1.0 : 0.25)
		.rotation3DEffect(.degrees(isCorrect && isEnabled ? 360 : 0), axis: (x: 0, y: 1, z: 0))
	}
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
		FlagView(isEnabled: .constant(true), isCorrect: true, image: "US") {}
    }
}
