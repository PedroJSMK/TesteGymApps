//
//  FloatingActionButton.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import SwiftUI
import MaterialComponents


struct FloatingActionButton: UIViewRepresentable {
    let fab = MDCFloatingButton()
    
    let title: String
    let action: () -> Void
    
    @Environment(\.font) var font: Font?
    var backgroundColor: Color?
    
    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    func makeUIView(context: Context) -> MDCFloatingButton {
        let button = MDCFloatingButton(shape: .default)
        button.addTarget(context.coordinator, action: #selector(Coordinator.buttonTapped), for: .touchUpInside)
        return button
    }
    
    
    
    func updateUIView(_ uiView: MDCFloatingButton, context: Context) {
        uiView.setTitle(title, for: .normal)
        //uiView.setTitleFont(UIFont?(font: font), for: .normal)
        if let color = backgroundColor {
            uiView.setBackgroundColor(UIColor.orange)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var button: FloatingActionButton
        
        init(_ button: FloatingActionButton) {
            self.button = button
        }
        
        @objc func buttonTapped() {
            button.action()
        }
    }
}

extension FloatingActionButton {
    func backgroundColor(_ color: Color) -> Self {
        var copy = self
        copy.backgroundColor = color
        return copy
    }
}
