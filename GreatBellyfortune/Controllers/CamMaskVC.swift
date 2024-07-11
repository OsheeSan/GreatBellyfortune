//
//  CamMaskVC.swift
//  GreatBellyfortune
//
//  Created by admin on 21.06.2024.
//

import UIKit
import AVFoundation
import Photos

class CamMaskVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var imageToShow: UIImage!
    
    let roarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_roar"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var capturePhotoOutput: AVCapturePhotoOutput!
    var maskImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundView = UIImageView(frame: view.frame)
        backgroundView.image = UIImage(named: "bg_1")
        backgroundView.contentMode = .scaleAspectFill
        view.addSubview(backgroundView)
        setupCamera()
        
        view.addSubview(roarButton)
        NSLayoutConstraint.activate([
            roarButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            roarButton.widthAnchor.constraint(equalToConstant: 300),
            roarButton.heightAnchor.constraint(equalToConstant: 60),
            roarButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        roarButton.addAction(UIAction() {
            _ in
            self.roarButton.isEnabled = false
            self.capturePhoto()
            Vibration.success.vibrate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.dismiss(animated: true)
            })
        }, for: .touchUpInside)
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 70),
        ])
        backButton.addAction(UIAction() {
            _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
    }
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
                let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
                
                guard let camera = frontCamera ?? backCamera else {
                    print("Unable to access front or back camera!")
                    return
                }
        
        do {
                    let input = try AVCaptureDeviceInput(device: camera)
                    capturePhotoOutput = AVCapturePhotoOutput()
                    
                    if captureSession.canAddInput(input) && captureSession.canAddOutput(capturePhotoOutput) {
                        captureSession.addInput(input)
                        captureSession.addOutput(capturePhotoOutput)
                        setupLivePreview()
                    }
                } catch let error {
                    print("Error Unable to initialize camera:  \(error.localizedDescription)")
                }
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        maskImageView = UIImageView(image: imageToShow)
        maskImageView.contentMode = .scaleAspectFit
        maskImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.addSublayer(videoPreviewLayer)
        // Add maskImageView to the view
        view.addSubview(maskImageView)
        
        // Add constraints to center the maskImageView and make it the same size as the view
        NSLayoutConstraint.activate([
            maskImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            maskImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            maskImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            maskImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 4/3)
        ])
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
            DispatchQueue.main.async {
                self?.videoPreviewLayer.frame = self?.view.bounds ?? CGRect.zero
            }
        }
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        capturePhotoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func savePhotoToLibrary(image: UIImage) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }) { success, error in
            if let error = error {
                print("Error saving photo: \(error.localizedDescription)")
            } else {
                print("Photo saved successfully!")
            }
        }
    }
}

extension CamMaskVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            return
        }
        
        // Наложение маски на изображение
        let maskImage = imageToShow!
        let finalImage = overlayImage(baseImage: image, overlayImage: maskImage)
        
        // Сохранение в галерею
        savePhotoToLibrary(image: finalImage)
    }
    
    func overlayImage(baseImage: UIImage, overlayImage: UIImage) -> UIImage {
        UIGraphicsBeginImageContext(baseImage.size)
        baseImage.draw(in: CGRect(origin: CGPoint.zero, size: baseImage.size))
        overlayImage.draw(in: CGRect(origin: CGPoint.zero, size: baseImage.size), blendMode: .normal, alpha: 1.0)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
