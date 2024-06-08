# cycling.ai  for iOS
   
cycling.ai for iOS is an iOS app designed as a companion for the cycling.ai web app. We unleash the power of Sahha AI to retrieve health data from users and use this information to serve them better and more powerful recommendations. This app includes various views and functionalities such as authentication, demographic information, analysis view, and QR code scanning to link your iPhone to the web. This project is a fork of the Sahha iOS demo app, with additional features layered on top.
   
## Features  
   
- **Authentication**: Handles user login and registration through `AuthenticationView.swift`.  
- **Demographic Information**: Displays and collects basic user information via `DemographicView.swift`.  
- **Analysis**: Analyzes and displays cycling data using `AnalyzationView.swift`.  
- **QR Code Scanning**: Provides a scanning feature for quick information retrieval through `QRCodeScannerView.swift`.  
   
## File Structure  
   
- `AnalyzationView.swift`: Code for the analysis view.  
- `AuthenticationView.swift`: Code for the authentication view.  
- `DemographicView.swift`: Code for the demographic information view.  
- `cyclingaiApp.swift`: Main entry point for the application.  
- `Extensions.swift`: Code for various extensions.  
- `Info.plist`: Configuration information for the application.  
- `QRCodeScannerView.swift`: Code for the QR code scanning view.  
- `country_codes.json`: Data mapping country codes to country names.  
- Multiple `Contents.json`: Configuration for image resources for different devices and screen sizes.  
   
## Installation  
   
1. Clone this repository to your local machine:  
    ```bash  
    git clone https://github.com/AllStars101-sudo/cycling.ai-ios.git
    ```  
2. Open the project in Xcode:  
    ```bash  
    open cyclingai.xcodeproj  
    ```  
3. Install the necessary dependencies (if any):  
    ```bash  
    pod install  
    ```  
   
## Usage  
   
1. Select a simulator or connected device in Xcode.  
2. Run the application by clicking the run button or using the shortcut `Cmd+R`.  
   
## Contributing  
   
We welcome contributions of any kind! You can participate in the project by submitting issues or pull requests.  
   
1. Fork this repository.  
2. Create your feature branch:  
    ```bash  
    git checkout -b feature/YourFeature  
    ```  
3. Commit your changes:  
    ```bash  
    git commit -m 'Add some feature'  
    ```  
4. Push to the branch:  
    ```bash  
    git push origin feature/YourFeature  
    ```  
5. Open a pull request.  
 
   
## Contact  
   
If you have any questions or suggestions, please contact us at:  

- GitHub Issues page  
   
---  
   
# Sahha Demo App for iOS  
   
We are incredibly grateful to Sahha for their generous support, which has made this project possible. The Sahha Demo App provides a convenient way to try the features of the Sahha API and SDK.  
   
## API  
   
The Sahha API provides a convenient way to analyze health patterns.  
   
[Sahha API]([https://developer.sahha.ai/reference)](https://developer.sahha.ai/reference))  
   
## SDK  
   
The Sahha SDK provides a convenient way for mobile apps to connect to the Sahha API.  
   
[Sahha SDK]([https://developer.sahha.ai/docs)](https://developer.sahha.ai/docs))  
   
---  
   
Copyright © 2022 Sahha. All rights reserved.
