//
//  AppUtils.swift
//  Nimesha
//

import Foundation
class AppUtils: ObservableObject{
    @Published var authorized = false;
    @Published var view = "login";
    @Published var select : Int = 1;
}

struct MyAlert: Identifiable {
    var id:String { message }
    let message: String
}


