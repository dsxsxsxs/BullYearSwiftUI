//
//  URLImage.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//
import SwiftUI

struct URLImage: View {

    var body: some View {
        Image(uiImage: UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
