//
//  URLImage.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//
import SwiftUI
import Combine
import Dispatch

protocol ImageLoaderProtocol {
    func load(url: URL) -> AnyPublisher<UIImage, Error>
}

private struct URLSessionLoader: ImageLoaderProtocol {
    func load(url: URL) -> AnyPublisher<UIImage, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) ?? UIImage() }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}

private final class URLImageState: ObservableObject {
    @Published var image = UIImage()
    private let loader: ImageLoaderProtocol
    private let url: URL
    private let placeholder: UIImage?

    init(url: URL, placeholder: UIImage?, loader: ImageLoaderProtocol) {
        self.url = url
        self.placeholder = placeholder
        self.image = placeholder ?? UIImage()
        self.loader = loader
    }

    func load() {
        loader.load(url: url)
            .replaceError(with: placeholder ?? UIImage())
            .receive(on: DispatchQueue.main)
            .assign(to: &$image)
    }
}


struct URLImage: View {
    @ObservedObject private var state: URLImageState

    init(url: URL, placeholder: UIImage? = nil, loader: ImageLoaderProtocol = URLSessionLoader()) {
        state = .init(url: url, placeholder: placeholder, loader: loader)
    }

    var body: some View {
        Image(uiImage: state.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear {
                state.load()
            }
    }
}
