//
//  HomeView.swift
//  Nimesha
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var utils : AppUtils
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button(action:{
                utils.select = 2;
            }, label:{
                Text("Register").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.647, saturation: 1.0, brightness: 0.992)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
            })
            .padding(.top, 30.0)
        }.onAppear(){
            self.check_user();
        }
                
    }
    
    func check_user(){
        let controller = UserController()
        controller.get_user() {(success) -> Void in
           let regId = success["register_id"] as! Int64;
            if(regId==0){
                utils.authorized = false
                //utils.view = "login"
            
            }else{
                utils.authorized = true
                //setting.view = 1
            }
            
        }
    }
    
    
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(setting: 0)
//    }
//}
