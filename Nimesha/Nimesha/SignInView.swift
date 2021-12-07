//
//  SignInView.swift
//  Nimesha
//

import SwiftUI

struct SignInView: View {
    @State var email = "";
    @State var password = "" ;
    
    @ObservedObject var setting : AppUtils
    @State private var alert: MyAlert?;
    
    var userController = UserController();
    
    var body: some View {
        Color("AppBackground").overlay(
            VStack(alignment: .center){
                Text("Email")
                    .font(.title)
                    .multilineTextAlignment(.center)
                TextField("",text: $email).keyboardType(.emailAddress).accessibility(identifier: "email")
                    .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
                Text("Password")
                    .font(.title)
                    .padding(.top, 10.0)
                SecureField("",text: $password).accessibility(identifier: "password")
                    .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
                
                Button(action:{
                    userController.login(email: email, password: password) {(success) in

                        if(success){
                            print(success)
                            setting.authorized = success
                            setting.select = 1
                        }else{
                            alert = MyAlert(message: "Invalid Email or Password");
                        }
                    }
                    
                }, label:{
                    Text("Sign In").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.541, saturation: 0.996, brightness: 0.362)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                }).alert(item: $alert) { con in
                    Alert(title: Text(con.message))
                }.padding(.top, 20.0)
                
                Button(action:{
                    
                    setting.view = "reg"
                    setting.select = 5;
                }, label:{
                    Text("Sign Up").font(.title).fontWeight(.medium).foregroundColor(.white).padding().frame(width: 150.0, height: 40.0).background(Color(hue: 0.272, saturation: 0.956, brightness: 0.24)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                })
                .padding(.top, 30.0)
                
                
                Spacer()
                
                Button(action:{
                    setting.view = "password"
                    setting.select = 6;
                }, label:{
                    Text("Forget Password").fontWeight(.semibold).padding()
                })

                Button(action:{
                    
                }, label:{
                    Text("Terms & Conditions").fontWeight(.regular).padding()
                })

            }
            .padding(50.0)
            .onAppear {
                
               // self.getUserData()
                
            
            }
        ).edgesIgnoringSafeArea(.all)
    }
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}
