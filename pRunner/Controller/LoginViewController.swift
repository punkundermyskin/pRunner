//
//  LoginViewController.swift
//  pRunner
//
//  Created by pennyworth on 11/3/19.
//  Copyright © 2019 punkundermyskin. All rights reserved.
//

import UIKit
import SwiftUI
import AVKit

class LoginViewController: UIViewController {
    
    private var videoPlayer:AVPlayer?
    
    private var videoPlayerLayer:AVPlayerLayer?
    
    private let loginView = LoginView()
    
    private var loginButton: UIButton?
    
    private var signinButton: UIButton?
    
    private let homeViewController = HomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        overrideUserInterfaceStyle = .dark
        setupViews()
//        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    override func loadView() {
        loginButton = loginView.loginButton
        signinButton = loginView.singUpButton
        view = loginView
        self.loginButton!.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        self.signinButton!.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
    }
    
    @objc private func touchButton(sender: UIButton) {
        if sender.titleLabel?.text == "Log In" {
            self.navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            self.navigationController?.pushViewController(SignupViewController(), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        // Set up video in the background
        setUpVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    func setUpVideo() {

        // Get the path to the resource in the bundle
        let urlBundlePath = Bundle.main.url(forResource: "videoBW", withExtension: "mp4")

        guard urlBundlePath != nil else {
            return
        }

        // Create the video player item
        let item = AVPlayerItem(url: urlBundlePath!)

        // Create the player
        videoPlayer = AVPlayer(playerItem: item)

        // Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)

        // Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width * 2, y: 0, width: self.view.frame.size.width * 4, height: self.view.frame.size.height)

        view.layer.insertSublayer(videoPlayerLayer!, at: 0)

//        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.videoPlayer?.currentItem, queue: .main) { [weak self] _ in
//            self?.videoPlayer?.seek(to: CMTime.zero)
//            self?.videoPlayer?.play()
//        }

//        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 1)
    }
    
    func setupViews() {
        
    }
}

struct LoginPreview: PreviewProvider {
    static var previews: some View {
        PreviewView().edgesIgnoringSafeArea(.all)
    }
    
    struct PreviewView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginPreview.PreviewView>) -> UIViewController {
            return LoginViewController()
        }
        
        func updateUIViewController(_ uiViewController: LoginPreview.PreviewView.UIViewControllerType, context: UIViewControllerRepresentableContext<LoginPreview.PreviewView>) {
            
        }
    }
}
