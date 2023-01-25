# FirebaseAuthWrapper-CombineiOS

FirebaseAuthWrapper is a wrapper class that provides an easy and convenient way to interact with the Firebase Auth services. The class is written in Swift and uses the Combine framework for handling asynchronous events.

Please see SampleUsage for more details on how to implement

## Features

- Sign in with email and password
- Sign up with email and password
- Sign out
- Listen to auth state changes

## Installation

### Swift Package Manager

You can install `FirebaseAuthWrapper-CombineiOS` using the [Swift Package Manager](https://swift.org/package-manager/).

1. In Xcode, open your project and navigate to File > Swift Packages > Add Package Dependency.
2. Enter the repository URL `https://github.com/vGebs/FirebaseAuthWrapper-CombineiOS.git` and click Next.
3. Select the version you want to install, or leave the default version and click Next.
4. In the "Add to Target" section, select the target(s) you want to use `FirebaseAuthWrapper-CombineiOS` in and click Finish.

To use FirebaseAuthWrapper in your project, you need to have:
- Firebase Auth and 
- Combine frameworks. 

You can add them to your project by following the instructions in the Firebase documentation and Apple documentation

## Usage

### Sign in 

```swift
let email = "example@email.com"
let password = "examplepassword"

FirebaseAuthWrapper.shared.signIn(email, password)
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            print(error)
        case .finished:
            break
        }
    }, receiveValue: { [weak self] authDataResult in
        // do something with authDataResult
        // for example, set the current user
        self?.user = authDataResult.user
    })
    .store(in: &cancellableSet)

```

### Sign up

```swift
let email = "example@email.com"
let password = "examplepassword"

FirebaseAuthWrapper.shared.signUp(email, password)
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            print(error)
        case .finished:
            break
        }
    }, receiveValue: { [weak self] authDataResult in
        // do something with authDataResult
                // for example, set the current user
        self?.user = authDataResult.user
    })
    .store(in: &cancellableSet)
```

### Sign out

```swift 
FirebaseAuthWrapper.shared.signOut()
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            print(error)
        case .finished:
            break
        }
    }, receiveValue: { [weak self] _ in
        // do something after sign out
        self?.user = nil
    })
    .store(in: &cancellableSet)
```

### Listen to Auth state changes

```swift
FirebaseAuthWrapper.shared.listen()
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            print(error)
        case .finished:
            break
        }
    }, receiveValue: { [weak self] auth in
        self?.user = auth.currentUser
    })
    .store(in: &cancellableSet)
```

## Note

It's important to note that this is just an example, depending on your implementation and the architecture of your app, the FirebaseAuthWrapper class could have more or less functionality and it is up to you to implement it in a way that fits your app.

## License 

This project is licensed under the MIT License - see the LICENSE file for details

## Contribution

If you want to contribute to this project, please follow these guidelines:

- Fork the repository and make the changes on your fork
- Test your changes to make sure they don't break existing functionality
- Create a pull request to the development branch of this repository

Please note that by contributing to this project, you agree to the terms and conditions of the MIT License.

Also, please make sure to follow the code of conduct when contributing.
