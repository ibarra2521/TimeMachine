//
//  HomeViewController.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 12/10/19.
//  Copyright (c) 2019 Nick iOS. All rights reserved.
//

import UIKit
import MapKit
//import CoreLocation

protocol HomeDisplayLogic: class {
    func displayData(viewModel: HomeUseCases.Fetch.ViewModel)
    func showNClosest(viewModel: HomeUseCases.Algorithm.ViewModel)
}

struct Constant {
    // MARK: - Ints
    static let min = 1900
    static let max = 2020
    static let closest = 20

    // MARK: - Doubles
    static let latMin = -85.0
    static let latMax = 85.0
    static let lngMin = -180.0
    static let lngMax = 180.0
    
    // MARK: - Strings
    static let cellIdentifier = "PrizeCell"
    static let cellEmptyIdentifier = "EmptyCell"
    
    // MARK: - Struct for default values
    struct Defautl {
        static let lat = 52.2042666
        static let lng = 0.1149085
        static let year = 2010
        static let regionRadius = 1000.0
        static let rowHeight: CGFloat = 300.0
    }
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    // MARK: - Properties
    var interactor: HomeBusinessLogic?
    var totalPrize = [Prize]()
    var arrayYear = [[Prize]]()
    var finalArray = [Prize]()
    let k = Constant.self
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var yearValue: UILabel!
        
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
        
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func setupUIControls() {
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.minimumValue = Double(k.min)
        stepper.maximumValue = Double(k.max)
        stepper.value = Double(k.Defautl.year)
    }
    
    // MARK: - IBActions
    @IBAction func search(_ sender: Any) {
        if totalPrize.count > 0 {
            guard let lat = latitude.text, let lng = longitude.text, lat.isNumeric, lng.isNumeric, let latitude = Double(lat), let longitude = Double(lng) else { return }
            let year = Int(stepper.value)
            if (latitude >= k.latMin && latitude <= k.latMax) && (longitude >= k.lngMin && longitude <= k.lngMax) {
                doAlgorithm(year: "\(year)", latitude: latitude, longitude: longitude)
            } else {
                print("Out from limits")
            }
        }
    }
    
    @IBAction func changeYear(_ sender: UIStepper) {
        yearValue.text = "Year: \(Int(sender.value).description)" 
    }
}

// MARK: - Extensions
extension HomeViewController {
    // MARK: - Load JSON
    func loadData() {
        let request = HomeUseCases.Fetch.Request()
        interactor?.doFetch(request: request)
    }
    
    // MARK: - Initialize
    private func initialize() {
        setupTableView()
        setupUIControls()
        setup()
        loadData()
        hideKeyboard()
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        homeTableView.rowHeight = UITableView.automaticDimension
        homeTableView.estimatedRowHeight = k.Defautl.rowHeight
        homeTableView.tableFooterView = UIView(frame: .zero)
        homeTableView.register(UINib(nibName: k.cellIdentifier, bundle: nil), forCellReuseIdentifier: k.cellIdentifier)
        homeTableView.register(UINib(nibName: k.cellEmptyIdentifier, bundle: nil), forCellReuseIdentifier: k.cellEmptyIdentifier)
        homeTableView.reloadData()
    }
    
    // MARK: - Implemented HomeDisplayLogic protocol
    func doAlgorithm(year: String, latitude: Double, longitude: Double) {
        let request = HomeUseCases.Algorithm.Request(totalPrize: totalPrize, year: year, latitude: latitude, longitude: longitude)
        interactor?.applyAlgorithm(request: request)
    }
    
    // MARK: - Implemented HomeDisplayLogic protocol
    func displayData(viewModel: HomeUseCases.Fetch.ViewModel) {
        totalPrize = viewModel.prize
        let kDf = k.Defautl.self
        latitude.text = "\(kDf.lat)"
        longitude.text = "\(kDf.lng)"
        setDefaultPin(location: CLLocation(latitude: kDf.lat, longitude: kDf.lng))
        homeTableView.reloadData()
    }
    
    // MARK: - Implemented HomeDisplayLogic protocol
    func showNClosest(viewModel: HomeUseCases.Algorithm.ViewModel) {
        finalArray = viewModel.prize
        homeTableView.reloadData()
    }
}

extension HomeViewController {
    func setDefaultPin(location: CLLocation) {
        let start = MKPointAnnotation()
        start.title = "Point start"
        start.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude , longitude: location.coordinate.longitude)
        mapView.addAnnotation(start)
        centerMapOnLocation(location: location)
    }
        
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = k.Defautl.regionRadius
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      mapView.setRegion(coordinateRegion, animated: true)
    }
}
