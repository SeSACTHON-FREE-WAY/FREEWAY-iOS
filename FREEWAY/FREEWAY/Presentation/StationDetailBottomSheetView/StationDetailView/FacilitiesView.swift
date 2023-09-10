//
//  FacilitiesViewController.swift
//  FREEWAY
//
//  Created by 한택환 on 2023/09/02.
//

import UIKit
import Then
import SnapKit

final class FacilitiesView: UIView {
    var data: Facilities
    
    struct FailitiesData {
        let title: String
        let imageName: String
        let status: Bool
    }
    
    private lazy var facilitieDatas: [FailitiesData] = [
        FailitiesData(title: "장애인 화장실", imageName: "disabledToilet", status: data.disabledToilet ?? false),
        FailitiesData(title: "휠체어 리프트", imageName: "wheelchairLift", status: data.wheelchairLift ?? false),
        FailitiesData(title: "유아수유방", imageName: "feedingRoom", status: data.feedingRoom ?? false),
        FailitiesData(title: "환전키오스크", imageName: "currencyExchangeKiosk", status: data.currencyExchangeKiosk ?? false),
        FailitiesData(title: "무인민원발급기", imageName: "unmannedCivilApplicationIssuingMachine", status: data.unmannedCivilApplicationIssuingMachine ?? false),
        FailitiesData(title: "환승주차장", imageName: "transitParkingLot", status: data.transitParkingLot ?? false)
    ]
    
    let updateTimeLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 12)
        $0.textColor = Pallete.updatedTextGray.color
        $0.text = "0/00 0요일 00:00 업데이트 완료"
    }
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .clear
        $0.rowHeight = 53
        $0.isScrollEnabled = true
        $0.separatorStyle = .none
    }
    
    init(_ data: Facilities) {
        self.data = data
        super.init(frame: .zero)
        self.backgroundColor = .white
        configure()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FacilitiesView {
    func configure() {
        tableView.register(FacilitiesTableViewCell.self, forCellReuseIdentifier: FacilitiesTableViewCell.facilitiesCellId)
        tableView.dataSource = self
    }
    
    func setupLayout() {
        self.addSubview(updateTimeLabel)
        updateTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(updateTimeLabel.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension FacilitiesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        facilitieDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FacilitiesTableViewCell.facilitiesCellId) as? FacilitiesTableViewCell else { return UITableViewCell() }
        let data = facilitieDatas[indexPath.row]
        cell.configure(data.imageName, data.status, data.title)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
}
