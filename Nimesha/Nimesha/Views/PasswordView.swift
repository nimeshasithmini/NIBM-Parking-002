//
//  PasswordView.swift
//  Nimesha
//

import SwiftUI

struct PasswordView: View {
    @State var email = "";
    
    @ObservedObject var utils : AppUtils
    @State private var alert: MyAlert?;
    
    var userController = UserController();
    
    var body: some View {
        Color("AppBackground").overlay(
            VStack(alignment: .center){
                
                Text("Email")
                    .font(.title)
                TextField("",text: $email)
                    .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
                
                VStack{
                      Button(action:{
                        userController.forget(email: email) {(success) in
                            if(success){
                                alert = MyAlert(message: "Success");
                                utils.select = 4
    
                            }
                        }
                            
                      }, label:{
                        Text("Submit").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.541, saturation: 0.996, brightness: 0.362)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                      }).alert(item: $alert) { con in
                        Alert(title: Text(con.message))
                    }.padding(.top, 5.0)
                    
                      Spacer()
                      Button(action:{
                        utils.view = "login"
                        utils.select = 4
                      }, label:{
                        Text("Back").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 150.0, height: 30.0).background(Color(hue: 0.272, saturation: 0.956, brightness: 0.24)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                      })
                      .padding(.bottom, 100.0)
                }
        
        
            }
            .padding(.top, 30.0)
        
        ).edgesIgnoringSafeArea(.all)
        
              
    }
}

//struct PasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        PasswordView()
//    }
//}
