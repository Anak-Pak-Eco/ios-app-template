//
//  TestFirebaseView.swift
//  Base Project
//
//  Created by Leonardo Jose Gunawan on 05/10/23.
//

import SwiftUI

struct TestFirebaseView: View {
    @ObservedObject var viewModel = TestFirebaseViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.listObject.keys.sorted(), id: \.self) { deviceKey in
                    NavigationLink(destination: DeviceDetailView(device: viewModel.listObject[deviceKey]!)) {
                        Text(viewModel.listObject[deviceKey]?.name ?? "")
                    }
                }
            }
            .navigationBarTitle("Data List")
        }
        .onAppear {
            viewModel.readAllData()
        }
        
        VStack {
            Button {
                viewModel.pushObject()
            } label: {
                Text("Push New Object")
                    .padding()
            }
        }
    }
}

struct DeviceDetailView: View {
    let device: Device

    var body: some View {
        VStack {
            Text("Current pH: \(device.current_ph)")
            Text("Current Steps: \(device.current_steps)")
            Text("Current TDS: \(device.current_tds)")
            Text("Name: \(device.name)")
            Text("Plant ID: \(device.plant_id)")
            Text("User ID: \(device.user_id)")
        }
        .navigationBarTitle(device.name, displayMode: .inline)
    }
}


struct TestFirebaseView_Previews: PreviewProvider {
    static var previews: some View {
        TestFirebaseView()
    }
}
