//
//  SecondViewController.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/30.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class BroadcastViewController: UIViewController {
    //MARK:- IBOutlet
    @IBOutlet weak var broadcastImageView: UIImageView!
    
    //MARK:- Internal Property
    private let dateProvider: () -> Date = Date.init
    private var broadcastViewModel: BroadcastViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObserver()
        configureBroadcastInfo()
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(foo),
                                               name: BroadcastViewModel.Notification.broadcastImagesDidChange,
                                               object: broadcastViewModel)
    }
    
    @objc private func foo() {
        if broadcastViewModel.count == 6 {
            
        }
    }
    
    private func configureBroadcastInfo() {
        let date = dateProvider()
        let dateString = DateFormatter.broadcastDateFormatter.string(from: date)
        DustInfoDecoder.decodeBroadcast(from: "\(NetworkManager.EndPoints.broadcastURL)\(dateString)",
        with: NetworkManager()) { broadcast in
            guard let broadcast = broadcast else { return }
            self.configureBroadcastViewModel(broadcast)
        }
    }
    
    private func configureBroadcastViewModel(_ broadcast: Broadcast) {
        broadcastViewModel = BroadcastViewModel(broadcast: broadcast)
    }
}
