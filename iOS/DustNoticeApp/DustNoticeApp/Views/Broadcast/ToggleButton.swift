//
//  ToggleButton.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/04.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

protocol ToggleButtonDelegate: class {
    func animate(with isPlay: Bool)
}

final class ToggleButton: UIButton {
    weak var delegate: ToggleButtonDelegate?
    private var isPlay = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBorder()
        configureFirstImage()
        configureDelegate()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureBorder()
        configureFirstImage()
        configureDelegate()
    }
    
    deinit {
        removeTarget(self, action: #selector(toggle), for: .touchUpInside)
    }
    
    private func configureDelegate() {
        addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }
    
    private func configureBorder() {
        layer.borderWidth = 0.9
        layer.borderColor = UIColor.black.cgColor
    }
    
    private func configureFirstImage() {
        setImage(ToggleButton.playImage, for: .normal)
    }
    
    @objc func toggle() {
        toggleIsPlay()
        toggleButtonImage()
        processBroadcastSlider()
    }
    
    private static let playImage = UIImage(systemName: "play.fill")!
    private static let pauseImage = UIImage(systemName: "pause.fill")!
    private func toggleIsPlay() {
        isPlay = !isPlay
    }
    
    private func toggleButtonImage() {
        if isPlay {
            setImage(ToggleButton.pauseImage, for: .normal)
        } else {
            setImage(ToggleButton.playImage, for: .normal)
        }
    }
    
    private func processBroadcastSlider() {
        delegate?.animate(with: isPlay)
    }
}

