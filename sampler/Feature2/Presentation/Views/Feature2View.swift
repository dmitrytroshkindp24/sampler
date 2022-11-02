//
//  Created by Karina Lipnyagova on 20.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit
import DrumPads24UICore

class Feature2View: UIView {
        
    private var contentView: UIView!
    private var titleLabel: UILabel!
    
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
        titleLabel.frame = calcTitleLabelFrame(
            titleLabel,
            inside: contentView.frame)
    }
    
    // MARK: - Private
    
    func configureView() {
        backgroundColor = .white
    }
    
    // MARK: - Actions
    
    // MARK: - Add Subviews
    
    private func addSubviews() {
        contentView = makeContentView()
        addSubview(contentView)
        
        titleLabel = makeTitleLabel()
        contentView.addSubview(titleLabel)
    }
    
    private func makeContentView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "FEATURE 2"
        label.textColor = .purpleA700
        label.numberOfLines = 0
        label.font = UIFont.largeBold
        label.textAlignment = .center
        
        return label
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
    
    private func calcTitleLabelFrame(
        _ label: UILabel,
        inside rootFrame: CGRect
    ) -> CGRect {
        var frame = CGRect.zero
        frame.size.width = rootFrame.width
        frame.size.height = label.sizeThatFits(CGSize(
                                                width: frame.width,
                                                height: rootFrame.height)).height
        frame.origin.y = (rootFrame.height - frame.height) / 2

        frame.origin.y -= frame.height
        
        return frame
    }

}
