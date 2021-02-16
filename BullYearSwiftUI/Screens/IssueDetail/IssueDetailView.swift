//
//  IssueDetailView.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//

import SwiftUI

struct IssueDetailView: View {
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    Text("An Issue")
                    Rectangle()
                        .foregroundColor(Color.gray)
                        .frame(height: 1.0)
                    Text("http://abc.xyz")
                    Rectangle()
                        .foregroundColor(Color.gray)
                        .frame(height: 1.0)
                    Text("digest")
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 24, trailing: 16))
                Spacer()
            }

        }
        .navigationTitle("詳細")
    }
}

struct IssueDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IssueDetailView()
            IssueDetailView()
                .preferredColorScheme(.dark)
        }
    }
}
