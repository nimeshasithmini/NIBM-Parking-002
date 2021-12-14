//
//  SettingView.swift
//  Nimesha
//

import SwiftUI

struct SettingView: View {
    @State var name = "";
    @State var vehicle_no = "";
    @State var email = "";
    @State var nic = "";
    @State var reg_number = "";
    
   // @State var isLoad = false;
    
    @ObservedObject var utils : AppUtils
    
    var userController = UserController();
    
    var body: some View {
        Color("AppBackground").overlay(
            VStack{
                Text("Personal Info")
                    .fontWeight(.bold).padding(.top, 50.0)
                HStack( spacing: 50){
                    VStack(alignment: .leading){
                        Text("Name")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 15.0)
                        Text("NIC")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 30.0)
                        Text("Reg No")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 30.0)
                        Text("Vehicle No")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 30.0)
                    }
                    
                    VStack(alignment: .leading){
                        Text(name)
                            .fontWeight(.semibold)
                            .padding(.top, 15.0)
                        Text(nic)
                            .fontWeight(.semibold)
                            .padding(.top, 30.0)
                        Text(reg_number)
                            .fontWeight(.semibold)
                            .padding(.top, 30.0)
                        Text(vehicle_no)
                            .fontWeight(.semibold)
                            .padding(.top, 30.0)
                    }
                    
                }.shadow(radius: 10 )
                .padding([.leading, .bottom, .trailing], 20.0).foregroundColor(.black).background(Color(hue: 0.831, saturation: 0.294, brightness: 0.985)).cornerRadius(5.0)
                
                Spacer()
                
                Button(action:{
                    userController.sign_out()
                    utils.authorized = false
                    utils.select = 1
                    
                }, label:{
                    Text("Logout").font(.title).fontWeight(.medium).foregroundColor(.white).padding().frame(width: 200.0, height: 40.0).background(Color(hue: 0.272, saturation: 0.956, brightness: 0.24)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                })
                .padding(.bottom, 100.0)

            }.padding(.top, 20.0).onAppear(){
                
                self.check_user()
                   // isLoad = true;
                
            }
            
        ).edgesIgnoringSafeArea(.all)
    }
    
    func check_user(){
        let controller = UserController()
        controller.get_user() {(success) -> Void in
           let regId = success["register_id"] as! Int64;
            if(regId==0){

            }else{
                utils.authorized = true
                self.reg_number = String(regId);
                self.name = success["name"] as! String;
                self.vehicle_no = success["vehicle_no"] as! String
                self.nic = success["nic"] as! String
            }
            
        }
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
