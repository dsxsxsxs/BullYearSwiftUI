//
//  IssueListCell.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//

import SwiftUI

struct IssueListCell: View {
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 8.0) {
                Text("An Issue")
                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                    .fontWeight(.medium)
                    .lineLimit(Int.max)
                    .minimumScaleFactor(0.5)
                HStack(alignment: .bottom, spacing: 8.0) {
                    Text("desc digest")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .lineLimit(1)
                    Spacer()
                    Text("dsxsxsxs")
                        .font(.body)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
            }
            Spacer()
            Image(systemName: "person.fill")
                .frame(width: 32.0, height: 32.0)
        }
    }
}


struct IssueListCell_Previews: PreviewProvider {
    static var previews: some View {
        IssueListCell()
            .previewLayout(.sizeThatFits)
    }
}
