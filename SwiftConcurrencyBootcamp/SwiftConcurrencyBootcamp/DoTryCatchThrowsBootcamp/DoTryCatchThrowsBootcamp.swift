//
//  DoTryCatchThrowsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Narendra Vadde on 29/06/24.
//

import SwiftUI

class DoTryCatchThrowsBootcampManager {
  
  var isActive: Bool = false
  
  func getTitle() -> String? {
    if isActive {
      return "Next text!"
    } else {
      return nil
    }
  }
  
  func getTitle1() -> (title: String?, error: Error?) {
    if isActive {
      return ("Next text!", nil)
    } else {
      return (nil, URLError(.badURL))
    }
  }
  
}

class DoTryCatchThrowsBootcampViewModel: ObservableObject {
  
  @Published var text: String = "Starting text."
  let manager = DoTryCatchThrowsBootcampManager()
  
  func fecthTitle() {
//    if let newTitle = manager.getTitle() {
//      self.text = newTitle
//    }
    
    let results = manager.getTitle1()
    if let newTitle = results.title {
      text = newTitle
    } else if let error = results.error {
      text = error.localizedDescription
    }
    
    
  }
}

struct DoTryCatchThrowsBootcamp: View {
  
  @ObservedObject var viewModel = DoTryCatchThrowsBootcampViewModel()
  
    var body: some View {
      Text(viewModel.text)
        .frame(width: 300, height: 300)
        .background(Color.blue)
        .onTapGesture {
          viewModel.fecthTitle()
        }
    }
}

#Preview {
    DoTryCatchThrowsBootcamp()
}
