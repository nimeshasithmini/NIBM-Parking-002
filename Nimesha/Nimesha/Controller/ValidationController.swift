//
//  ValidationController.swift
//  Nimesha
//
//  Created by Mobios on 12/9/21.
//

import Foundation

class ValidationController{
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    func isValidPassword(_ password: String) -> Bool {
        if password.count < 8 {
            return false
        }else{
            return true;
        }
    }
}