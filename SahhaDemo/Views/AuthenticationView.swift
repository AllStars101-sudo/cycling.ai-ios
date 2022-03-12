// Copyright © 2022 Sahha. All rights reserved.

import SwiftUI
import Sahha

struct AuthenticationView: View {
    @State var customerId: String = ""
    @State var profileId: String = ""
    @State var token: String = ""
    
    var isLoginDisabled: Bool {
        customerId.isEmpty || profileId.isEmpty
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "lock.fill")
                    Text("Authentication")
                    Spacer()
                }.font(.title)
            }
            Section(header: Text("Account")) {
                TextField("Customer ID", text: $customerId).autocapitalization(.none)
                TextField("Profile ID", text: $profileId).autocapitalization(.none)
            }
            .onAppear {
                getCredentials()
            }
            if token.isEmpty == false {
                Section {
                    Button {
                        hideKeyboard()
                        Sahha.deleteCredentials()
                        getCredentials()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Logout")
                            Spacer()
                        }
                    }
                }
                Section(header: Text("Token")) {
                    Text(token).contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = token
                        }) {
                            Text("Copy")
                        }
                    }
                }
            } else {
                Section {
                    Button {
                        hideKeyboard()
                        Sahha.authenticate(customerId: customerId, profileId: profileId) { value in
                            token = value
                            setCredentials()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Login")
                            Spacer()
                        }
                    }.disabled(isLoginDisabled)
                }
            }
        }
    }
    
    func getCredentials() {
        let credentials = Sahha.getCredentials()
        customerId = credentials.customerId
        profileId = credentials.profileId
        token = credentials.token
    }
    
    func setCredentials() {
        Sahha.authenticate(customerId: customerId, profileId: profileId, token: token)
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(customerId: "ABC", profileId: "123")
    }
}
