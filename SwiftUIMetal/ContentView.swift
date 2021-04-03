//
//  ContentView.swift
//  SwiftUIMetal
//
//  Created by Caroline Begbie on 3/4/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      VStack {
        MetalNSView()
          .frame(width: 350, height: 350)
          .border(Color.black)
          .padding()
        Text("Hello, Metal!")
          .padding(.bottom)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
