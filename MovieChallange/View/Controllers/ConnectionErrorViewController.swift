//
//  ConnectionErrorViewController.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import UIKit

class ConnectionErrorViewController: UIViewController {
    
    static let identifier = "ConnectionErrorViewController"

    @IBOutlet weak var okLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        okLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapOk(_:))))
    }
    
    @objc func onTapOk(_ sender: UITapGestureRecognizer){
        self.dismiss(animated: true)
    }

}
