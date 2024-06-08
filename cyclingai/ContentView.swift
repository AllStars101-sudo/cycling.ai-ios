// Copyright © 2022 Sahha. All rights reserved.

import SwiftUI
import Sahha

struct ContentView: View {
    
    @State var sensorStatus: SahhaSensorStatus = .pending
        @State var showQRScanner = false
        @State var userId: String?
    @State var iPhoneUUID: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
    func linkIPhoneToUser() {
            guard let userId = userId else { return }
            
            // Store the iPhone UUID and user ID in Supabase
            let url = URL(string: "\(Config.supabaseProjectURL)/rest/v1/user_devices")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(Config.supabaseAPIKey, forHTTPHeaderField: "apikey")
            let body: [String: Any] = [
                "user_id": userId,
                "device_id": iPhoneUUID
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error linking iPhone to user: \(error.localizedDescription)")
                } else {
                    print("iPhone linked to user successfully")
                }
            }.resume()
        }
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Spacer()
                    Image("Icon").resizable().frame(width: 120, height: 120, alignment: .center)
                    Spacer()
                }
                Section(header: Text("PROFILE")) {
                    NavigationLink {
                        AuthenticationView()
                    } label: {
                        HStack {
                            Image(systemName: "lock.fill")
                            Text("Authentication")
                        }
                    }
                    NavigationLink {
                        DemographicView()
                    } label: {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("Demographic")
                        }
                    }
                }
                Section(header: Text("LINKING")) {
                                    Button {
                                        showQRScanner = true
                                    } label: {
                                        HStack {
                                            Image(systemName: "qrcode.viewfinder")
                                            Text("Link to User ID")
                                        }
                                    }
                                    .sheet(isPresented: $showQRScanner) {
                                        QRCodeScannerView(userId: $userId)
                                    }
                                    
                    if let userId = userId {
                                    Text("Linked User ID: \(userId)")
                                    Button("Link iPhone to User") {
                                        linkIPhoneToUser()
                                    }
                                }
                                }
                Section(header: Text("SENSORS")) {
                    Picker("Sensor Status", selection: .constant(sensorStatus.rawValue)) {
                        Text("Pending").tag(0)
                        Text("Unavailable").tag(1)
                        Text("Disabled").tag(2)
                        Text("Enabled").tag(3)
                    }.onAppear {
                        Sahha.getSensorStatus { error, status in
                            sensorStatus = status
                        }
                    }
                    if sensorStatus == .pending {
                        Button {
                            Sahha.enableSensors { error, status in
                                sensorStatus = status
                                print("Sahha | Sensor status:", sensorStatus.description)
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Text("Enable")
                                Spacer()
                            }
                        }
                    } else {
                        Button {
                            Sahha.openAppSettings()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Open App Settings")
                                Spacer()
                            }
                        }
                        Button {
                            //Sahha.testData()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Test Data")
                                Spacer()
                            }
                        }
                    }
                }
                Section(header: Text("DATA")) {
                    NavigationLink {
                        AnalysisView()
                    } label: {
                        HStack {
                            Image(systemName: "brain.head.profile")
                            Text("Analysis")
                        }
                    }
                    NavigationLink {
                        WebView(url: URL(string: "https://webview.sahha.ai/app")!, profileToken: Sahha.profileToken, userId: userId)
                            .ignoresSafeArea()
                            .navigationTitle("Insights")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        HStack {
                            Image(systemName: "wand.and.stars")
                            Text("Insights")
                        }
                    }
                }
                Section(header: Text("Surveys")) {
                    NavigationLink("TypeForm") {
                        WebView(url: URL(string: "https://p7g2dr2gsxx.typeform.com/to/uUNXxdxn#inference_id=ABC123")!)
                            .ignoresSafeArea()
                            .navigationTitle("TypeForm")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    NavigationLink("Tally") {
                        WebView(url: URL(string: "https://tally.so/r/mRMeG9?inference_id=ABC123")!)
                            .ignoresSafeArea()
                            .navigationTitle("Tally")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                Section(header: Text("Errors")) {
                    Button {
                        let body = "isProtectedDataAvailable : \(UIApplication.shared.isProtectedDataAvailable.description)"
                        Sahha.postError(message: "TEST", path: "content", method: "test", body: body)
                    } label: {
                        Text("ERROR")
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

import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    var profileToken: String?
    var userId: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        var request = URLRequest(url: url)
        if let token = profileToken {
            request.setValue(token, forHTTPHeaderField: "AUTH")
        }
        if let userId = userId {
            request.setValue(userId, forHTTPHeaderField: "USER_ID")
        }
        webView.load(request)
    }
}
