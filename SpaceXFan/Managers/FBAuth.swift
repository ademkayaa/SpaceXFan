//
//  FBAuth.swift
//  SpaceXFan
//
//  Created by Adem Kaya 
//

import Foundation
import FirebaseAuth

class FBAuth {

    static let shared = FBAuth()
    var currentUserId: String = ""
    var isSignedIn: Bool = false

    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (res, err) in
            if err != nil {
                print("SignIn fail \(err!.localizedDescription)")
                completion(.failure(NetworkError.fail))
                return
            } else {
                guard let userId = res?.user.uid else { return }
                self?.currentUserId = userId
                UserDefaults.standard.set(true, forKey: "status")
                self?.isSignedIn = true
                FBFireStore.shared.geData(with: userId) { result in
                    switch(result) {
                    case.success(_):
                        print("getDocument success")
                    case.failure(_):
                        print("getDocument fail")
                    }
                }

                completion(.success(true))
            }
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (res, err) in

            if err != nil {
                print("SignUp fail \(err!.localizedDescription)")
                completion(.failure(NetworkError.fail))
                return
            } else {
                self?.isSignedIn = true
                UserDefaults.standard.set(true, forKey: "status")
                guard let userId = res?.user.uid else { return }
                self?.currentUserId = userId
                completion(.success(true))
            }
        }
    }

    func signOut(completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "status")
            isSignedIn = false
            completion(.success(true))
        } catch {
            completion(.failure(NetworkError.fail))
        }
    }
}


