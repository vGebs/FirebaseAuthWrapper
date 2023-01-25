//
//  File.swift
//  
//
//  Created by Vaughn on 2023-01-25.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    @StateObject var auth = Auth()
    
    var body: some View {
        VStack {
            if auth.user == nil {
                Button(action{
                    auth.logIn()
                }) {
                    Text("Log in")
                }.padding()
                
                Button(action: {
                    auth.signUp()
                }) {
                    Text("Sign up")
                }.padding()
            } else {
                Button(action: {
                    auth.signOut()
                }) {
                    Text("Sign out")
                }.padding()
            }
        }
    }
}
