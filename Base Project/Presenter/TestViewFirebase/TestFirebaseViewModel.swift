//
//  TestFirebaseViewModel.swift
//  Base Project
//
//  Created by Leonardo Jose Gunawan on 05/10/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class TestFirebaseViewModel: ObservableObject {
    
    private let ref = Database.database().reference()
    
    @Published var value: String? = nil
    @Published var current_TDS: Float? = nil
    @Published var current_pH: Float? = nil
    @Published var object: DataModel? = nil
    
    func pushNewValue(value: Float) {
        ref.child("Sensor").setValue(value)
    }
    
    func pushObject() {
        let generateObject = DataModel()
        generateObject.current_TDS = 5.5
        generateObject.current_pH = 7.7
//        generateObject.value = "Masukk"

        ref.child("Sensor").setValue(generateObject.toDictionary)

    }
    
//    func readData() {
//        ref.child("Sensor").observeSingleEvent(of: .value) { snapshot in
//            if let snapshot = snapshot.value {
//                if let snapshotDict = snapshot as? NSDictionary {
//                    self.value = snapshotDict["value"] as? String ?? ""
//                }
//            }
//        }
//    }
    
    func readData() {
        ref.child("Sensor").observe(.value) { snapshot  in
            if let snapshot = snapshot.value {
                if let snapshotDict = snapshot as? NSDictionary {
//                    self.value = snapshotDict["value"] as? String ?? ""
//                    print(snapshotDict["current_TDS"])
                    self.current_TDS = snapshotDict["current_TDS"] as? Float ?? 0.0
                    self.current_pH = snapshotDict["current_pH"] as? Float ?? 0.0
                }
            }
        }
    }
    
    func readAllData() {
        ref.child("Sensor")
            .observeSingleEvent(of: .value) { snapshot in
                do {
                    self.object = try snapshot.data(as: DataModel.self)
                } catch {
                    print("Failed")
                }
            }
    }
    
}
