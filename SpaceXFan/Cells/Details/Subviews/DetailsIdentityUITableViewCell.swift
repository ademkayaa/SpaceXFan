//
//  DetailsIdentityUITableViewCell.swift
//  SpaceXFan
//
//  Created by Adem Kaya
//

import UIKit

class DetailsIdentityUITableViewCell: UITableViewCell {

    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .regular)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.text = "descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,descriptionLabel,v,v,descriptionLabel,descriptionLabel,descriptionLabel"
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 5
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()

    static let identifier = "DetailsIdentityUITableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)


        applyConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("IdentityUITableViewCell error")
    }

    override func prepareForReuse() {
        stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }

    private func applyConstraints() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }

    func configure(with rocket: Rocket) {
        descriptionLabel.text = rocket.description

        stackView.addArrangedSubview(descriptionLabel)

        let type = getLine()
        type.titleLabel.text = "Type"
        type.descriptionLabel.text = rocket.type

        let active = getLine()
        active.titleLabel.text = "Active"
        active.descriptionLabel.text = ""

        let boosters = getLine()
        boosters.titleLabel.text = "Boosters"
        boosters.descriptionLabel.text = ""

        let cost_per_launch = getLine()
        cost_per_launch.titleLabel.text = ""
        cost_per_launch.descriptionLabel.text = ""

        let success_rate_pct = getLine()
        success_rate_pct.titleLabel.text = ""
        success_rate_pct.descriptionLabel.text = ""

        let first_flight = getLine()
        first_flight.titleLabel.text = ""
        first_flight.descriptionLabel.text = ""

        let country = getLine()
        country.titleLabel.text = ""
        country.descriptionLabel.text = ""

        let company = getLine()
        company.titleLabel.text = ""
        company.descriptionLabel.text = ""

        let height = getLine()
        height.titleLabel.text = ""
        height.descriptionLabel.text = ""

        let diameter = getLine()
        diameter.titleLabel.text = ""
        diameter.descriptionLabel.text = ""

        let mass = getLine()
        mass.titleLabel.text = ""
        mass.descriptionLabel.text = ""
    }

    private func getLine() -> DetailsLineDefinition {
        let view = DetailsLineDefinition()
        stackView.addArrangedSubview(view)
        return view
    }
}
