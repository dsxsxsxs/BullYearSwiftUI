//
//  IssueListView.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//
import SwiftUI

struct IssueListView: View {
    @StateObject private var viewModel = IssueListViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.issues) { issue in
                NavigationLink(
                    destination: LazyView {
                        IssueDetailView()
                    },
                    label: {
                        IssueListCell(issue: issue)
                            .onAppear {
                                viewModel.didDisplay(issue: issue)
                            }
                    }
                )
                
            }
            .navigationTitle("リスト")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct IssueListView_Previews: PreviewProvider {

    static var previews: some View {
        IssueListView()
    }
}
