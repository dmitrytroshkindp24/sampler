//
//  Created by Karina Lipnyagova on 20.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit

class Feature1ViewController: UIViewController {

    var samplerPlayer: SamplerPlayer = SamplerPlayer()

    // 48 is just for testing purposes
    var latestPlayedNote: UInt8 = 48

    init() {
        super.init(nibName: nil, bundle: Bundle.main)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = Feature1View()
        view.actionsDelegate = self
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func configure() {
        navigationItem.largeTitleDisplayMode = .always
        title = "Feature 1"
    }
}

extension Feature1ViewController: Feature1ViewActionsDelegate {
    func feature1View(_ feature1View: Feature1View, didTouchDownButton button: UIButton) {

        // Maximum note value is 127
        if latestPlayedNote > 127 { latestPlayedNote = 48 }
        latestPlayedNote += 1
        samplerPlayer.play(note: latestPlayedNote)
    }

    func feature1View(_ feature1View: Feature1View, didTouchUpInsideButton button: UIButton) {
        samplerPlayer.stop(note: latestPlayedNote)
    }
}
