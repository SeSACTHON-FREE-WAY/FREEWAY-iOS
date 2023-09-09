//
//  RecentSearchView.swift
//  FREEWAY
//
//  Created by 한택환 on 2023/08/25.
//

import UIKit
import SnapKit
import Then

final class RecentSearchView: SearchHistoryBaseView {
    
    let searchHistorys = MockData.mockStationDTOs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configure()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RecentSearchView {
    
    func configure() {
        searchHistoryTableView.delegate = self
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.register(SearchHistoryBaseViewCell.self, forCellReuseIdentifier: SearchHistoryBaseViewCell.searchHistoryViewCellId)
    }
    
    func setupLayout() {
        self.addSubview(searchHistoryLabel)
        searchHistoryLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        self.addSubview(searchHistoryTableView)
        searchHistoryTableView.snp.makeConstraints { make in
            make.top.equalTo(searchHistoryLabel.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension RecentSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchHistorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryBaseViewCell.searchHistoryViewCellId) as? SearchHistoryBaseViewCell else { return UITableViewCell() }
        let searchHistory = searchHistorys[indexPath.row]
        cell.configure(data: searchHistory, false, 0)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
}
