//
//  RegisterView.swift
//  Nimesha
//

import SwiftUI

struct RegisterView: View {
    @State var name = "";
    @State var vehicle_no = "";
    @State var email = "";
    @State var nic = "";
    @State var password = "";
    
    @ObservedObject var utils : AppUtils
    @State private var alert: MyAlert?;
    
    var userController = UserController();
    
    var body: some View {
        Color("AppBackground").overlay(
            GeometryReader{ geometry in
                
                ScrollView(.vertical){
                    VStack(alignment: .center){
                      
                        VStack{
                            Text("Email").font(.title)
                            TextField("",text: $email).keyboardType(.emailAddress)                    .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
                            
                            Text("Password").font(.title)
                            SecureField("",text: $password)
                                .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
                        }.padding(.top, 20.0)
                        
                        Text("Name").font(.title)
                        TextField("",text: $name)
                            .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
                        
                        Text("NIC").font(.title)
                        TextField("",text: $nic)
                            .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
                        
                        Text("Vehicle Number").font(.title)
                        TextField("",text: $vehicle_no)
                            .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
                        VStack{
                               
                              Button(action:{
                                                                
                                if(email.isEmpty){
                                    alert = MyAlert(message: "Invalid Email");
                                    return;
                                }
                                if(password.isEmpty){
                                    alert = MyAlert(message: "Please Enter Password");
                                    return;
                                }
                                if(name.isEmpty){
                                    alert = MyAlert(message: "Please Enter Name");
                                    return;
                                }
                                if( nic.isEmpty){
                                    alert = MyAlert(message: "Please Enter NIC");
                                    return;
                                }
                                if(vehicle_no.isEmpty){
                                    alert = MyAlert(message: "Please Enter Vehicle No");
                                    return;
                                }

                                userController.add_user(email: email, password: password, name: name, veh_no: vehicle_no, nic: nic) {(success) in
                                    if(success){
                                        alert = MyAlert(message: "Success");
                                        utils.select = 4
                                    }else{
                                        alert = MyAlert(message: "Failed");
                                    }

                                }
                                
                                
                              }, label:{
                                  Text("Sign Up").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.541, saturation: 0.996, brightness: 0.362)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                              }).alert(item: $alert) { con in
                                Alert(title: Text(con.message))
                            }.padding(.top, 5.0)
                              
                              Button(action:{
                                utils.authorized = false
                                utils.view = "login"
                                utils.select = 4
                              }, label:{
                                Text("Login").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 150.0, height: 40.0).background(Color(hue: 0.272, saturation: 0.956, brightness: 0.24)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                              })
                              .padding(.top, 20.0)
                        }
                        
                    }.frame(width: geometry.size.width)
                
            }
            

            }
        ).edgesIgnoringSafeArea(.all)
    }
}

//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
