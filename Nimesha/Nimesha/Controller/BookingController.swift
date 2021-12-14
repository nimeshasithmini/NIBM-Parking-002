//
//  UserController.swift
//  Nimesha
//

import Foundation
import FirebaseDatabase
import FirebaseAuth



class BookingController{
    
    func get_all_vip(completionBlock: @escaping (_ success: [DataSnapshot]) -> Void) {
        var db: DatabaseReference!
        db = Database.database().reference()
        db.child("vip").observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.children.allObjects as! [DataSnapshot]
            completionBlock(data)
            })
    }
    
    func get_all_normal(completionBlock: @escaping (_ success: [DataSnapshot]) -> Void) {
        var db: DatabaseReference!
        db = Database.database().reference()
        db.child("normal").observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.children.allObjects as! [DataSnapshot]
            completionBlock(data)
            })
    }
    
    func get_availble_by_type(type:String,completionBlock: @escaping (_ success: [String]) -> Void) {
        var avaSlots :[String] = []
        var db: DatabaseReference!
        db = Database.database().reference()
        
        let dataset = db.child(type).queryOrdered(byChild: "status").queryEqual(toValue : "AVAILABLE")

        dataset.observe(.value, with:{ (snapshot) in
            for snap in snapshot.children {
                avaSlots.append((snap as! DataSnapshot).key)
            }
            completionBlock(avaSlots);
        })
    }
    
    func booking(type: String,id: String,user: Any,time: String, reserved_time: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        var db: DatabaseReference!
        db = Database.database().reference()
        db.child(type).child(id).child("user").setValue(user)
        db.child(type).child(id).child("date_time").setValue(time)
        db.child(type).child(id).child("reserved_time").setValue(reserved_time)
        let prntRef = db.child(type).child(id)
        prntRef.updateChildValues(["status":"BOOKED"])
        completionBlock(true)
        
    }
}
