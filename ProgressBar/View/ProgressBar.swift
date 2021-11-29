//
//  ProgressBar.swift
//  ProgressBar
//
//  Created by TLSP-000092 on 25/11/21.
//

import UIKit

public final class ProgressBar: UIView {

	private lazy var progressView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		return view
	}()
	
	private var leadingConstraint: NSLayoutConstraint?
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupView()
	}
	
	required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setupView()
	}
	
	public func setProgressColor(_ color: UIColor) {
		backgroundColor = color
	}
	
	public func setBackgroundColor(_ color: UIColor) {
		progressView.backgroundColor = color
	}
	
	public func setProgressRounded(_ value: CGFloat) {
		layer.cornerRadius = value
		layer.masksToBounds = true
	}
	
	public func setProgressLayer(_ layer: CALayer) {
		self.subviews.forEach({ $0.removeFromSuperview() })
		self.layer.addSublayer(layer)
		setupView()
	}
	
	public func setHeight(_ height: CGFloat) {
		heightAnchor.constraint(equalToConstant: height).isActive = true
	}
	
    public func completeProgress(percent: CGFloat, completion: ((Bool) -> ())? = nil) {
		let width = frame.size.width * percent
		leadingConstraint?.constant = width
		updateProgress(seconds: 0.5, completion: completion)
	}
	
	public func completeProgressIn(seconds: Double, direction: ProgressDirection, completion: ((Bool) -> ())? = nil) {
        leadingConstraint?.constant = frame.size.width
        switch direction {
        case .rightToLeft:
            layoutIfNeeded()
            leadingConstraint?.constant = 0
        case .leftToRight:
            break
        }
		updateProgress(seconds: seconds, completion: completion)
	}
	
	private func updateProgress(seconds: Double, completion: ((Bool) -> ())? = nil) {
		UIView.animate(withDuration: seconds, delay: 0, options: .curveLinear) {
			self.layoutIfNeeded()
		} completion: { success in
			completion?(success)
		}
	}
}

extension ProgressBar: SetupView {
    
	func addViews() {
		addSubview(progressView)
	}
	
	func addConstraints() {
		leadingConstraint = self.progressView.leadingAnchor.constraint(equalTo: leadingAnchor)
		NSLayoutConstraint.activate([
			leadingConstraint!,
			progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
			progressView.topAnchor.constraint(equalTo: topAnchor),
			progressView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
    
    func additionalConfig() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
