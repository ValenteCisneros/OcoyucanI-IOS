//
//  CurrentRunViewController.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 30/10/24.
//

import UIKit
import CoreLocation

class CurrentRunViewController: BaseViewController {
    
    private static let titleFontSize: CGFloat = 32
    private static let subtitleFontSize: CGFloat = 24
    
    private lazy var toplabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "En Ruta"
        v.textAlignment = .center
        v.font = v.font.withSize(Self.titleFontSize)
        v.textColor = .darkGray
        return v
    }()
    
    private lazy var timeLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .white
        v.font = UIFont.boldSystemFont(ofSize: Self.subtitleFontSize)
        v.text = "00:00:00"
        return v
    }()
    
    private lazy var paceTitleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .white
        v.text = "Ritmo Promedio" // cambiar
        v.font = v.font.withSize(Self.subtitleFontSize)
        return v
    }()
    
    
    private lazy var paceLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .white
        v.text = "0:00"
        v.font = UIFont.boldSystemFont(ofSize: Self.titleFontSize)
        return v
    }()
    
    private lazy var paceSubTitleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .white
        v.text = "/mts"
        v.font = v.font.withSize(Self.subtitleFontSize)
        return v
    }()
    
    private lazy var paceStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [paceTitleLabel, paceLabel, paceSubTitleLabel])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alignment = .center
        v.axis = .vertical
        v.distribution = .equalSpacing
        return v
    }()
    
    private lazy var distanceTitleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .white
        v.text = "Distancia"
        v.font = v.font.withSize(Self.subtitleFontSize)
        return v
    }()
    
    private lazy var distanceLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .white
        v.text = "0.0"
        v.font = UIFont.boldSystemFont(ofSize: Self.titleFontSize)
        return v
    }()
    
    private lazy var distanceSubtitleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .white
        v.text = "mts"
        v.font = v.font.withSize(Self.subtitleFontSize)
        return v
    }()
    
    private lazy var distanceStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [distanceTitleLabel, distanceLabel, distanceSubtitleLabel])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alignment = .center
        v.axis = .vertical
        v.distribution = .equalSpacing
        return v
    }()
    
    private lazy var pageStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [timeLabel, paceStackView, distanceStackView])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alignment = .center
        v.axis = .vertical
        v.distribution = .equalCentering
        v.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return v
    }()
    
    private lazy var capsuleView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        v.layer.cornerRadius = 35
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var stopsSliderKnob: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isUserInteractionEnabled = true
        v.image = UIImage(systemName: "dot.arrowtriangles.up.right.down.left.circle")
        v.tintColor = .white
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 5
        v.layer.cornerRadius = 25
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var sliderStop: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(systemName: "stop.circle")
        v.tintColor = .white
        v.layer.borderColor = UIColor.clear.withAlphaComponent(0.5).cgColor
        v.layer.borderWidth = 5
        v.layer.cornerRadius = 35
        v.layer.masksToBounds = true
        return v
    }()
    
    private var startLocation: CLLocation!
    private var endLocation: CLLocation!
    
    private var runDistance = 0.0
    private var timeElapsed = 0
    private var pace = 0
    
    private var locationManager =  LocationManager()
    
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.manager.delegate = self
        startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopRun()
        super.viewWillDisappear(animated)
    }
    
    private func setupViews() {
        view.addSubview(toplabel)
        view.addSubview(pageStackView)
        view.addSubview(capsuleView)
        capsuleView.addSubview(stopsSliderKnob)
        capsuleView.addSubview(sliderStop)
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissEnd(sender:)))
        stopsSliderKnob.addGestureRecognizer(swipeGesture)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            toplabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toplabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toplabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toplabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            pageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageStackView.topAnchor.constraint(equalTo: toplabel.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            capsuleView.widthAnchor.constraint(equalToConstant: 300),
            capsuleView.heightAnchor.constraint(equalToConstant: 70),
            capsuleView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            capsuleView.topAnchor.constraint(equalTo: pageStackView.bottomAnchor, constant: 8),
            capsuleView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stopsSliderKnob.leadingAnchor.constraint(equalTo: capsuleView.leadingAnchor, constant: 8 ),
            stopsSliderKnob.centerYAnchor.constraint(equalTo: capsuleView.centerYAnchor),
            stopsSliderKnob.widthAnchor.constraint(equalToConstant: 50),
            stopsSliderKnob.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        NSLayoutConstraint.activate([
            sliderStop.leadingAnchor.constraint(equalTo: capsuleView.trailingAnchor),
            sliderStop.centerYAnchor.constraint(equalTo: capsuleView.centerYAnchor),
            sliderStop.widthAnchor.constraint(equalToConstant: 70),
            sliderStop.heightAnchor.constraint(equalToConstant: 70)
            ])
    }
    
    private func startRunning() {
        locationManager.manager.startUpdatingLocation()
        startTimer()
    }
    
    private func stopRun() {
        locationManager.manager.stopUpdatingLocation()
        stopTimer()
    }
    
    private func startTimer() {
        timeLabel.text = timeElapsed.formatTimeStrig()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer.invalidate()
        timeElapsed = 0
    }
    
    @objc private func updateTimer() {
        timeElapsed += 1
        timeLabel.text = timeElapsed.formatTimeStrig()
    }
    private func computePace(time seconds: Int, miles: Double) -> String {
        pace = Int(Double(seconds) / miles)
        return pace.formatTimeStrig()
    }
    @objc private func dismissEnd(sender: UIPanGestureRecognizer) {
        let adjust : CGFloat = 35
        let translation = sender.translation(in: view)
        
        if sender.state == .began || sender.state == .changed {
            
            if stopsSliderKnob.center.x > sliderStop.center.x{
                stopsSliderKnob.center.x = sliderStop.center.x
                stopRun()
                dismiss(animated: true)
            }else if stopsSliderKnob.center.x < capsuleView.bounds.minX + adjust {
                stopsSliderKnob.center.x = capsuleView.bounds.minX + adjust
            }else{
                stopsSliderKnob.center.x += translation.x
            }

        }else if sender.state == .ended && stopsSliderKnob.center.x < sliderStop.center.x {
            UIView.animate(withDuration: 0.5){
                self.stopsSliderKnob.center.x = self.capsuleView.bounds.minX + adjust
            }
          }
        }
}
extension CurrentRunViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil{
            startLocation = locations.first
        }else if let location = locations.last{
            runDistance += endLocation.distance(from: location)
            self.distanceLabel.text = self.runDistance.meterToMeter().toString(places: 2)
            
            if timeElapsed > 0 && runDistance > 0{
                paceLabel.text = computePace(time: timeElapsed, miles: runDistance.meterToMeter())
            }
        }
        endLocation = locations.last
    }
}
