//
//  AuthViewModel.swift
//  Dbum-Fitness
//
//  Created by iMac on 11/3/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    
    let id: String
    let username: String
    let email: String
    let password: String
}

protocol AuthenFormProtocol {
    var formIsValid: Bool {get}
}



@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        
        Task{
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }
        catch{
            print("DEBUG: Failed to log in with erorr \(error.localizedDescription)")
        }
        
        
    }
    
    func createUser(withEmail email: String, password: String, username: String) async throws {
        
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, username: username, email: email, password: password)
            let encodeUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodeUser)
            await fetchUser()
        }catch{
            print("DEBUG: Failed To Create User with error \(error.localizedDescription)")
        }
        
        
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            
        }
        catch{
            print("DEBUG: Failed to sign out with error")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
