//
//  FBFireStore.swift
//  SpaceXFan
//
//  Created by Adem Kaya
//
import Foundation
import FirebaseFirestore

enum NetworkError: Error {
    case fail
}

class FBFireStore {

    static let shared = FBFireStore()
    private var db = Firestore.firestore()
    var favorite: FavoriteRocket?

    func geData(with userId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        print("User yilmaz  \(userId)")

        let docRef = db.collection("Favorite").document(userId)

        docRef.getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                guard let dataDescription = document.data() else { return }

                let initial: FavoriteRocket? = JsonUtils.shared.decodeFrom(dictinary: dataDescription)

                if let initial = initial {
                    self?.favorite = initial
                }

                print("Document data: \(dataDescription)")
                completion(.success(true))
            } else {
                print("Document does not exist")
                completion(.failure(NetworkError.fail))
            }
        }
    }

    func setData(with data: String, for userId: String) {
        let document = db.collection("Favorite").document(userId)

        document.updateData([
            "names": FieldValue.arrayUnion([data])
        ])
    }

    func deleteData(with data: String, for userId: String) {
        let document = db.collection("Favorite").document(userId)

        document.updateData([
            "names": FieldValue.arrayRemove([data])
        ])
    }
}
