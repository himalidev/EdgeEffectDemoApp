# EdgeEffectDemoApp

A tiny SwiftUI app that **demonstrates `scrollEdgeEffectStyle(_:, for:)` on iOS 26** in a realistic layout with both a **Navigation bar** (large/inline titles) and a **Tab bar** (with sections). It also includes a floating bottom bar to make safe-area overlaps obvious—perfect for “Liquid Glass” design.

---

## Why this matters

When content hits a safe area (large titles, toolbars, tab bars), SwiftUI shows an **edge effect** on overscroll. In iOS 26 you can control that look:

- `.automatic` — system default  
- `.soft` — diffused, rounded, “liquid” feel  
- `.hard` — crisp divider for strong boundaries

This repo shows **per-edge control** (top vs bottom) and how the effect changes as the tab bar minimizes and the nav bar switches large/inline.

---

## Features

- ✅ `ScrollView` with **per-edge** styles: top `.soft`, bottom `.hard`, etc.  
- ✅ **NavigationStack** with large/inline title toggle  
- ✅ **TabView** with **TabSection** (multiple sections)  
- ✅ **Floating action bar** via `safeAreaInset(edge: .bottom)` to amplify the bottom edge effect  
- ✅ Runtime menu to switch styles (`automatic` / `soft` / `hard`) and card count

---

## Requirements

- **iOS 26** (simulator or device)  
- **Xcode 26** or newer  
- SwiftUI (bundled with the SDK)

> Note: `TabSection` is available in modern SwiftUI; if you target much older OS versions, remove or gate it accordingly.

---

## Getting started

1) Clone the repo  
2) Open `EdgeEffectDemoApp.xcodeproj` in Xcode  
3) Select an **iOS 26** simulator (e.g., iPhone)  
4) **Run**

**In the app:**  
- Tap **Options** (top-right) to toggle **Large Title**, **Floating Bottom Bar**, and per-edge styles.  
- Scroll to see how **top** and **bottom** edges differ under the nav/tab bars.

---

## Key code

```swift
// Per-edge styling (iOS 26+)
ScrollView {
    // content…
}
.scrollEdgeEffectStyle(.soft, for: .top)
.scrollEdgeEffectStyle(.hard, for: .bottom)
