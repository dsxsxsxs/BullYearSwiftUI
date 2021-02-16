//
//  LazyView.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
