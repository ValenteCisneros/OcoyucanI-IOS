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
            ZStack {
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
                                identifyPlant(imageData: imageData)
                            } else if let capturedImageData = capturedImage?.jpegData(compressionQuality: 0.8) {
                                identifyPlant(imageData: capturedImageData)
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
            .statusBar(hidden: true)
        }
    }

    func identifyPlant(imageData: Data) {
        isLoading = true
        identificationResult = ""

        DispatchQueue.global(qos: .userInitiated).async {
            guard let uiImage = UIImage(data: imageData),
                  let resizedImage = uiImage.resize(to: CGSize(width: 224, height: 224)) else {
                DispatchQueue.main.async {
                    isLoading = false
                    identificationResult = "Error: No se pudo procesar la imagen."
                }
                return
            }

            guard let modelPath = Bundle.main.path(forResource: "model_unquant", ofType: "tflite"),
                  let interpreter = try? Interpreter(modelPath: modelPath) else {
                DispatchQueue.main.async {
                    isLoading = false
                    identificationResult = "Error: No se pudo cargar el modelo."
                }
                return
            }

            do {
                try interpreter.allocateTensors()

                let inputTensor = try interpreter.input(at: 0)
                guard let inputData = resizedImage.toFloat32Input() else {
                    DispatchQueue.main.async {
                        isLoading = false
                        identificationResult = "Error: No se pudo convertir la imagen."
                    }
                    return
                }

                try interpreter.copy(inputData, toInputAt: 0)
                try interpreter.invoke()

                let outputTensor = try interpreter.output(at: 0)
                let outputData = outputTensor.data.withUnsafeBytes {
                    Array(UnsafeBufferPointer<Float>(start: $0.baseAddress?.assumingMemoryBound(to: Float.self), count: $0.count / MemoryLayout<Float>.stride))
                }

                let classes = [
                           "Sida abutifolia", "Lysiloma acapulcensis", "Acacia acatlensis", "Lantana achyranthifolia",
                           "Plumería acutifolia", "Ceiba aesculifolia", "Conopholis alpina", "Chenopodium ambrosioides",
                           "Solanum americanum", "Simsia amplexicaulis", "Pseudosmodingium andreux", "Agave angustifolia",
                           "Malvaviscus arboreus", "Anagallis arvensis", "Bidens aurea", "Dalea bicolor",
                           "Acacia bilimekii", "Glandularia bipinnatifida", "Cosmos bipinnatus", "Salix bonplandiana",
                           "Psilactis brevilingulata", "Cologania broussoneti", "Psittacanthus calyculatus", "Lantana camara",
                           "Conyza canadensis", "Sideroxylon capiri", "Ageratum corymbosum", "Ficus cotinifolia",
                           "Rumex crispus", "Asclepias curassavica", "Krameria cytisoides", "Lamourouxia dasyantha",
                           "Gomphrena decumbens", "Amelanchier denticulata", "Clematis dioica", "Croton dioicus",
                           "Bauhinia dipetala", "Mascagnia dipholiphylla", "Casimiroa edulis", "Echinopterys eglandulosa",
                           "Roldana ehrenbergiana", "Bouvardia erecta", "Leucaena esculenta"
                       ]
                if let maxIndex = outputData.indices.max(by: { outputData[$0] < outputData[$1] }) {
                    let result = classes[maxIndex]
                    DispatchQueue.main.async {
                        isLoading = false
                        identificationResult = "Identificación: \(result)"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    isLoading = false
                    identificationResult = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }

    func toFloat32Input() -> Data? {
        guard let cgImage = cgImage else { return nil }
        let width = cgImage.width
        let height = cgImage.height

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let rawData = UnsafeMutablePointer<UInt8>.allocate(capacity: width * height * 4)
        let context = CGContext(
            data: rawData,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * 4,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue
        )

        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        var floatArray = [Float](repeating: 0, count: width * height * 3)
        for i in 0..<width * height {
            let r = Float(rawData[i * 4]) / 255.0
            let g = Float(rawData[i * 4 + 1]) / 255.0
            let b = Float(rawData[i * 4 + 2]) / 255.0
            floatArray[i * 3] = r
            floatArray[i * 3 + 1] = g
            floatArray[i * 3 + 2] = b
        }
        rawData.deallocate()

        return Data(buffer: UnsafeBufferPointer(start: &floatArray, count: floatArray.count))
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
