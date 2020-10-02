//
//  ContentView.swift
//  iOS_AWS_S3_Uploader
//
//  Created by Roger Navarro on 10/2/20.
//

import SwiftUI
import Combine
import Amplify

struct ContentView: View {
  
  @State var imageStringURL: String = ""
  //  @ObservedObject var viewModel = ViewModel()
  //  @ObservedObject var imageLoader:ImageLoader = ImageLoader(urlString: "https://cdni.llbean.net/is/image/wim/296437_116_41?hei=1092&wid=950&resMode=sharp2&defaultImage=llbstage/A0211793_2")
  @State var image:UIImage = UIImage()
  @State var showImagePicker: Bool = false
  //  var resultSink: AnyCancellable?
  //  var progressSink: AnyCancellable?
  
  var body: some View {
    
    VStack {
      Button("Upload Image", action: {
        self.showImagePicker.toggle()
      })
      Image(uiImage: image)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width:200, height:200)
    }
    .sheet(isPresented: $showImagePicker, content: {
      ImagePicker.shared.view
    })
    .onReceive(ImagePicker.shared.$image, perform: { image in //shows image in ImageView
      if let image = image {
        self.image = image
        self.uploadData(data: image.pngData())
      }
    })
    
  }
  
  func uploadData(data: Data?) {
    guard let data = data else {
      print("Image not recognized")
      return
    }
    
    Amplify.Storage.uploadData(key: UUID().uuidString+".png", data: data,
            progressListener: { progress in
                print("Progress: \(progress)")
            }, resultListener: { (event) in
                switch event {
                case .success(let data):
                    print("Completed: \(data)")
                case .failure(let storageError):
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        })
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

