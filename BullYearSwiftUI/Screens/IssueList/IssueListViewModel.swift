//
//  IssueListViewModel.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//

import Combine
import Dispatch

final class IssueListViewModel: ObservableObject {
    enum FetchMode {
        case refresh
        case next
    }

    private let fetchTrigger = PassthroughSubject<FetchMode, Never>()
    @Published private var page: Int = 1
    @Published var issues: [Issue] = []
    private var cancellables = Set<AnyCancellable>()
    init() {
        fetchTrigger
            .withLatestFrom($page)
            .flatMap(maxPublishers: .max(1)) { mode, page in
                API().connect(config: IssueListRequest(page: page))
                    .catch { _ in Empty<[Issue], Error>() }
                    .map { (mode, page, $0) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                switch $0 {
                case .refresh:
                    self?.issues = $2
                case .next:
                    self?.issues += $2
                }
                self?.page = $1 + 1

            })
            .store(in: &cancellables)

    }
    func onAppear() {
        fetchTrigger.send(.refresh)
    }

    func didDisplay(issue: Issue)  {
        let thresholdIndex = issues.index(issues.endIndex, offsetBy: -5)
        if issues.firstIndex(of: issue) == thresholdIndex {
            fetchTrigger.send(.next)
        }
    }
}
