//
//  TestFirebaseView.swift
//  Base Project
//
//  Created by Leonardo Jose Gunawan on 05/10/23.
//

import SwiftUI

struct TestFirebaseView: View {
    
    @StateObject var viewModel = TestFirebaseViewModel()
    
    var value: Float = 1.1
    
    var body: some View {
        VStack {
//            Button {
//                viewModel.pushNewValue(value: value)
//            } label: {
//                Text("Push New Value")
//                    .padding()
//            }
//
            Button {
                viewModel.pushObject()
            } label: {
                Text("Push New Object")
                    .padding()
            }
            
            if viewModel.current_TDS != nil {
                Text("\(viewModel.current_TDS!)")
                    .padding()
            } else {
                Text("Value...")
                    .padding()
            }
            
            if viewModel.current_pH != nil {
                Text("\(viewModel.current_pH!)")
                    .padding()
            } else {
                Text("Value...")
                    .padding()
            }
            
            Button {
                viewModel.readData()
            } label: {
                Text("Read")
                    .padding()
            }
            
//            Button {
//                viewModel.readAllData()
//            } label: {
//                Text("Read All")
//                    .padding()
//            }


        }
    }
}

struct TestFirebaseView_Previews: PreviewProvider {
    static var previews: some View {
        TestFirebaseView()
    }
}
