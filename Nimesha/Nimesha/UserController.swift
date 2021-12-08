//
//  UserController.swift
//  Nimesha
//

import Foundation
import FirebaseDatabase
import FirebaseAuth



class UserController{
    
    func get_user(completionBlock: @escaping (_ success: [String: Any]) -> Void) {
        var db: DatabaseReference!
        db = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else {
            completionBlock(["register_id" : 0 as Int64]);
            return
        }
        print(uid);
        
        db.child("users").child(uid).observeSingleEvent(of: .value, with: { (data) in
            let user = data.value as! [String: Any]
            completionBlock(user);
        })
    }
        
    func add_user(email: String, password: String,name:String,veh_no:String,nic:String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(res, error) in
            if let user = res?.user {
                let id=Int64((Date().timeIntervalSince1970 * 1000.0).rounded())
                let data = ["register_id":id,
                                "name":name,
                                "vehicle_no":veh_no,
                                "is_disabled":false,
                                "nic":nic] as [String : Any]
                
                var db: DatabaseReference!
                db = Database.database().reference()
                db.child("users").child(user.uid).setValue(data)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func login(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func forget(email: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func sign_out(){
        try! Auth.auth().signOut();
    }
}
