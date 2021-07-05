//
//  ChallengeService.swift
//  Fitness App
//
//  Created by Kaiserdem on 30.06.2021.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ChallengeServiceProtocol {
    func create(_ challenge: Challenge) -> AnyPublisher<Void, IncrementError>

    func observerChallenges(userId:UserId) -> AnyPublisher<[Challenge] , IncrementError>
}

final class ChallengeService: ChallengeServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, IncrementError> {
        return Future<Void, IncrementError> { promise in
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge) { error in
                    if let error = error {
                        promise(.failure((.default(description: error.localizedDescription))))
                    } else {
                        promise(.success(()))
                    }
                }
                promise(.success(()))
            } catch {
                promise(.failure(.default()))
            }
        }.eraseToAnyPublisher()
    }
    
    func observerChallenges(userId: UserId) -> AnyPublisher<[Challenge], IncrementError> {
        let query = db.collection("challengs").whereField("userId", isEqualTo: userId)
        return Publishers.QuerySnapshotPublisher(query: query)
            .flatMap { shapshot -> AnyPublisher<[Challenge], IncrementError> in
                do {
                    let challenges = try shapshot.documents.compactMap {
                        try $0.data(as: Challenge.self)
                      }
                    return Just(challenges)
                        .setFailureType(to: IncrementError.self)
                        .eraseToAnyPublisher()
                    } catch {
                        return Fail(error: .default(description:"Parsing error")).eraseToAnyPublisher()
                    }
            }.eraseToAnyPublisher()
    
    }
    
}
