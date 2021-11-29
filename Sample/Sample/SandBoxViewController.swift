//
//  SandBoxViewController.swift
//  SandBox
//
//  Created by TLSP-000092 on 25/11/21.
//

import UIKit
import ProgressBar

class SandBoxViewController: UIViewController {
	
	lazy var progressBar: ProgressBar = {
		let view = ProgressBar()
		view.setBackgroundColor(.orange)
		view.setProgressRounded(20)
		view.setHeight(50)
		return view
	}()
	
	lazy var progressBarReverse: ProgressBar = {
		let view = ProgressBar()
		view.setProgressRounded(20)
		view.setProgressColor(.black)
		view.setHeight(50)
		return view
	}()
	
	lazy var progressBarPercent: ProgressBar = {
		let view = ProgressBar()
		view.setBackgroundColor(.gray)
		view.setProgressRounded(20)
		view.setHeight(50)
		view.setProgressColor(.black)
		return view
	}()
	
	lazy var stackView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		view.distribution = .fill
		view.spacing = 16
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .yellow
		
		stackView.addArrangedSubview(progressBar)
		stackView.addArrangedSubview(progressBarReverse)
		stackView.addArrangedSubview(progressBarPercent)
		view.addSubview(stackView)
		stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
		stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let gradient = CAGradientLayer()
		gradient.type = .axial
		gradient.colors = [
			UIColor.red.cgColor,
			UIColor.purple.cgColor
		]
		gradient.locations = [0, 0.5]
		gradient.startPoint = CGPoint(x: 0, y: 1)
		gradient.endPoint = CGPoint(x: 1, y: 1)
		gradient.frame = progressBar.bounds
		progressBar.setProgressLayer(gradient)
		
        progressBar.completeProgressIn(seconds: 5, direction: .leftToRight) { _ in
			print("progressBar complete")
		}
        
        progressBarReverse.completeProgressIn(seconds: 5, direction: .rightToLeft) { _ in
            print("progressBar complete")
        }
		
//		progressBarReverse.completeProgressReverseIn(seconds: 5) { _ in
//			print("completeProgressReverseIn complete")
//		}
		
		var percent: CGFloat = 0.0
		Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
			percent += 0.2
			self.progressBarPercent.completeProgress(percent: percent) { _ in
				if percent == 1 {
					timer.invalidate()
				}
				print("progressBarPercent complete \(percent)")
			}
		}
		
	}
}

/*

avancar por step
avancar por tempo

animar ou não animar em ambos os casos



*/
