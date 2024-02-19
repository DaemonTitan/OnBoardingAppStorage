//
//  OnboardingView.swift
//  OnBoardingAppStorage
//
//  Created by Tony Chen on 3/2/2024.
//

import SwiftUI

struct OnboardingView: View {
    
    // Onboarding states:
    /*
     0 - Welcome screen
     1 - Add name
     2 - Add age
     3 - Add gender
     */
    @State var onboardingState: Int = 0
    
    // Onboarding
    @State var nameField: String = ""
    @State var age: Double = 18
    @State var gender: String = ""
    
    // Alert
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var transaction: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    // app storage
    @AppStorage("name") var userName: String?
    @AppStorage("age") var userAge: Int?
    @AppStorage("gender") var userGender: String?
    @AppStorage("signed_in") var currentSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            ZStack {
                switch onboardingState {
                case 0:
                    welcomeSection.transition(transaction)
                case 1:
                    addNamesection.transition(transaction)
                case 2:
                    addAgeSection.transition(transaction)
                case 3:
                    addGenderSection.transition(transaction)
                default:
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(.red)
                }
            }
            
            VStack {
                Spacer()
                bottomButton

            }
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") {}
        }
    }
}

// MARK: Compoents
extension OnboardingView {
    private var bottomButton: some View {
        Text(onboardingState == 0 ? "SIGN UP" :
             onboardingState == 3 ? "FINISH" :
             "NEXT")
            .font(.headline)
            .foregroundStyle(.purple)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            .padding(30)
            .transaction { transaction in
                transaction.animation = nil
            }
            .onTapGesture {
                handleNextButtonPressed()
            }
    }
    
    private var welcomeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundStyle(.white)
            Text("Find your match.")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .overlay(alignment: .bottom) {
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .foregroundStyle(.white)
                        .offset(y: 5)
                }
            Text("This is the #1 app for finding your match online! In this app we are using AppStorage and other SwiftUI functions")
                .fontWeight(.medium)
                .foregroundStyle(.white)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }
    
    private var addNamesection: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("What's your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            TextField("Your name here...", text: $nameField)
                .font(.headline)
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addAgeSection: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("What's your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            Text("\(String(format: "%.0f", age))")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            Slider(value: $age, in: 18...100, step: 1)
                .tint(.white)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addGenderSection: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("What's your gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            VStack {
                Text(gender.count > 1 ? "Gender is \(gender)" : "Select gender" )
                    .font(.headline)
                    .foregroundStyle(.purple)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                
                Picker(selection: $gender) {
                    Text("").tag("Empty")
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                    Text("Non-Binary").tag("Non-Binary")
                } label: {
                    Text("Picker")
                }
                .colorMultiply(Color.primary)
                .pickerStyle(MenuPickerStyle())
            }
            Spacer()
            Spacer()
        }
        .padding(30)
    }
}

// MARK: Functions
extension OnboardingView {
    func handleNextButtonPressed() {
        // Check inputs
        switch onboardingState {
        case 1:
            guard nameField.count >= 3 else {
                showAlert(title: "Type your name 😏")
                return
            }
        case 3:
            guard gender.count > 1 else {
                showAlert(title: "Please select dender")
                return
            }
        default:
            break
        }
        
        // Go to Next Section
        if onboardingState == 3 {
            // Sign in
            signIn()
        } else {
            withAnimation {
                onboardingState += 1
            }
        }
    }
    
    func signIn() {
        userName = nameField
        userAge = Int(age)
        userGender = gender
        
        withAnimation {
            currentSignedIn = true
        }
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
    
}

#Preview {
    OnboardingView().background(Color.purple)
}
