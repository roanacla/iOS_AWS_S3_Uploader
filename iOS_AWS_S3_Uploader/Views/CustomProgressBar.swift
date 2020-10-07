//
//  ProgressBar.swift
//  iOS_AWS_S3_Uploader
//
//  Created by Roger Navarro on 10/7/20.
//

import SwiftUI

struct CustomProgressView: View {
  
  @Binding var percent: CGFloat
  @Binding var isDownloadComplete: Bool
  
  var body : some View {
    ZStack {
      
      ZStack(alignment: .leading){
        ZStack(alignment: .trailing) {
          Capsule().fill(Color.black.opacity(0.08)).frame(height: 22 )
          Text(String(format: "%0.f", self.percent * 100) + "%" ).font(.caption).foregroundColor(Color.gray.opacity(0.75)).padding(.trailing)
        }
        Capsule()
          .fill(LinearGradient(gradient: .init(colors: [Color("progressStart"),Color("progressEnd")]), startPoint: .leading , endPoint: .trailing))
          .frame(width: self.calPercent(),height: 22 )
      }
      Text("Upload complete")
        .font(.system(size: 12))
        .opacity(isDownloadComplete ? 1 : 0)
    }
    .padding(18)
    .background(Color.black.opacity(0.085))
    .cornerRadius(15)
  }
  
  func calPercent() -> CGFloat {
    let width = UIScreen.main.bounds.width - 18 - 18 - 15 - 15
    return width * self.percent
  }
}
