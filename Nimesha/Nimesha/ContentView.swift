//
//  ContentView.swift
//  Nimesha
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var utils = AppUtils();
    
    var body: some View {
        
        TabView(selection: $utils.select) {
            HomeView(utils: utils)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(1)
            if(utils.authorized){
                BookingView(utils: utils).tabItem {
                            Image(systemName: "book")
                            Text("Booking")
                    }.tag(2)
                SettingView(utils: utils).tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }.tag(3)
            }else{
                if(utils.view=="login"){
                    SignInView(utils: utils).tabItem {
                                Image(systemName: "person")
                                Text("Login")
                        }.tag(4)
                }else if(utils.view=="reg"){
                    RegisterView(utils: utils).tabItem {
                                Image(systemName: "person")
                                Text("Register")
                            }.tag(5)

                }else if(utils.view=="password"){
                    PasswordView(utils: utils).tabItem {
                                Image(systemName: "person")
                                Text("Password Reset")
                            }.tag(6)
                }
            }
        }
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
