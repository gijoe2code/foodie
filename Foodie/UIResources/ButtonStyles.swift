//
//  ButtonStyles.swift
//  Foodie
//
//  Created by Joe Gilpin on 9/21/24.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.onPrimary)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(.primaryTheme)
            .cornerRadius(3)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.primaryTheme)
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(.primaryTheme, lineWidth: 2))
            // This fixes a bug where button is not clickable when background is clear.
            .contentShape(Rectangle())
    }
}
#Preview {
    VStack {
        Button("Primary") { }.buttonStyle(PrimaryButtonStyle())
        Button("Secondary") { }.buttonStyle(SecondaryButtonStyle())
    }
}
