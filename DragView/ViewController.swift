//
//  ViewController.swift
//  DragView
//
//  Created by Preetam Godase on 01/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    var circlePanGesture: UIPanGestureRecognizer!
    
    @IBOutlet weak var tableView: UITableView!
    
    var didInitialise: Bool = false
    
    let circleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.backgroundColor = .red
        view.layer.cornerRadius = view.frame.width / 2
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circlePanGesture = UIPanGestureRecognizer(target: self, action: #selector(circleDidDrag))
        circleView.addGestureRecognizer(circlePanGesture)
    }
    
    @objc func circleDidDrag() {
        // location in table view
        let pointInTableView = circlePanGesture.location(in: tableView)
        
        // gets the indexpath using the tap location with respect to tableView
        if let movedIndexPath = tableView.indexPathForRow(at: pointInTableView) {
            
            // Cell to which the view is to be added
            let cell = tableView.cellForRow(at: movedIndexPath)
            
            // tap location with respect to cell
            let newPoint = circlePanGesture.location(in: cell?.contentView)
            
            // configure nre frame to over Circle View
            let newFrame = CGRect(x: newPoint.x - (circleView.frame.width / 2), y: newPoint.y - (circleView.frame.height / 2), width: circleView.frame.width, height: circleView.frame.height)
            circleView.frame = newFrame
            
            cell?.addSubview(circleView)
            
            print(movedIndexPath[1], "index")
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 && !didInitialise { // adding circle for only the first time
            cell.contentView.addSubview(circleView)
            didInitialise = true
        }
        cell.backgroundColor = UIColor(displayP3Red: CGFloat(indexPath.row / 2), green: CGFloat(indexPath.row / 3), blue: CGFloat(indexPath.row / 4), alpha: CGFloat(indexPath.row / 5))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
