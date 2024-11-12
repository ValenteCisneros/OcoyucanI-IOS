//
//  HistoryViewController.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 03/11/24.
//

import UIKit

class HistoryViewController: BaseViewController {
    
    private static let reuseId = "REUSEID"
    
    private lazy var topLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Historial de rutas"
        v.textAlignment = .center
        v.textColor = .white
        v.font = v.font.withSize(32)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var tableView: UITableView = {
       let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.allowsSelection = false //Cambiar despues
        v.delegate = self
        v.dataSource = self
        v.register(HistoryTableViewCell.self, forCellReuseIdentifier: Self.reuseId)
        v.backgroundColor = .clear
        v.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        v.separatorColor = UIColor(red: 151/255, green: 197/255, blue: 55/255, alpha: 1.0) 
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private lazy var backButton: UIButton = {
        let v = UIButton(type: .system)
        v.setTitle("Back", for: .normal)
        v.setTitleColor(.white, for: .normal)
        v.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private func setupViews() {
        view.addSubview(topLabel)
        view.addSubview(tableView)
        view.addSubview(backButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 8),
            topLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.reuseId) as? HistoryTableViewCell else{
            return UITableViewCell()
        }
        cell.totalMeters = Double(indexPath.row)
        cell.totalTime = "0:23:12"
        cell.entryDate = "01/01/2024"
        return cell
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
