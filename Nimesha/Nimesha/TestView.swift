//
//  TestView.swift
//  Nimesha
//
//  Created by Mobios on 12/7/21.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack{
            VStack{
                     Text("slot_name")
                        .foregroundColor(.white)
                        .padding(.horizontal, 20.0)
                     Text("status")
                        .font(.body).fontWeight(.bold).foregroundColor(.black).padding(0.0)
                        
                     Text("time")
                        .foregroundColor(.black)
                     Text("vno")
                        .foregroundColor(.black)
            }.background(Color.purple).padding(1.0).cornerRadius(5)
            VStack{
                     Text("slot_name")
                        .foregroundColor(.white)
                        .padding(.horizontal, 20.0)
                     Text("status")
                        .font(.body).fontWeight(.bold).foregroundColor(.black).padding(0.0)
                        
                     Text("time")
                        .foregroundColor(.black)
                     Text("vno")
                        .foregroundColor(.black)
            }.background(Color.purple).padding(1.0).cornerRadius(5)
        }
        
        
    }
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
