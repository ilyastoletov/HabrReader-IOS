//
//  OnboardingView.swift
//  Habr Client
//
//  Created by Ilya Stoletov on 14.02.2024.
//

import SwiftUI

private struct OnboardingPage : Identifiable, Hashable {
    var id: Int
    let imageAssetName: String
    let title: String
    let description: String
}

struct OnboardingScreen: View {
    
    private let pagesList: [OnboardingPage] = [
        OnboardingPage(
            id: 0,
            imageAssetName: "logo",
            title: "Будь в ритме хабра",
            description: "Узнавай новости площадки каждый день, прямо в своем смартфоне!"
        ),
        OnboardingPage(
            id: 1,
            imageAssetName: "logo",
            title: "Example text",
            description: "It's a very very example text provided by devevloper"
        ),
        OnboardingPage(
            id: 2,
            imageAssetName: "logo",
            title: "Test",
            description: "Very test page"
        ),
        OnboardingPage(
            id: 3,
            imageAssetName: "logo",
            title: "Sooo test",
            description: "It's so test that I can't even say how much test it is!"
        ),
    ]
    
    @ScaledMetric private var screenElementsMargin = 150
    
    @State private var currentElementIndex: Int = 0
    @State private var buttonLabel: String = "Далее"
    
    var body: some View {
        var pageIsLast: Bool = false
        ZStack(alignment: .bottom) {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
                TabView(selection: $currentElementIndex) {
                    ForEach(pagesList) { page in
                        OnboardingPageView(page: page)
                            .tag(page.id)
                    }
                }
                .frame(maxHeight: 350)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: currentElementIndex) { _ in
                    pageIsLast = (currentElementIndex == (pagesList.endIndex - 1))
                    buttonLabel = !pageIsLast ? "Далее" : "В приложение"
                }
                
                PageIndicator(
                    pagesCount: pagesList.count,
                    activeIndex: $currentElementIndex
                )
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
            )
            .padding(.horizontal)
            
            GoNextButton(
                onClick: {
                    if !pageIsLast {
                        currentElementIndex += 1
                    }
                },
                label: $buttonLabel
            )
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 20,
                    trailing: 0
                )
            )
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
        .background(Colors.mainHue)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}

private struct OnboardingPageView: View {
    
    var page: OnboardingPage
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Image(page.imageAssetName)
                .resizable()
                .frame(width: 128, height: 128)
            
            Text(page.title)
                .bold()
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .font(.custom("Montserrat-Bold", size: 30))
            
            Text(page.description)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .font(.custom("Montserrat-Medium", size: 18))
        }
        .frame(minWidth: 0, maxWidth: 350)
    }
}

private struct PageIndicator: View {
    
    var pagesCount: Int;
    @Binding var activeIndex: Int;
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<pagesCount) { pageNumber in
                let backgroundColor = if (activeIndex == pageNumber) { SwiftUI.Color.white
                } else {
                    Colors.disabledIndicatorColor
                }
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(backgroundColor)
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: 20
        )
    }
    
}

private struct GoNextButton: View {
    
    var onClick: () -> Void
    @Binding var label: String
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .frame(
                    width: 250,
                    height: 60
                )
                .foregroundColor(Colors.lightBlue)
            Text(label)
                .foregroundColor(SwiftUI.Color.white)
        }
        .onTapGesture { onClick() }
    }
}

#Preview {
    OnboardingScreen()
}
