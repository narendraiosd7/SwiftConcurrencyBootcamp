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
  
  func getTitle2() -> Result<String, Error> {
    if isActive {
      return .success("Next text!")
    } else {
      return .failure(URLError(.unknown))
    }
  }
  
  func getTitle3() throws -> String {
    if isActive {
      return "Next text!"
    } else {
      throw URLError(.timedOut)
    }
  }
  
  func getTitle4() throws -> String {
    isActive = true
    if isActive {
      return "Final text!"
    } else {
      throw URLError(.timedOut)
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
    
    //    let results = manager.getTitle1()
    //    if let newTitle = results.title {
    //      text = newTitle
    //    } else if let error = results.error {
    //      text = error.localizedDescription
    //    }
    
    //    let results = manager.getTitle2()
    //    switch results {
    //    case .success(let success):
    //      self.text = success
    //    case .failure(let failure):
    //      self.text = failure.localizedDescription
    //    }
    
    //    do {
    //      self.text = try manager.getTitle3()
    //    } catch {
    //      self.text = error.localizedDescription
    //    }
    
    
    
    do {
      if let newTitle = try? manager.getTitle3() {
        self.text = newTitle
      }
      
      self.text = try manager.getTitle4()
    } catch {
      self.text = error.localizedDescription
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
