//
//  Created by Karina Lipnyagova on 14.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit
import DrumPads24UICore

protocol StoreViewActionsDelegate: AnyObject {
    func storeView(
        _ storeView: StoreView,
        didTouchUpInsideBuyButton button: UIButton)
}

class StoreView: UIView {

    // MARK: - Public Properties
    
    public weak var actionsDelegate: StoreViewActionsDelegate?

    // MARK: - Private Properties
    
    private var contentView: UIView!
    private var titleLabel: UILabel!
    private var buyButton: UIButton!
    
    private var spacing: CGFloat {
        2 * baselineGrid
    }
    
    override var alignmentRectInsets: UIEdgeInsets {
        let verticalInset: CGFloat = 6 * self.baselineGrid
        let horizontalInset: CGFloat = 4 * self.baselineGrid
        
        let insets = UIEdgeInsets(
            top: verticalInset,
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
        buyButton.frame = calcBuyButtonFrame(buyButton, inside: contentView.frame)
        titleLabel.frame = calcTitleLabelFrame(
            titleLabel,
            under: buyButton.frame,
            inside: contentView.frame)
    }
    
    // MARK: - Private
    
    private func configureView() {
        backgroundColor = .white
    }
    
    // MARK: - Actions
    
    @objc private func didTouchUpInsideBuyButton(_ button: UIButton) {
        actionsDelegate?.storeView(self, didTouchUpInsideBuyButton: button)
    }
    
    // MARK: - Add Subviews
    
    private func addSubviews() {
        contentView = makeContentView()
        addSubview(contentView)
        
        titleLabel = makeTitleLabel()
        contentView.addSubview(titleLabel)
        
        buyButton = makeBuyButton()
        contentView.addSubview(buyButton)
    }
    
    private func makeContentView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        //label.text = NSLocalizedString("store.title", comment: "")
        label.text = StoreLocalizedString("getPremiumAccess")
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.largeBold
        label.textAlignment = .center
        
        return label
    }
    
    private func makeBuyButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Subscribe", for: .normal)
        button.titleLabel?.font = UIFont.normalRegular
        button.setTitleColor(.black, for: .normal)
        button.addTarget(
            self,
            action: #selector(didTouchUpInsideBuyButton(_:)),
            for: .touchUpInside)
        
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
    
    private func calcBuyButtonFrame(_ button: UIButton, inside rootFrame: CGRect) -> CGRect {
        button.sizeToFit()
        var frame = button.frame
        frame.origin.x = 0
        frame.origin.y = rootFrame.height - frame.height
        frame.size.width = rootFrame.width - 2 * frame.minX
        
        return frame
    }
    
    private func calcTitleLabelFrame(
        _ label: UILabel,
        under relatedFrame: CGRect,
        inside rootFrame: CGRect
    ) -> CGRect {
        var frame = CGRect.zero
        frame.origin.x = relatedFrame.minX
        frame.origin.y = relatedFrame.minY - 2 * spacing
        frame.size.width = relatedFrame.width
        let maxHeight = rootFrame.height - frame.minY
        frame.size.height = label.sizeThatFits(CGSize(
                                                width: frame.width,
                                                height: maxHeight)).height
        frame.origin.y -= frame.height
        
        return frame
    }

}
