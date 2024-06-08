// Copyright © 2022 Sahha. All rights reserved.

import SwiftUI
import Sahha

struct AnalysisView: View {
    
    @State var analysisString: String = ""
    @State var isAnalyzeButtonEnabled: Bool = true
    
    func storeHealthData(_ healthData: String) {
            guard let userId = Sahha.profileToken else { return }
            
            // Store the health data in Supabase
            let url = URL(string: "\(Config.supabaseProjectURL)/rest/v1/user_health_data")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(Config.supabaseAPIKey, forHTTPHeaderField: "apikey")
            let body: [String: Any] = [
                "user_id": userId,
                "health_data": healthData
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error storing health data: \(error.localizedDescription)")
                } else {
                    print("Health data stored successfully")
                }
            }.resume()
        }

    func getAnalysisForToday() {
        analysisString = "Waiting..."
        isAnalyzeButtonEnabled = false
        Sahha.analyze() { error, json in
            isAnalyzeButtonEnabled = true
            if let error = error {
                print(error)
            }
            else if let json = json {
                print(json)
                analysisString = json
                storeHealthData(json)
            }
        }
    }
    
    func getAnalysisForThisWeek() {
        analysisString = "Waiting..."
        let today = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: today) ?? Date()
        Sahha.analyze(dates: (sevenDaysAgo, today)) { error, json in
            isAnalyzeButtonEnabled = true
            if let error = error {
                print(error)
            }
            else if let json = json {
                print(json)
                analysisString = json
                storeHealthData(json)
            }
        }
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "brain.head.profile")
                    Text("Analyzation")
                    Spacer()
                }.font(.title)
            }
            Section {
                Text("A new analysis will be available every 24 hours. If an analysis is empty {}, it means more sensor data must be collected. Try again in 24 hours. ").font(.caption).multilineTextAlignment(.center)
            }
            if isAnalyzeButtonEnabled {
                Section {
                    Button {
                        getAnalysisForToday()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Analyze Previous 24 Hours")
                            Spacer()
                        }
                    }
                }
                Section {
                    Button {
                        getAnalysisForThisWeek()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Analyze Previous Week")
                            Spacer()
                        }
                    }
                }
            }
            if analysisString.isEmpty == false {
                Section {
                    ScrollView(.horizontal) {
                        Text(analysisString).font(.caption)
                    }
                } header : {
                    HStack {
                        Spacer()
                        Text("Analysis")
                        Spacer()
                    }
                }
            } else {
                Section {
                    ScrollView(.horizontal) {
                        Text("""
    {
        "inferences": [
            {
                "createdAt": "2022-06-09T00:30:00+00:00",
                "modelName": "automl_toolkit_randomForest",
                "predictionState": "not_depressed",
                "predictionSubState": "",
                "predictionRange": -1,
                "predictionConfidence": 0.8,
                "dataSource": [
                    "sleep",
                    "screenTime"
                ]
            }
        ]
    }
    """).font(.caption)
                    }
                } header : {
                    HStack {
                        Spacer()
                        Text("Sample Analysis")
                        Spacer()
                    }
                }
            }
        }
    }
}

struct AnalyzationView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
    }
}
