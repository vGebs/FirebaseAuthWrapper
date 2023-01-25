import FirebaseAuth
import Combine

class FirebaseAuthWrapperCombine {
    
    static let shared = FirebaseAuthWrapperCombine()
    
    private init() {  }
    
    // MARK: - Sign In

    func signIn(_ email: String, _ password: String) -> AnyPublisher<AuthDataResult, Error> {
        return Future { promise in
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let error = error {
                    promise(.failure(error))
                } else if let authResult = authResult {
                    promise(.success(authResult))
                }
            }
        }.eraseToAnyPublisher()
    }

    // MARK: - Sign Up

    func signUp(_ email: String, _ password: String) -> AnyPublisher<AuthDataResult, Error> {
        return Future { promise in
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if let error = error {
                    promise(.failure(error))
                } else if let authResult = authResult {
                    promise(.success(authResult))
                }
            }
        }.eraseToAnyPublisher()
    }

    // MARK: - Sign Out

    func signOut() -> AnyPublisher<Void, Error> {
        return Future { promise in
            do {
                try Auth.auth().signOut()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    // MARK: - State Changes

    func listen() -> AnyPublisher<Auth, Never> {
        return AuthStatePublisher().eraseToAnyPublisher()
    }
}

