//
//  SecondViewController.swift
//  Stylable-UIKit_Example
//

import UIKit
import StylableUIKit

final class SecondViewController: UIViewController, StylableViewController {
    var stylableSection: StylistSection = Section.second
}

typealias Layer = (LayerFill, LayerOutline?)

final class ThirdViewController: UIViewController, StylableViewController {
    @IBOutlet private var tableView: UITableView!
    var stylableSection: StylistSection = Section.third

    private let fills: [Layer] = [
        (FlatLayerFill(color: .brown), nil),
        (GradientLayerFill(colors: [.blue, .orange], style: .axial(direction: .leftToRight, locations: nil)), nil),
        (ImageLayerFill(image: UIImage(named: "discount-ticket")!, resizingMode: .stretch), nil),
        (ImageLayerFill(image: UIImage(named: "discount-ticket")!, resizingMode: .tile), DashedLayerOutline(color: .red, width: 2, lineDashPattern: [5, 5])),
        (ImageLayerFill(image: UIImage(named: "discount-ticket")!, resizingMode: .stretch, gravity: .center), LinearLayerOutline(color: .black, width: 2)),
        (FlatLayerFill(color: .red), DashedLayerOutline(color: .black, width: 2, lineDashPattern: [10, 50]))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.styleTableView()
    }

    private func styleTableView() {
        let fill = FlatLayerFill(color: .green)
        let style = LayerStyle(fill: fill)
        style.apply(self.tableView)
    }
}

extension ThirdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fills.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Cell # \(indexPath.row)"

        let layer = self.fills[indexPath.row]
        let style = LayerStyle(fill: layer.0, outline: layer.1)
        style.apply(cell)
        // We also have to set the background color of the content view and any other views that are above the background
        // to clear or you won't see the background of the actual cell. This could also be done in the xib.
        cell.contentView.backgroundColor = .clear
        cell.textLabel?.backgroundColor = .clear
        return cell
    }
}
