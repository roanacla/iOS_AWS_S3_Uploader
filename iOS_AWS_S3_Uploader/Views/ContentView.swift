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
  @State var image:UIImage = UIImage(named: "uploadImg") ?? UIImage()
  @State var showImagePicker: Bool = false
  @State var percent :CGFloat = 0
  @State var isUploading: Bool = false
  @State var isDownloadComplete: Bool = false
  
  var body: some View {
    
    VStack {
      Image(uiImage: image)
        .resizable()
        .aspectRatio(contentMode: .fit)
      CustomProgressView(percent: self.$percent, isDownloadComplete: self.$isDownloadComplete)
        .padding()
        .animation(.spring())
      Button(action: {self.showImagePicker.toggle()}, label: {
        Text("Upload Image")
          .font(.body)
          .bold()
      })
      .disabled(isUploading)
      .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(lineWidth: 2)
          .foregroundColor(.blue)
      )
      .shadow(color: Color.gray.opacity(0.4),
              radius: 3, x: 1, y: 2)
      .padding()
      
    }
    .sheet(isPresented: $showImagePicker, content: {
      ImagePicker.shared.view
    })
    .onReceive(ImagePicker.shared.$image, perform: { image in //shows image in ImageView
      if let image = image {
        self.image = image
        self.isUploading = true
        self.isDownloadComplete = false
        self.uploadData(data: image.jpegData(compressionQuality: 1.0))
      }
    })
    
  }
  
  func uploadData(data: Data?) {
    guard let data = data else {
      print("Image not recognized")
      return
    }
    
    Amplify.Storage.uploadData(key: UUID().uuidString+".jpg", data: data,
                               progressListener: { progress in
                                print("Progress: \(progress.completedUnitCount)")
                                self.percent = CGFloat(progress.fractionCompleted)
                               }, resultListener: { (event) in
                                self.isUploading = false
                                switch event {
                                case .success(let data):
                                  print(" Completed: \(data)")
                                  self.isDownloadComplete = true
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

