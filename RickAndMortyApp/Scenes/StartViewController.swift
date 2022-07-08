//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Eduard on 08.07.2022.
//

import UIKit
import SnapKit
final class StartViewController: UIViewController {
    //MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: view.frame.width * 0.05, bottom: 0, right: view.frame.width * 0.05)
        layout.itemSize = CGSize(width: view.frame.width * 0.42, height: view.frame.width * 0.6)
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RickMortyCell.self, forCellWithReuseIdentifier: RickMortyCell.reuseCell)
        return collectionView
    }()
    
    var presenter: StartPresenterProtocol?
    
    //MARK: - View Life
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .red
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstrains()
    }
    
    //MARK: - Private Methods
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        title = "Rick And Morty"
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstrains() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.snp_topMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension StartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfRows ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RickMortyCell.reuseCell, for: indexPath) as? RickMortyCell else { return UICollectionViewCell()}
        guard let currentItem = presenter?.data[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(currentItem.name ?? "", currentItem.status ?? "", currentItem.image ?? "")
        return cell
    }
}

extension StartViewController: StartViewProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
}
    

