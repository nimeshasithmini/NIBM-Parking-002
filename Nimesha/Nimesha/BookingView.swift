//
//  BookingView.swift
//  Nimesha
//

import SwiftUI
import CodeScanner

struct BookingView: View {
    
    
    @State var vehicle_no = "";
    @State var reg_number = "";
    
    @State var type = "normal"
    @State var user: [String: Any] = ["":""];
    
    @State var selected_type_index = 0
    @State var time_slot = 0
    @ObservedObject var utils : AppUtils
    @State private var alert: MyAlert?;
    
    @State var is_show_scanner = false;
    
    @State var slots: [String] = [];
    @State private var slot_index = 0;
    @State var isLoad = false;
    @State var btn_disable = true;    
    
    @State var time = "";
    @State var reserved_time = "";
    
    var qr_scanner : some View{
        CodeScannerView(
            codeTypes: [.qr],
            completion: {res in
                if case let .success(code) = res{
                    self.is_show_scanner = false
                    
                    if let i = self.slots.firstIndex(of:code) {
                        self.slot_index = i;
                    } else {
                        
                    }
                }
            })
    }
    
    var body: some View {
        
        Color("AppBackground").overlay(

        VStack{
            Text("Booking Details")
                .fontWeight(.bold)
            HStack( spacing: 100){
                VStack(alignment: .leading){
                    Text("Reg. No")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    Text(reg_number)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                VStack(alignment: .leading){
                    Text("Veh. No")
                        .fontWeight(.semibold)
                    Text(vehicle_no)
                        .fontWeight(.semibold)
                }
                
            }.padding(.all,10).shadow(radius: 10 )
            .padding(.all, 20.0).foregroundColor(.black).background(Color(hue: 0.831, saturation: 0.294, brightness: 0.985)).cornerRadius(5.0)
            
            
            VStack{
                Picker("Picker",selection: Binding(
                            get:{self.selected_type_index},
                            set:{self.selected_type_index = $0
                                 self.getAvaSolts(id: $0);
                            }), content:{
                        Text("Normal").tag(0)
                        Text("VIP").tag(1)})
                    .frame(height: 30.0).padding(.bottom,80)
                    .pickerStyle(SegmentedPickerStyle())
                    .scaledToFit().scaleEffect(CGSize(width: 1, height: 1))
                    
                    Picker(selection: $slot_index ,label: Text("Picker")) {
                        ForEach(0..<slots.count, id: \.self) { index in
                            Text("\(self.slots[index])")
                          }
                    }
                    .frame(height: 30.0)
                
                Picker("Picker",selection: $time_slot, content:{
                    Text("1 Hour").tag(0)
                    Text("2 Hour").tag(1)
                    Text("3 Hour").tag(2)
                }).frame(height: 30.0).padding(.top,80)
                .pickerStyle(SegmentedPickerStyle())
                .scaledToFit().scaleEffect(CGSize(width: 1, height: 1))
                Spacer()
                HStack( spacing: 50){
                    Button("Scan QR"){
                       self.is_show_scanner = true;
                    }
                    Button(action:{
                        if(!btn_disable){
                            btn_disable = true;
                            self.set_times()
                            let controller = BookingController()
                             UserDefaults.standard.set(slots[slot_index], forKey: "slot")
                            controller.booking(type: type,id: slots[slot_index], user: user, time: time, reserved_time: reserved_time) {(success) in
                                if(success){
                                    alert = MyAlert(message: "Succesfully Booked");
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        self.getAvaSolts(id: selected_type_index);
                                    }
                                }else{}                                
                            }
                        }
                        
                    }, label:{
                        Text("Reserve").fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 30.0).background(Color(hue: 0.541, saturation: 0.996, brightness: 0.362)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                    }).disabled(btn_disable).alert(item: $alert) { con in
                        Alert(title: Text(con.message))
                    }
                }.padding(.bottom,50)
            }
                
            }.sheet(isPresented: $is_show_scanner) {
            self.qr_scanner
        }.padding(.top,50).onAppear(){
            self.check_user();
            self.getAvaSolts(id: 0);
             
        }
        ).edgesIgnoringSafeArea(.top)
    }
    
    func check_user(){
        let controller = UserController()
        controller.get_user() {(success) -> Void in
           let regId = success["register_id"] as! Int64;
            if(regId==0){

            }else{
                user = success;
                utils.authorized = true
                self.reg_number = String(regId);
                self.vehicle_no = success["vehicle_no"] as! String
            }
        }
    }
    
    func getAvaSolts(id: Int){
        self.slots = []
        if(id==1){
            self.type = "vip"
        }else{
            self.type = "normal"
        }
        let controller = BookingController()
        controller.get_availble_by_type(type: type) {(success) -> Void in
            self.slots = success;
        }
        btn_disable = false;
    }
    
    
    func set_times(){
        var date = NSDate();
        if(self.time_slot == 0){
            date = date.addingTimeInterval((TimeInterval(60.0 * 60.0)))
        }else if(self.time_slot == 1){
            date = date.addingTimeInterval((TimeInterval(120.0 * 60.0)))
        }else if(self.time_slot == 2){
            date = date.addingTimeInterval((TimeInterval(180.0 * 60.0)))
        }
        
        let calender = Calendar.current;
        let hour = calender.component(.hour, from: date as Date)
        let min = calender.component(.minute, from: date as Date)
        time = "\(hour)"+":"+"\(min)"
        time = "\(String(format: "%02d", hour)):\(String(format: "%02d", min))"
        
        date = NSDate();
        date = date.addingTimeInterval((TimeInterval(10.0 * 60.0)))
        let h = calender.component(.hour, from: date as Date)
        let m = calender.component(.minute, from: date as Date)
        reserved_time = "\(h)"+":"+"\(m)"
        reserved_time = "\(String(format: "%02d", h)):\(String(format: "%02d", m))"
       
    }
}

//struct BookingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingView()
//    }
//}
