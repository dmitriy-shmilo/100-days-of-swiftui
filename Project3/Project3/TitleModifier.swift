//
//  TitleModifier.swift
//  Project3
//
//  Created by Dmitriy Shmilo on 14.09.2021.
//

import SwiftUI

struct TitleModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.largeTitle)
			.foregroundColor(.blue)
	}
}

extension View {
	func title() -> some View {
		self.modifier(TitleModifier())
	}
}
