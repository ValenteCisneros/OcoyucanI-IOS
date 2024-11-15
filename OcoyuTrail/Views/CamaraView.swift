//
//  CamaraView.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 13/11/24.
//

import SwiftUI
import TensorFlowLite
import AVFoundation
import PhotosUI


    struct CamaraView: View {
        @State private var selectedItem: PhotosPickerItem? = nil
        @State private var selectedImageData: Data? = nil
        @State private var organ: String = "flower"
        @State private var identificationResult: String = ""
        @State private var isLoading: Bool = false
        @State private var showCamera: Bool = false
        @State private var capturedImage: UIImage? = nil

        var body: some View {
            NavigationView {
                
                ZStack{
                    Color.background.edgesIgnoringSafeArea(.all)
                    VStack {
                        
                        Text("Escanea la Flora")
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 0.149, green: 0.231, blue: 0.149))
                            .padding()
                        
                        
                        if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .padding()
                        } else if let capturedImage {
                            Image(uiImage: capturedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .padding()
                        } else {
                            Rectangle()
                                .fill(Color.black.opacity(0.2))
                                .frame(height: 400)
                                .overlay(
                                    Text("No Image Selected")
                                        .foregroundColor(.gray)
                                )
                                .padding()
                        }
                        
                        HStack {
                            PhotosPicker(selection: $selectedItem, matching: .images) {
                                Text("Selecciona una imagen")
                                    .padding()
                                    .background(Color.secondaryBackground)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                    }
                                }
                            }
                            
                            Button("Abrir Camara") {
                                showCamera = true
                            }
                            .padding()
                            .background(Color.secondaryBackground)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        
                        if isLoading {
                            ProgressView("Identificando...")
                        } else {
                            Button("Identifica flora") {
                                if let imageData = selectedImageData {
                                    identifyPlant(imageData: imageData, organ: organ)
                                } else if let capturedImageData = capturedImage?.jpegData(compressionQuality: 0.8) {
                                    identifyPlant(imageData: capturedImageData, organ: organ)
                                } else {
                                    identificationResult = "Error: No Selecciono una imagen."
                                }
                            }
                            .padding()
                            .background(Color.accent)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        
                        ScrollView {
                            Text(identificationResult)
                                .padding()
                        }
                        .frame(maxHeight: 300)
                    }
                    .padding()
                    .sheet(isPresented: $showCamera) {
                        ImagePicker2(image: $capturedImage)
                    }
                    .navigationBarItems(
                            leading: LeadingBarItem(),
                            trailing: TrailingBarItem())
                }
            }
            .statusBar(hidden: true)
        }
        
        func parseIdentificationResults(data: Data) -> String {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = json["results"] as? [[String: Any]] {
                    
                    let topResults = results.prefix(10) // Obtener los 10 primeros resultados
                    
                    var resultString = "Top 10 Identification Results:\n\n"
                    
                    for (index, result) in topResults.enumerated() {
                        if let score = result["score"] as? Double,
                           let species = result["species"] as? [String: Any],
                           let scientificName = species["scientificNameWithoutAuthor"] as? String,
                           let commonNames = species["commonNames"] as? [String] {
                            let commonNamesString = commonNames.joined(separator: ", ")
                            resultString += """
                            \(index + 1). \(scientificName)
                            - Common Names: \(commonNamesString)
                            - Score: \(String(format: "%.2f", score))
                            
                            """
                        }
                    }
                    return resultString
                } else {
                    return "Error: Unable to parse results."
                }
            } catch {
                return "Error: \(error.localizedDescription)"
            }
        }


        func identifyPlant(imageData: Data, organ: String) {
            //falta
            }
        }

    extension Data {
        mutating func append(_ string: String) {
            if let data = string.data(using: .utf8) {
                append(data)
            }
        }
    }


    struct ImagePicker2: UIViewControllerRepresentable {
        @Binding var image: UIImage?

        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            let parent: ImagePicker2

            init(parent: ImagePicker2) {
                self.parent = parent
            }

            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                if let uiImage = info[.originalImage] as? UIImage {
                    parent.image = uiImage
                }
                picker.dismiss(animated: true)
            }

            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true)
            }
        }

        func makeCoordinator() -> Coordinator {
            return Coordinator(parent: self)
        }

        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = .camera
            return picker
        }

        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    }

    struct CamaraView_Previews: PreviewProvider {
        static var previews: some View {
            CamaraView()
        }
    }
