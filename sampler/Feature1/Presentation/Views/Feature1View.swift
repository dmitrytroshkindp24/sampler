//
//  Created by Karina Lipnyagova on 20.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit
import DrumPads24UICore

protocol Feature1ViewActionsDelegate: AnyObject {
    func feature1View(_ feature1View: Feature1View, willPlayNoteAt index: Int)
    func feature1View(_ feature1View: Feature1View, willStopNoteAt index: Int)
}

class Feature1View: UIView {

    // MARK: - Public Properties

    weak var actionsDelegate: Feature1ViewActionsDelegate?

    // MARK: - Private Properties

    private var contentView: UIView!
    private var samplerButtons = [UIButton]()

    private var spacing: CGFloat {
        get {
            2 * self.baselineGrid
        }
    }

    override var alignmentRectInsets: UIEdgeInsets {
        let verticalInset: CGFloat = 4 * self.baselineGrid
        let horizontalInset: CGFloat = 4 * self.baselineGrid

        let insets = UIEdgeInsets(
            top: 0,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset)

        return insets
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = calcContentViewFrame(inside: self.bounds)
        guard samplerButtons.count != 0 else { return }
        calcSamplerButtonsFrames(samplerButtons, inside: contentView.frame)

    }

    // MARK: - Public

    public func updateUI(with notes: [UInt8]) {
        notes.forEach { note in
            let button = makeSamplerButton(with: String(note))
            samplerButtons.append(button)
            contentView.addSubview(button)
        }
        setNeedsLayout()
    }

    // MARK: - Private

    private func configureView() {
        backgroundColor = .white
    }

    // MARK: - Actions

    @objc private func didTouchDownButton(_ button: UIButton) {
        guard let index = samplerButtons.firstIndex(of: button) else { return }
        actionsDelegate?.feature1View(self, willStopNoteAt: index)
    }

    @objc private func didTouchUpInsideButton(_ button: UIButton) {
        guard let index = samplerButtons.firstIndex(of: button) else { return }
        actionsDelegate?.feature1View(self, willPlayNoteAt: index)
    }

    // MARK: - Add Subviews

    private func addSubviews() {
        contentView = makeContentView()
        addSubview(contentView)
    }

    private func makeContentView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear

        return view
    }

    private func makeSamplerButton(with name: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Play sampler note #\(name)", for: .normal)
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didTouchDownButton(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(didTouchUpInsideButton(_:)), for: .touchUpInside)

        return button
    }

    // MARK: - Layout Subviews

    private func calcContentViewFrame(inside rootFrame: CGRect) -> CGRect {
        var frame = CGRect(origin: .zero, size: rootFrame.size)
        frame = frame.inset(by: safeAreaInsets)
        if UIDevice.current.isIPad {
            frame = frame.inset(by: iPadAreaInsets)
        }
        frame = frame.inset(by: alignmentRectInsets)

        return frame
    }

    private func calcSamplerButtonsFrames(_ buttons: [UIButton], inside rootFrame: CGRect) {
        var y: CGFloat = 0
        let height = rootFrame.height / CGFloat(buttons.count) - spacing
        buttons.forEach { button in
            var frame = CGRect.zero
            frame.size.width = rootFrame.width
            frame.size.height = height
            frame.origin.y = y
            y = frame.maxY + spacing
            button.frame = frame
        }
    }
}
