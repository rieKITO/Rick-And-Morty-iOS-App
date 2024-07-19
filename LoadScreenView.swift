//
//  LoadScreenView.swift
//  Rick⠀&⠀Morty
//
//  Created by Александр Потёмкин on 19.07.2024.
//

import SwiftUI

struct LoadScreenView: View {
    var body: some View {
        ZStack {
            Image("loadBackground")
                .resizable()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.7))
            Image("loadText")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
        }
    }
}
