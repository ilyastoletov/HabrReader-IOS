//
//  SplashScreen.swift
//  Habr Client
//
//  Created by Ilya Stoletov on 08.03.2024.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        let onboardingIsShown = UserDefaults.standard.bool(forKey: "onboarding_shown")
        
        if !onboardingIsShown {
            OnboardingScreen()
        } else {
            ArticlesListScreen()
        }
    }
}

#Preview {
    SplashScreen()
}
