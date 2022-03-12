// Copyright © 2022 Sahha. All rights reserved.

import SwiftUI

struct ProfileView: View {
    
    @State var age: Int = 0
    @State var countries: [String: String] = [:]
    @State var country: String = ""
    let genders: [String] = ["Male", "Female", "Gender Diverse"]
    @State var gender: String = ""
    var isUpdateButtonDisabled: Bool {
        age == 0 || country.isEmpty || gender.isEmpty
    }
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "person.fill")
                    Text("Profile")
                    Spacer()
                }.font(.title)
            }
            Section {
                TextField("Enter Your Age", value: $age, formatter: NumberFormatter()).keyboardType(.numbersAndPunctuation)
            } header: {
                Text("Age")
            }
            Section {
                Picker("Select", selection: $gender) {
                    ForEach(genders, id: \.self) { value in
                        Text(value).tag(value)
                    }
                }.navigationBarTitle("Gender")
            } header: {
                Text("Gender")
            }
            Section {
                Picker("Select", selection: $country) {
                    ForEach(countries.sorted{$0.value < $1.value}, id: \.key) { key, value in
                        Text(value).tag(key)
                    }
                }
            } header: {
                Text("Country")
            }
            Section {
                Button {
                    
                } label: {
                    HStack {
                        Spacer()
                        Text("Update")
                        Spacer()
                    }
                }.disabled(isUpdateButtonDisabled)
            }
            
        }.onAppear {
            if let jsonFile = Bundle.main.url(forResource: "country_codes", withExtension: "json"), let jsonData = try? Data(contentsOf: jsonFile), let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []), let jsonDictionary = jsonObject as? [String: String] {
                countries = jsonDictionary
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
