//
//  IntersectionApp.swift
//  Intersection
//
//  Created by Zaur Gurbanli on 10.01.23.
//

import SwiftUI

@main
struct IntersectionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
          ContentView()
            .background(VisualEffect().ignoresSafeArea())
        }
    }
}

struct VisualEffect: NSViewRepresentable {
    func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
    func updateNSView(_ nsView: NSView, context: Context) { }
}
