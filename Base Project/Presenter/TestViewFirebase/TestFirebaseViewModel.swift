//
//  TestFirebaseViewModel.swift
//  Base Project
//
//  Created by Leonardo Jose Gunawan on 05/10/23.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseFirestoreSwift

class TestFirebaseViewModel: ObservableObject {
    
    private let ref = Database.database().reference()
    
    @Published var listObject = [String: Device]()

//    @Published var value: String? = nil

//    @Published var current_ph: Double? = nil
//    @Published var current_tds: Double? = nil
//    @Published var current_steps: String? = nil
//    @Published var name: String? = nil
//    @Published var plant_id: String? = nil
//    @Published var user_id: String? = nil

//    @Published var object: DataModel? = nil
//    @Published var listObject = [DataModel]()
    
    func pushObject() {
        let generateObject = Device(
            current_ph: 6.6,
            current_steps: "seeding",
            current_tds: 6.6,
            name: "Device 000",
            plant_id: "plant_id_value",
            user_id: "user_id_value"
        )

        ref.child("devices").childByAutoId().setValue(generateObject.toDictionary())
    }
    
    func readData(deviceKey: String) {
        ref.child("devices").child(deviceKey).observe(.value) { snapshot in
            if let deviceDict = snapshot.value as? [String: Any] {
                do {
                    let device = try Firestore.Decoder().decode(Device.self, from: deviceDict)
                    self.listObject[deviceKey] = device
                    print(self.listObject[deviceKey] ?? "")
                } catch {
                    print("Error decoding device: \(error)")
                }
            }
        }
    }
    
    func readAllData() {
        ref.child("devices").observe(.value) { snapshot in
            if let devicesDict = snapshot.value as? [String: [String: Any]] {
                self.listObject.removeAll()
                for (deviceKey, deviceDict) in devicesDict {
                    do {
                        let device = try JSONDecoder().decode(Device.self, from: JSONSerialization.data(withJSONObject: deviceDict))
                        self.listObject[deviceKey] = device
                        print(self.listObject[deviceKey] ?? "")
                    } catch {
                        print("Error decoding device: \(error)")
                    }
                }
            }
        }
    }

//    func pushObject() {
//        let generateObject = DataModel()
//        generateObject.current_ph = 6.6
//        generateObject.current_steps = "seeding"
//        generateObject.current_tds = 6.6
//        generateObject.name = "Device 000"
//        generateObject.plant_id = "plant_id_value"
//        generateObject.user_id = "user_id_value"
//
//        ref.child("devices").childByAutoId().setValue(generateObject.toDictionary)
//
//    }

//    func readData() {
//        ref.child("devices").child("device_001").observe(.value) { snapshot  in
//            if let snapshot = snapshot.value {
//                if let snapshotDict = snapshot as? NSDictionary {
//                    self.current_ph = snapshotDict["current_ph"] as? Double ?? 0.0
//                    self.current_tds = snapshotDict["current_tds"] as? Double ?? 0.0
//                    self.current_steps = snapshotDict["current_steps"] as? String ?? "Nil"
//                    self.name = snapshotDict["name"] as? String ?? "Nil"
//                    self.plant_id = snapshotDict["plant_id"] as? String ?? "Nil"
//                    self.user_id = snapshotDict["user_id"] as? String ?? "Nil"
//                    print(snapshotDict["current_ph"] ?? 1.1)
//                    print(snapshotDict["current_tds"] ?? 1.1)
//                    print(self.current_ph ?? 1.1)
//                    print(self.current_tds ?? 1.1)
//                    print(snapshot)
//                }
//            }
//        }
//    }

//    func readAllData() {
//        ref.observe(.value) { parentSnapshot in
//            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else {
//                return
//            }
//
//            self.listObject = children.compactMap({ snapshot in
//                print("Firebase Data for \(snapshot.key): \(snapshot.value ?? "nil")")
//                do {
//                    return try snapshot.data(as: DataModel.self)
//                } catch {
//                    print("Error \(error)")
//                    return nil
//                }
//            })
//        }
//    }


}

