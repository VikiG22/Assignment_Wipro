//
//  DashboardTableViewCell.swift
//  Assignment_VikramGupta
//
//  Created by Vikram Gupta on 7/23/20.
//  Copyright © 2020 Vikram Gupta. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

  // Cell background custom view
  private let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.clipsToBounds = true
    view.layer.cornerRadius = 4
    view.backgroundColor = UIColor.white
    return view
  }()
  // ImageView property
  private let imgFacts: UIImageView = {
    let img = UIImageView.init(image: UIImage(named: "placeholder"))
    img.contentMode = .scaleAspectFill
    img.translatesAutoresizingMaskIntoConstraints = false
    img.clipsToBounds = true
    img.layer.borderWidth = 1
    img.layer.borderColor = UIColor.darkGray.cgColor
    return img
  }()
  // Facts item title lebel property
  private let lblTitle: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name:Font_Helvetica_Neue,size:FONT_SIZE_18)
    label.textColor = titleColor()
    label.numberOfLines = 0
    return label
  }()
  // Facts item description lebel property
  private let lblDescription: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = UIFont(name:Font_Helvetica_Neue,size:FONT_SIZE_14)
    label.textColor = .darkGray
    return label
  }()
  // Initailize Table view cell
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    // Adding image view in container
    containerView.addSubview(imgFacts)
    // Adding title label in container
    containerView.addSubview(lblTitle)
    // Adding description label in container
    containerView.addSubview(lblDescription)
    contentView.addSubview(containerView)
    addConstraints() // adding contarints on all subview which added on cell container
    self.selectionStyle = .none
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // Grouping all subviews Autolayout costarints
  private func addConstraints() {
    addConstraintsContainerView()
    addConstraintsImageView()
    addConstraintsTitltLbl()
    addConstraintsdescription()
  }

  // Adding autolayout constraints on Container View
  fileprivate func addConstraintsContainerView() {
    containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 86).isActive = true
    containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
    containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
    containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
  }

  // Adding autolayout constraints on Imageview
  fileprivate func addConstraintsImageView() {
    imgFacts.translatesAutoresizingMaskIntoConstraints = false
    imgFacts.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
    imgFacts.widthAnchor.constraint(equalToConstant: 75).isActive = true
    imgFacts.heightAnchor.constraint(equalToConstant: 75).isActive = true
    imgFacts.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
  }

  // Adding autolayout constraints on title Label
  fileprivate func addConstraintsTitltLbl() {
    lblTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
    lblTitle.leadingAnchor.constraint(equalTo: imgFacts.trailingAnchor, constant: 10).isActive = true
    lblTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
  }

  // Adding autolayout constraints on description Label
  fileprivate func addConstraintsdescription() {
    lblDescription.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor).isActive = true
    lblDescription.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    lblDescription.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5).isActive = true
    lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive = true
  }

  // Update Cell Detail With Row
  func setCellData(result: Row) {
    lblTitle.text = result.title
    lblDescription.text = result.description
    if let imagePath = result.imageHref {
      imgFacts.loadImageUsingCache(withUrl: imagePath)
    } else {
      imgFacts.image = UIImage(named: "placeholder")
    }
  }
}
