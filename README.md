#fluttr Mobile Application
1)Project Overview: This application developed for only a basic assignment purpose and this mobile application is beaing developed using flutter frame work .
                     this project consits of Splash Screen,and splash screen is navigated to login screen ,where it asks for phone no or em,ail and user can choose it when the credentials are given it directs to otp verification screen .
If the verificatiojn is succesfull then its navuigates to the Hoe Page if the verification faild the user can register thair Account in Signup page or screen where it asks for email phone no,Password and refferal 'if available '.
2)Screenshots of the application: dailydray mobile application screenshot s.pdf   
3)Installation: For installing this application you need an Platform like Android Studio or Vs coder or any other ,and mainly uyou need have Flutter Packages on your Machine.
From this repository you download all the files or directories and then set the path and then you can run the application .
(these is a relasesapk also provided in this application it be downloaded in yor mobile device)
*The application starts with the main() function in the main.dart file, where the MyApp widget is instantiated and launched.
*In the MyApp widget, the MaterialApp is used to define the root of the widget tree, and the HomeScreen is set as the home page.
4)API Integration: 
*API requests are made at various stages of the application, such as during login, OTP verification, etc.
*For example, in the LoginScreen, when the user taps on the "Send Code" button, the _sendCode() method is triggered.
*Inside _sendCode(), an HTTP POST request is made to the specified API endpoint (http://devapiv3.dealsdray.com/api/v2/user/otp) to send a verification code to the user's phone or email.
*The request includes necessary parameters like the user's phone number or email, and a device ID.
**)Handling API Responses:
*After making the API request, the application awaits the response asynchronously using await.
*Upon receiving the response, the application checks the status code (response.statusCode) to determine if the request was successful.
If the status code is 200 (OK), it indicates a successful response, and appropriate actions are taken. For example, navigating to the OTP verification screen.
If there's an error or the status code indicates a failure, the application displays an error dialog to the user, informing them of the issue.
5)Contact: karuturijagadesh@gmail.com  //  +91  6362033832 
