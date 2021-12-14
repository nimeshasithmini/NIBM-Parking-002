//
//  HomeView.swift
//  Nimesha
//

import SwiftUI
import FirebaseDatabase

struct HomeView: View {
    

    
    @ObservedObject var utils : AppUtils
    @State var vip: [DataSnapshot] = [];
    @State var normal: [DataSnapshot] = [];
    
    var body: some View {
        Color("AppBackground").overlay(
        VStack{
            Text("SLOTS AVAILABILITY")
                .fontWeight(.bold).padding(.bottom, 30.0)
            HStack{
                VStack{
                    Text("VIP SLOT")
                        .fontWeight(.bold).padding(.bottom, 10.0)
                    ForEach(0..<vip.count, id: \.self) { index in
                       
                        let status = self.vip[index].childSnapshot(forPath: "status").value as! String;
                        let slot_name = self.vip[index].childSnapshot(forPath: "name").value as! String;
                        
                        VStack{
                                 Text(slot_name)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 30.0)
                                 Text(status)
                                    .font(.body).fontWeight(.bold).foregroundColor(.black).padding(0.0)
                            if(status=="BOOKED"){
                                let time = self.vip[index].childSnapshot(forPath: "date_time").value as! String;
                                let user = self.vip[index].childSnapshot(forPath: "user").value as! [String:Any]
                                Text(user["vehicle_no"] as! String)
                                    .fontWeight(.light)
                                Text(time_check(f_time: time)).fontWeight(.light).padding([.leading, .bottom, .trailing], 3.0).font(.system(size: 15))
                            }
                                 
                        }.frame(width: 150.0,height: 80.0).background(Color.yellow).padding(1.0).cornerRadius(35)
                        
                      }
                   
                }.frame(width:150)
                
                VStack{
                    Text("NORMAL SLOT")
                        .fontWeight(.bold).padding(.bottom, 10.0)
                    ForEach(0..<normal.count, id: \.self) { index in
                        let status = self.normal[index].childSnapshot(forPath: "status").value as! String;
                        let slot_name = self.normal[index].childSnapshot(forPath: "name").value as! String;
                        VStack{
                                 Text(slot_name)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 30.0)
                                 Text(status)
                                    .font(.body).fontWeight(.bold).foregroundColor(.black).padding(0.0)
                                    
                            if(status=="BOOKED"){
                                let time = self.normal[index].childSnapshot(forPath: "date_time").value as! String;
                                let user = self.normal[index].childSnapshot(forPath: "user").value as! [String:Any]
                                Text(user["vehicle_no"] as! String)
                                    .fontWeight(.light)
                                Text(time_check(f_time: time)).fontWeight(.light).padding([.leading, .bottom, .trailing], 3.0).font(.system(size: 15))
                            }
                        }.frame(width: 150.0,height: 80.0).background(Color.pink).padding(1.0).cornerRadius(35)
                      }
                    
                }.frame(width:150)
            }
            
        }.onAppear(){
            
            
         self.load_data();
            
        }
        )
        .edgesIgnoringSafeArea(.top)
                
    }
    
    func check_user(){
        let controller = UserController()
        controller.get_user() {(success) -> Void in
           let regId = success["register_id"] as! Int64;
            if(regId==0){
                utils.authorized = false
            }else{
                utils.authorized = true
            }
            
        }
    }
    
    func load_data(){
        let controller = BookingController()
        controller.get_all_vip{(success) -> Void in
            self.vip = success;
        }
        controller.get_all_normal{(success) -> Void in
            self.normal = success;
        }
    }
    
    func time_check(f_time time:String) -> String{
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "HH:mm"
        let date_1 = date_formatter.date(from: time)!
        let date_2 = NSDate()

        var c1 = NSCalendar.current.dateComponents([.hour, .minute], from: date_1)
        let c2 = NSCalendar.current.dateComponents([.hour, .minute, .day, .month, .year], from: date_2 as Date)
        c1.year = c2.year;
        c1.month = c2.month;
        c1.day = c2.day;
        let date_3 = NSCalendar.current.date(from: c1)

        let e_time = date_3!.timeIntervalSince(date_2 as Date)
        let h = floor(e_time / 60 / 60)
        let m = floor((e_time - (h * 60 * 60)) / 60)
        return "Rem. \(Int(h)) H \(Int(m)) M"
    }
    
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(setting: 0)
//    }
//}
