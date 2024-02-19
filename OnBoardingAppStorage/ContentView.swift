//
//  ContentView.swift
//  OnBoardingAppStorage
//
//  Created by Tony Chen on 2/2/2024.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("signed_in") var currentSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.purple, Color.blue]),
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea(.all)
            
            if currentSignedIn {
                ProfileView().transition(.asymmetric(
                    insertion: .move(edge: .bottom),
                    removal: .move(edge: .top)))
            } else {
                //Text("Onboarding")
                OnboardingView().transition(.asymmetric(
                    insertion: .move(edge: .top),
                    removal: .move(edge: .bottom)))
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
