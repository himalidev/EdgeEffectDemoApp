//
//  EdgeEffectDemoView.swift
//  EdgeEffectDemoApp
//
//  Created by Himali Marasinghe on 2025-09-15.
//


import SwiftUI

@available(iOS 16.0, *)
struct EdgeEffectDemoView: View {
    let title: String

    @State private var topStyle: EdgeStyleOption = .soft
    @State private var bottomStyle: EdgeStyleOption = .hard
    @State private var applyLargeTitle = true
    @State private var addFloatingBar = true
    @State private var cardCount: Int = 40

    private let colors: [Color] = [.yellow, .mint, .orange, .pink, .purple, .teal]

    var body: some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(applyLargeTitle ? .large : .inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu("Options") {
                        Toggle("Large Title", isOn: $applyLargeTitle)
                        Toggle("Floating Bottom Bar", isOn: $addFloatingBar)
                        Picker("Top Edge", selection: $topStyle) {
                            ForEach(EdgeStyleOption.allCases) { option in
                                Text(option.rawValue.capitalized).tag(option)
                            }
                        }
                        Picker("Bottom Edge", selection: $bottomStyle) {
                            ForEach(EdgeStyleOption.allCases) { option in
                                Text(option.rawValue.capitalized).tag(option)
                            }
                        }
                        Stepper("Cards: \(cardCount)", value: $cardCount, in: 10...120, step: 10)
                    }
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        if #available(iOS 26.0, *) {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<cardCount, id: \.self) { x in
                        ZStack {
                            Rectangle()
                                .fill(colors.randomElement()?.opacity(0.75) ?? .gray)
                                .frame(height: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            Text("\(x + 1)")
                                .font(.system(size: 48, weight: .heavy, design: .rounded))
                                .foregroundStyle(.white)
                                .shadow(radius: 2)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                    }
                    Spacer(minLength: 12)
                }
            }
            // Per-edge effects: try mixing soft/hard/automatic
            .scrollEdgeEffectStyle(topStyle.swiftUIStyle, for: .top)
            .scrollEdgeEffectStyle(bottomStyle.swiftUIStyle, for: .bottom)
            .safeAreaInset(edge: .bottom) {
                if addFloatingBar {
                    FloatingActionBar()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .padding(.bottom, 10)
                }
            }
        } else {
            // Fallback for iOS < 26: same UI without the edge effect modifier
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<cardCount, id: \.self) { x in
                        ZStack {
                            Rectangle()
                                .fill(colors.randomElement()?.opacity(0.75) ?? .gray)
                                .frame(height: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            Text("\(x + 1)")
                                .font(.system(size: 48, weight: .heavy, design: .rounded))
                                .foregroundStyle(.white)
                                .shadow(radius: 2)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                    }
                    Spacer(minLength: 12)
                }
            }
            .overlay {
                VStack {
                    Spacer()
                    Text("Upgrade to iOS 26 to see scroll edge effects.")
                        .font(.footnote)
                        .padding(8)
                        .background(.thinMaterial, in: Capsule())
                        .padding(.bottom, 12)
                }
            }
        }
    }
}

// MARK: - Edge Style Option

enum EdgeStyleOption: String, CaseIterable, Identifiable {
    case automatic, soft, hard
    var id: String { rawValue }

    @available(iOS 26.0, *)
    var swiftUIStyle: ScrollEdgeEffectStyle {
        switch self {
        case .automatic: return .automatic
        case .soft:      return .soft
        case .hard:      return .hard
        }
    }
}

// MARK: - Floating Bar (to emphasize overlap at bottom)

struct FloatingActionBar: View {
    var body: some View {
        HStack(spacing: 12) {
            Button {
                // no-op
            } label: {
                Label("New", systemImage: "plus.circle.fill")
                    .labelStyle(.titleAndIcon)
                    .font(.headline)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(.ultraThinMaterial, in: Capsule())
            }

            Button {
                // no-op
            } label: {
                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    .labelStyle(.titleAndIcon)
                    .font(.headline)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(.ultraThinMaterial, in: Capsule())
            }
        }
        .padding(.horizontal, 16)
        .background(
            .bar
                .opacity(0.55),
            in: Capsule(style: .continuous)
        )
        .shadow(radius: 6, y: 3)
    }
}
