//
//  Created by Karina Lipnyagova on 20.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit

class Feature1ViewController: UIViewController {

    // MARK: - Private Properties

    private var samplerPlayer: SamplerPlayer = SamplerPlayer()

    // 48 is just for testing purposes
    private var latestPlayedNote: UInt8 = 48

    private var notes: [UInt8] = [48, 56, 62, 70, 78];

    // MARK: - Lifecycle

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
        view.updateUI(with: notes)
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
    func feature1View(_ feature1View: Feature1View, willPlayNoteAt index: Int) {
        samplerPlayer.play(note: notes[index])
    }

    func feature1View(_ feature1View: Feature1View, willStopNoteAt index: Int) {
        samplerPlayer.stop(note: notes[index])
    }
}
