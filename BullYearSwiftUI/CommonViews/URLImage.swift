//
//  URLImage.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//
import SwiftUI
import Combine

protocol URLImageLoaderProtocol {
    func load(url: URL) -> AnyPublisher<UIImage, Error>
}

struct URLSessionImageLoader: URLImageLoaderProtocol {
    func load(url: URL) -> AnyPublisher<UIImage, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) ?? UIImage() }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}

private final class ImageState: ObservableObject {
    @Published var image = UIImage()
    private var loader: URLImageLoaderProtocol?

    func load(url: URL, using loader: URLImageLoaderProtocol) {
        self.loader = loader
        loader.load(url: url)
            .replaceError(with: UIImage())
            .assign(to: &$image)
    }
}


struct URLImage: View {
    @ObservedObject private var imageState = ImageState()
    init(url: URL, loader: URLImageLoaderProtocol = URLSessionImageLoader()) {
        imageState.load(url: url, using: loader)
    }

    var body: some View {
        Image(uiImage: imageState.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
