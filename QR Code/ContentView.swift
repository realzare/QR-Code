//
//  ContentView.swift
//  QR Code
//
//  Created by Hossein Zare on 8/28/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var name = ""
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.indigo, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
        
                VStack {
                    TextField("Name", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.name)
                        .font(.title)
                        .padding(10)
                    
            Image(uiImage:generateQRCode(_: "\(name)"))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .padding(80)
                }
                    .navigationTitle("QR Code Generator")
                }
            }
        }
    
    func generateQRCode(_ string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


