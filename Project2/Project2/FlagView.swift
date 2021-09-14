//
//  FlagView.swift
//  Project2
//
//  Created by Dmitriy Shmilo on 14.09.2021.
//

import SwiftUI

struct FlagView: View {
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
	}
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
		FlagView(image: "US") {}
    }
}
