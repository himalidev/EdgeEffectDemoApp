//
//  TabBarView.swift
//  EdgeEffectDemoApp
//
//  Created by Himali Marasinghe on 2025-09-15.
//


import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            // New-style Tab initializers (iOS 17+) play nicely here.
            Tab("Home", systemImage: "house") {
                NavigationStack {
                    EdgeEffectDemoView(title: "Home")
                }
            }

            Tab("Alerts", systemImage: "bell") {
                NavigationStack {
                    EdgeEffectDemoView(title: "Alerts")
                }
            }

            TabSection("Categories") {
                Tab("Favorites", systemImage: "heart.fill") {
                    NavigationStack {
                        EdgeEffectDemoView(title: "Favorites")
                    }
                }

                Tab("Suggested", systemImage: "lightbulb") {
                    NavigationStack {
                        EdgeEffectDemoView(title: "Suggested")
                    }
                }
            }
        }
    }
}
