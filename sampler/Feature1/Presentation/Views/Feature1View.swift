//
//  Created by Karina Lipnyagova on 20.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit
import DrumPads24UICore

protocol Feature1ViewActionsDelegate: AnyObject {
    func feature1View(_ feature1View: Feature1View, didTouchUpInsideButton button: UIButton)
}

class Feature1View: UIView {

    weak var actionsDelegate: Feature1ViewActionsDelegate?

    private enum Constants {
        static let buttonCount: Int = 12
    }

    private var contentView: UIView!
    private var samplerButton: UIButton!

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
        samplerButton.frame = calcSamplerButtonFrame(samplerButton, inside: contentView.frame)
    }

    // MARK: - Private

    private func configureView() {
        backgroundColor = .white
    }

    // MARK: - Actions

    @objc private func didTouchUpInsideButton(_ button: UIButton) {
        actionsDelegate?.feature1View(self, didTouchUpInsideButton: button)
    }

    // MARK: - Add Subviews

    private func addSubviews() {
        contentView = makeContentView()
        addSubview(contentView)

        samplerButton = makeSamplerButton()
        contentView.addSubview(samplerButton)
    }

    private func makeContentView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear

        return view
    }

    private func makeSamplerButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
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

    private func calcSamplerButtonFrame(
        _ button: UIButton,
        inside rootFrame: CGRect
    ) -> CGRect {
        var frame = CGRect.zero
        frame.size.width = rootFrame.width
        frame.size.height = 56
        frame.origin.y = (rootFrame.height - frame.height) / 2

        return frame
    }
}
