//
//  HistoryTableViewCell.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 03/11/24.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {
    
    
    var totalMeters: Double = 0.0 {
        didSet {
            totalMetersLabel.text = String(format: "%0.1f", totalMeters)
            layoutIfNeeded()
        }
    }
    
    var totalTime: String = "00:02:12"{
        didSet{
            totalTimeLabel.text = totalTime
            layoutIfNeeded()
        }
    }
    
    var entryDate: String = "04/01/2024"{
        didSet{
            entryDateLabel.text = entryDate
            layoutIfNeeded()
        }
    }
    private lazy var totalMetersLabel: UILabel =  {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "0.0"
        v.textColor = .white
        v.font = UIFont.boldSystemFont(ofSize: 24)
        return v
    }()
    
    private lazy var totalTimeLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "0.0"
        v.textColor = .white
        v.font = v.font.withSize(18)
        return v
    }()
    
    private lazy var entryDateLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "0.0"
        v.textColor = .white
        v.font = v.font.withSize(18)
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = UIColor.black.withAlphaComponent(0.1)
        contentView.addSubview(totalMetersLabel)
        contentView.addSubview(totalTimeLabel)
        contentView.addSubview(entryDateLabel)
    }
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            totalMetersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            totalMetersLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            totalTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            totalTimeLabel.topAnchor.constraint(equalTo: totalMetersLabel.bottomAnchor, constant: 8),
            totalTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            entryDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            entryDateLabel.centerYAnchor.constraint(equalTo: totalTimeLabel.centerYAnchor)
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func configure(run: Run){
        totalMeters = run.distance.meterToMeter()
        totalTime = run.duration.formatTimeStrig()
        entryDate = run.date.getDateString()
    }
}
