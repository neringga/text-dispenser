//
//  ContentView.swift
//  TextRecognizer
//
//  Created by Neringa Geigalaite on 2021-02-19.
//  Copyright © 2021 Neringa Geigalaite. All rights reserved.
//

import SwiftUI
import Vision

struct ContentView: View {
    @State private var image: Image?
    
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var data: [String]? = nil
    
    var body: some View {
        NavigationView {
            
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                }.onTapGesture {
                    self.showImagePicker = true
                }
                HStack {
                    if data != nil {
                        NavigationLink(destination: ResultView(resultItems: data!)) {
                            Text("Results").foregroundColor(.red)
                        }
                    }
                    
                }
            }
            
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Image Text Generator")
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        self.getDataFromImage()
    }
    
    func getDataFromImage() {
        guard let cgImage = inputImage?.cgImage else { return }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage)

        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)

        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }
    
    func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            return
        }
        let recognizedStrings = observations.compactMap { observation in
            return observation.topCandidates(1).first?.string
        }
        
        data = recognizedStrings
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
