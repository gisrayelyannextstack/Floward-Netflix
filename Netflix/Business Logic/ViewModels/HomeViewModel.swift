//
//  HomeViewModel.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 13.11.22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    private let networker = Networker()
    private var disposeBag = DisposeBag()
    
    @Published var isLoading = false
    @Published var genres: [Genre] = []
}

// MARK: - API Calls

extension HomeViewModel {
    func getData() {
        let genresRequest = networker.request(type: BaseResponseModel<Genre>.self, endpoint: NetflixEndpoint.genres)
        
        self.isLoading = true
        genresRequest
            .flatMap { resp in
                resp.results[0..<5].publisher.eraseToAnyPublisher()
            }
            .flatMap { genre -> AnyPublisher<Genre, Error> in
                self.networker.request(type: BaseResponseModel<Movie>.self, endpoint: NetflixEndpoint.movies(genreId: genre.id, limit: 10))
                    .map { resp -> Genre in
                        var genre = genre
                        genre.movies = resp.results
                        return genre
                    }
                    .eraseToAnyPublisher()
            }
            .collect()
            .sink(receiveCompletion: { error in
                switch error {
                case .failure(let err):
                    print(err.localizedDescription)
                case .finished:
                    print("Finished!!")
                }
            }, receiveValue: { genres in
                self.isLoading = false
                self.genres = genres
            })
            .store(in: &disposeBag)
    }
}
