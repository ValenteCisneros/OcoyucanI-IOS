//
//  CamaraViewController.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 29/10/24.
//


import UIKit
import SwiftUI
import TensorFlowLite
import AVFoundation

// MARK: - Camera View Controller
class CamaraViewController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var previewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var captureButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 35
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var switchCameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "camera.rotate.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(switchCameraButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var photoPreviewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.isHidden = true
        return view
    }()
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirmar", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retakeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tomar Otra Vez", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(retakeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var resultView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.9176, green: 0.9569, blue: 0.7922, alpha: 1.0)
        view.isHidden = true
        return view
    }()
    
    private lazy var plantNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(plantNameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private var camera: Camera?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var capturedImage: UIImage?
    private var interpreter: Interpreter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCamera()
        setupInterpreter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = previewView.bounds
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.9176, green: 0.9569, blue: 0.7922, alpha: 1.0)
        
        // Add subviews
        view.addSubview(previewView)
        view.addSubview(captureButton)
        view.addSubview(switchCameraButton)
        
        // Preview view for captured photo
        photoPreviewView.addSubview(previewImageView)
        photoPreviewView.addSubview(confirmButton)
        photoPreviewView.addSubview(retakeButton)
        view.addSubview(photoPreviewView)
        
        // Result view
        resultView.addSubview(plantNameButton)
        view.addSubview(resultView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Preview View
            previewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            // Capture Button
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            captureButton.widthAnchor.constraint(equalToConstant: 70),
            captureButton.heightAnchor.constraint(equalToConstant: 70),
            
            // Switch Camera Button
            switchCameraButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            switchCameraButton.centerYAnchor.constraint(equalTo: captureButton.centerYAnchor),
            switchCameraButton.widthAnchor.constraint(equalToConstant: 40),
            switchCameraButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Photo Preview View
            photoPreviewView.topAnchor.constraint(equalTo: previewView.topAnchor),
            photoPreviewView.leadingAnchor.constraint(equalTo: previewView.leadingAnchor),
            photoPreviewView.trailingAnchor.constraint(equalTo: previewView.trailingAnchor),
            photoPreviewView.bottomAnchor.constraint(equalTo: previewView.bottomAnchor),
            
            // Preview Image View
            previewImageView.topAnchor.constraint(equalTo: photoPreviewView.topAnchor),
            previewImageView.leadingAnchor.constraint(equalTo: photoPreviewView.leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: photoPreviewView.trailingAnchor),
            previewImageView.bottomAnchor.constraint(equalTo: photoPreviewView.bottomAnchor),
            
            // Confirm Button
            confirmButton.leadingAnchor.constraint(equalTo: photoPreviewView.leadingAnchor, constant: 20),
            confirmButton.bottomAnchor.constraint(equalTo: photoPreviewView.bottomAnchor, constant: -20),
            confirmButton.widthAnchor.constraint(equalToConstant: 100),
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Retake Button
            retakeButton.trailingAnchor.constraint(equalTo: photoPreviewView.trailingAnchor, constant: -20),
            retakeButton.bottomAnchor.constraint(equalTo: photoPreviewView.bottomAnchor, constant: -20),
            retakeButton.widthAnchor.constraint(equalToConstant: 100),
            retakeButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Result View
            resultView.topAnchor.constraint(equalTo: previewView.bottomAnchor),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Plant Name Button
            plantNameButton.centerXAnchor.constraint(equalTo: resultView.centerXAnchor),
            plantNameButton.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 20),
            plantNameButton.widthAnchor.constraint(equalToConstant: 200),
            plantNameButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupCamera() {
        camera = Camera()
        
        guard let camera = camera else { return }
        
        let previewLayer = AVCaptureVideoPreviewLayer()
        previewLayer.videoGravity = .resizeAspectFill
        previewView.layer.addSublayer(previewLayer)
        self.previewLayer = previewLayer
        
        Task {
            await camera.start()
        }
    }
    
    private func setupInterpreter() {
        // TODO: Initialize your TFLite interpreter
        do {
            guard let modelPath = Bundle.main.path(forResource: "model_unquant", ofType: "tflite") else {
                print("Failed to load model")
                return
            }
            interpreter = try Interpreter(modelPath: modelPath)
            try interpreter?.allocateTensors()
        } catch {
            print("Failed to create interpreter: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Actions
    @objc private func captureButtonTapped() {
        camera?.takePhoto()
    }
    
    @objc private func switchCameraButtonTapped() {
        camera?.switchCaptureDevice()
    }
    
    @objc private func confirmButtonTapped() {
        guard let capturedImage = capturedImage else { return }
        analyzeImage(capturedImage)
    }
    
    @objc private func retakeButtonTapped() {
        hidePhotoPreview()
    }
    
    @objc private func plantNameButtonTapped() {
        // TODO: Navigate to plant details
    }
    
    // MARK: - Helper Methods
    private func showPhotoPreview() {
        photoPreviewView.isHidden = false
        captureButton.isHidden = true
        switchCameraButton.isHidden = true
    }
    
    private func hidePhotoPreview() {
        photoPreviewView.isHidden = true
        captureButton.isHidden = false
        switchCameraButton.isHidden = false
        resultView.isHidden = true
    }
    
    private func analyzeImage(_ image: UIImage) {
        // TODO: Implement TFLite model inference
        // For testing:
        DispatchQueue.main.async {
            self.resultView.isHidden = false
            self.plantNameButton.setTitle("Plant Name", for: .normal)
        }
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CamaraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        
        capturedImage = image
        previewImageView.image = image
        showPhotoPreview()
    }
}

// MARK: - SwiftUI Wrapper
struct CamaraViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CamaraViewController {
        return CamaraViewController()
    }
    
    func updateUIViewController(_ uiViewController: CamaraViewController, context: Context) {
        // Update the view controller if needed
    }
}


