//
//  IssueListView.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//
import SwiftUI

struct IssueListView: View {

    var body: some View {
        NavigationView {
            List(0..<20) { _ in
                NavigationLink(
                    destination: LazyView {
                        IssueDetailView()
                    },
                    label: {
                        IssueListCell()
                    }
                )
            }
            .navigationTitle("リスト")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct IssueListView_Previews: PreviewProvider {

    static var previews: some View {
        IssueListView()
    }
}
