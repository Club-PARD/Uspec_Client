//
//  AppleLoginManager.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/12/24.
//
import UIKit
import AuthenticationServices

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
//            let userFirstName = appleIDCredential.fullName?.givenName
//            let userLastName = appleIDCredential.fullName?.familyName
            let userEmail = appleIDCredential.email
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    print("authorized")
                    print(userIdentifier)
                    print(credentialState)
                    print("userEmail = \(String(describing: userEmail))")
                    break
                case .revoked:
                    print("revoked")
                    print(userIdentifier)
                    print(credentialState)
                    print("userEmail = \(String(describing: userEmail))")
                    break
                case .notFound:
                    print("notFound")
                    print(userIdentifier)
                    print(credentialState)
                    print("userEmail = \(String(describing: userEmail))")
                    break
                default:
                    print("default")
                    print(userIdentifier)
                    print(credentialState)
                    print("userEmail = \(String(describing: userEmail))")
                    break
                }
            }
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}


extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
