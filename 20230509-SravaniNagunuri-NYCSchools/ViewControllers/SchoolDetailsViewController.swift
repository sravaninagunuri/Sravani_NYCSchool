//
//  SchoolDetailsViewController.swift
//  20230509-SravaniNagunuri-NYCSchools
//
//  Created by Sravani Nagunuri on 5/9/23.
//

import Foundation
import UIKit
import MapKit

class SchoolDetailsViewController: UIViewController {
    
    //MARK: - private outlets
    
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet private var schoolDescription: UITextView!
    
    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    
    
    @IBOutlet weak var SchoolAddress: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    
    @IBOutlet weak var emailImage: UIButton!
    @IBOutlet weak var websiteImage: UIButton!
    @IBOutlet weak var phoneImage: UIButton!
    @IBOutlet weak var mapImage: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    
    @IBOutlet weak var satScoreView: UIView!
    @IBOutlet weak var AboutSchoolView: UIView!
    @IBOutlet weak var ContactInfoView: UIView!
    
    
    weak var delegate: SchoolDetailsDelegate?
    
    private var score: SATScore?
    var school: School?
    
    lazy var detailViewModel = SchoolDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchScores()
    }
    
    /// Make service call to get SATScores for selected school.
    private func fetchScores() {
        
        if let school = school {
            detailViewModel.getDetails(forSelectedSchool: school) { [weak self] (response: [SATScore]?, error) in
                
                if response == nil {
                    
                    DispatchQueue.main.async {
                        let alert =  UIAlertController(title: "Alert", message: "This school dont have information", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
                            self?.dismiss(animated: true, completion: nil)
                        }
                        alert.addAction(okAction)
                        self?.present(alert, animated: true, completion: nil)
                        
                        self?.AboutSchoolView.isHidden = true
                        self?.ContactInfoView.isHidden = true
                        self?.satScoreView.isHidden = true
                        self?.shareBtn.isHidden = true
                    }
                    return
                }
                if let score = response?.first(where: { $0.dbn == self?.school?.dbn }) {
                    self?.score = score
                }
                DispatchQueue.main.async {
                    self?.AboutSchoolView.isHidden = false
                    self?.ContactInfoView.isHidden = false
                    self?.satScoreView.isHidden = false
                    self?.shareBtn.isHidden = false
                    self?.updateUI()
                }
            }
        }
    }
    
    func updateUI() {
        /// school name and school information
        self.schoolName?.text = school?.schoolName
        self.schoolDescription?.text = school?.overviewParagraph
        
        /// SAT score details for selected school
        self.mathLabel?.text = score?.math
        self.readingLabel?.text = score?.reading
        self.writingLabel?.text = score?.writing
        
        /// School Contact Information like Address, email,phone number, website
        self.SchoolAddress?.text = school?.location
        self.email?.text = school?.email
        self.phoneNumber?.text = school?.phone
        self.websiteLbl?.text = school?.website
        
        delegate = self
    }
}

// MARK: - SchoolDetailsDelegate
extension SchoolDetailsViewController: SchoolDetailsDelegate {
  
    func handleUrl(scheme: ShareScheema, url: String?) {
        Utilities.open(scheme: scheme, urlString: url, contoller: self)
    }
}

// MARK: - Button Actions
extension SchoolDetailsViewController {
    
    @IBAction func navigateToEmail() {
        delegate?.handleUrl(
            scheme: .mailto,
            url: "mailto:\(self.school?.email ?? "")"
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        )
    }
    
    @IBAction func navigateToWebsite() {
        delegate?.handleUrl(scheme: .https, url: self.school?.website)
    }
    
    @IBAction private func callPhone() {
        delegate?.handleUrl(scheme: .telprompt, url: self.school?.phone)
    }
    
    @IBAction private func navigateToMaps() {
        if let lattitude = school?.latitude, let longtitude = school?.longitude {
            let address = "maps.google.com/maps?ll=\(lattitude),\(longtitude)"
            delegate?.handleUrl(scheme: .https, url: address)
        }
    }
    
    @IBAction private func shareBtnTapped() {
        let activityVC = UIActivityViewController(activityItems: ["www.google.com"], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
}

