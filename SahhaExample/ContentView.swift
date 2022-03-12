// Copyright © 2022 Sahha. All rights reserved.

import SwiftUI
import Sahha

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Spacer()
                    Image("Icon").resizable().frame(width: 120, height: 120, alignment: .center)
                    Spacer()
                }
                NavigationLink {
                    AuthenticationView()
                } label: {
                    HStack {
                        Image(systemName: "lock.fill")
                        Text("Authentication")
                    }
                }
                NavigationLink {
                    ProfileView()
                } label: {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }
                NavigationLink {
                    HealthView()
                } label: {
                    HStack {
                        Image(systemName: "heart.fill")
                        Text("Health Activity")
                    }
                }
                NavigationLink {
                    MotionView()
                } label: {
                    HStack {
                        Image(systemName: "figure.walk")
                        Text("Motion Activity")
                    }
                }
                NavigationLink {
                    AnalyzationView()
                } label: {
                    HStack {
                        Image(systemName: "brain.head.profile")
                        Text("Analyzation")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
