//
//  ProfileView.swift
//  OnBoardingAppStorage
//
//  Created by Tony Chen on 5/2/2024.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("name") var userName: String?
    @AppStorage("age") var userAge: Int?
    @AppStorage("gender") var userGender: String?
    @AppStorage("signed_in") var currentSignedIn: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            HStack {
                Text("Name: ")
                Text(userName ?? "Your name")
            }
            HStack {
                Text("Age: ")
                Text("\(userAge ?? 0)")
            }
            HStack {
                Text("Gender: ")
                Text(userGender ?? "Unknow")
            }
            
            Text("Sign out")
                .foregroundStyle(.white)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    signOut()
                }
        }
        .font(.title)
        .foregroundStyle(.purple)
        .padding()
        .padding(.vertical, 40)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 10)
    }
    
    func signOut() {
        userName = nil
        userAge = nil
        userGender = nil
        
        withAnimation {
            currentSignedIn = false
        }
    }
}

#Preview {
    ProfileView()
}
