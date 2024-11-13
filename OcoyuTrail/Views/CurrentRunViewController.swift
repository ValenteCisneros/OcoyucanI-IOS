//
//  CurrentRunViewController.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 30/10/24.
//

import UIKit
import CoreLocation
import RealmSwift
import ShimmerSwift

class CurrentRunViewController: BaseViewController {
    
    private static let titleFontSize: CGFloat = 32
    private static let subtitleFontSize: CGFloat = 24
    
    private lazy var toplabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "En Ruta"
        v.textAlignment = .center
        v.font = UIFont.boldSystemFont(ofSize: Self.subtitleFontSize)
        v.textColor = .white
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
        v.text = "Ritmo Promedio" 
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
        v.text = "/km"
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
        v.text = "Km"
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
    
    private lazy var sliderView: UIView = {
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
        v.image = UIImage(systemName: "arrow.left.and.right.circle")
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
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 5
        v.layer.cornerRadius = 35
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var sliderText: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Desliza y para"
        v.textColor = .white
        v.font = v.font.withSize(Self.subtitleFontSize)
        return v
    }()
    
    private lazy var sliderShimmer: ShimmeringView = {
        let v = ShimmeringView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.shimmerSpeed = 1
        v.shimmerPauseDuration = 2
        return v
    }()
    
    private var startLocation: CLLocation!
    private var endLocation: CLLocation!
    
    private var runDistance = 0.0
    private var timeElapsed = 0
    private var pace = 0
    fileprivate var coordLocations = List<Location>()
    
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
        sliderBounceAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopRun()
        super.viewWillDisappear(animated)
    }
    
    private func setupViews() {
        view.addSubview(toplabel)
        view.addSubview(pageStackView)
        view.addSubview(sliderView)
        sliderView.addSubview(stopsSliderKnob)
        sliderView.addSubview(sliderStop)
        
        sliderView.addSubview(sliderText)
        sliderView.addSubview(sliderShimmer)
        
        sliderShimmer.contentView = sliderText
        sliderShimmer.isShimmering = true
        
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
            sliderView.widthAnchor.constraint(equalToConstant: 300),
            sliderView.heightAnchor.constraint(equalToConstant: 70),
            sliderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sliderView.topAnchor.constraint(equalTo: pageStackView.bottomAnchor, constant: 8),
            sliderView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stopsSliderKnob.leadingAnchor.constraint(equalTo: sliderView.leadingAnchor, constant: 8 ),
            stopsSliderKnob.centerYAnchor.constraint(equalTo: sliderView.centerYAnchor),
            stopsSliderKnob.widthAnchor.constraint(equalToConstant: 50),
            stopsSliderKnob.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        NSLayoutConstraint.activate([
            sliderStop.leadingAnchor.constraint(equalTo: sliderView.trailingAnchor),
            sliderStop.centerYAnchor.constraint(equalTo: sliderView.centerYAnchor),
            sliderStop.widthAnchor.constraint(equalToConstant: 70),
            sliderStop.heightAnchor.constraint(equalToConstant: 70)
            ])
        
        NSLayoutConstraint.activate([
            sliderText.centerXAnchor.constraint(equalTo: sliderView.centerXAnchor),
            sliderText.centerYAnchor.constraint(equalTo: sliderView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sliderShimmer.leadingAnchor.constraint(equalTo: sliderView.leadingAnchor, constant: 75),
            sliderShimmer.trailingAnchor.constraint(equalTo: sliderView.trailingAnchor, constant: -75),
            sliderShimmer.topAnchor.constraint(equalTo: sliderView.topAnchor),
            sliderShimmer.bottomAnchor.constraint(equalTo: sliderView.bottomAnchor)
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
    private func computePace(time seconds: Int, kilometers: Double) -> String {
        guard kilometers > 0 else { return "0:00" } 
        pace = Int(Double(seconds) / kilometers)
        return pace.formatTimeStrig()
    }
    @objc private func dismissEnd(sender: UIPanGestureRecognizer) {
        let adjust : CGFloat = 35
        let translation = sender.translation(in: view)
        
        if sender.state == .began || sender.state == .changed {
            
            if stopsSliderKnob.center.x > sliderStop.center.x{
                stopsSliderKnob.center.x = sliderStop.center.x
                let timeElapsed = self.timeElapsed 
                stopRun()
                
                Run.addRunToRealm(pace: pace, distance: runDistance, duration: timeElapsed, locations: coordLocations)
                
                dismiss(animated: true)
            }else if stopsSliderKnob.center.x < sliderView.bounds.minX + adjust {
                stopsSliderKnob.center.x = sliderView.bounds.minX + adjust
            }else{
                stopsSliderKnob.center.x += translation.x
            }

        }else if sender.state == .ended && stopsSliderKnob.center.x < sliderStop.center.x {
            UIView.animate(withDuration: 0.5){
                self.stopsSliderKnob.center.x = self.sliderView.bounds.minX + adjust
            }
          }
        }
    private func sliderBounceAnimation(){
        UIView.animate(withDuration: 0.5){
            self.stopsSliderKnob.center.x += 100
        }completion: { _ in
            UIView.animate(withDuration: 1, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseInOut){
                self.stopsSliderKnob.center.x -= 100
            }completion: { _ in}
        }
    }
}
extension CurrentRunViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil{
            startLocation = locations.first
        }else if let location = locations.last{
            runDistance += endLocation.distance(from: location)
            let newLocation = Location(lat: Double(endLocation.coordinate.latitude), long: Double(endLocation.coordinate.longitude))
            coordLocations.insert(newLocation, at: 0)
            self.distanceLabel.text = String(format: "%.2f", self.runDistance.meterToMeter())
            
            if timeElapsed > 0 && runDistance > 0{
                paceLabel.text = computePace(time: timeElapsed, kilometers: runDistance.meterToMeter())
            }
        }
        endLocation = locations.last
    }
}
