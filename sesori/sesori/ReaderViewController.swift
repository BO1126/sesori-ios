//
//  ReaderViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/09/19.
//

import UIKit
import AVKit

class ReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{

    var captureSession:AVCaptureSession?
        var videoPreviewLayer:AVCaptureVideoPreviewLayer?
        
        override func viewDidDisappear(_ animated: Bool) {
            captureSession?.stopRunning()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            captureSession?.startRunning()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //AVCaptureDevice allows us to reference a physical capture device (video in our case)
            let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
            
            if let captureDevice = captureDevice {
                
                do {
                    captureSession = AVCaptureSession()
                    
                    // CaptureSession needs an input to capture Data from
                    let input = try AVCaptureDeviceInput(device: captureDevice)
                    captureSession?.addInput(input)
                    
                    // CaptureSession needs and output to transfer Data to
                    let captureMetadataOutput = AVCaptureMetadataOutput()
                    
                    //We tell our Output the expected Meta-data type
                    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                    captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13, .ean8, .code39, .upce, .aztec, .pdf417]
                    
                    captureSession?.startRunning()
                    
                    //The videoPreviewLayer displays video in conjunction with the captureSession
                    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                    videoPreviewLayer?.videoGravity = .resizeAspectFill
                    videoPreviewLayer?.frame = view.layer.bounds
                    view.layer.addSublayer(videoPreviewLayer!)
                }
                catch {
                    print("CaptureSession Error")
                }
            }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
     
    

}
