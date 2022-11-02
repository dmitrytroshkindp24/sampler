//
//  Created by Karina Lipnyagova on 20.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit

class Feature2ViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: Bundle.main)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        let view = Feature2View()
        self.view = view
    }
    
    private func configure() {
        navigationItem.largeTitleDisplayMode = .always
        title = "Feature 2"
    }
}
