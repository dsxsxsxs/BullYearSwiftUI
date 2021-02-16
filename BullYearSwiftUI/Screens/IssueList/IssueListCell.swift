//
//  IssueListCell.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//

import SwiftUI

struct IssueListCell: View {
    let issue: Issue
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(issue.title)
                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                    .fontWeight(.medium)
                    .lineLimit(Int.max)
                    .minimumScaleFactor(0.5)
                HStack(alignment: .bottom, spacing: 8.0) {
                    Text(issue.body)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .lineLimit(1)
                    Spacer()
                    Text(issue.user.login)
                        .font(.body)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
            }
            Spacer()
            URLImage(url: issue.user.avatarURL, placeholder: UIImage(systemName: "person.fill"))
                .frame(width: 32.0, height: 32.0)
        }
    }
}


struct IssueListCell_Previews: PreviewProvider {
    static var previews: some View {
        IssueListCell(issue: Issue(number: 0, title: "abc", body: "abc", url: URL(string: "https://ab")!, user: User(login: "dsxsxsxs", avatarURL: URL(string: "https://ab")!)))
            .previewLayout(.sizeThatFits)
    }
}
