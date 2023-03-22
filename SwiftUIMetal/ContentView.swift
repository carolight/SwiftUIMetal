//
//  ContentView.swift
//  SwiftUIMetal
//
//  Created by Caroline Begbie on 22/3/2023.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      MetalView()
      Text("Hello, Metal!")
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
