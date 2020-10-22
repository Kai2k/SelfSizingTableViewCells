
import UIKit

class AuteurDetailViewController: UIViewController {
  var selectedAuteur: Auteur!
  let moreInfoText = "Tap For Details >"
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = selectedAuteur.name
    self.tableView.contentInsetAdjustmentBehavior = .never
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 300
  }
}

extension AuteurDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selectedAuteur.films.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
      -> UITableViewCell {
    let cell = tableView
      .dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FilmTableViewCell
    let film = selectedAuteur.films[indexPath.row]
    cell.filmTitleLabel.text = film.title
    cell.filmImageView.image = UIImage(named: film.poster)
    cell.filmTitleLabel.textColor = .white
    cell.filmTitleLabel.textAlignment = .center
    cell.moreInfoTextView.textColor = .red
    cell.moreInfoTextView.text = film.isExpanded ? film.plot : moreInfoText
    cell.moreInfoTextView.textAlignment = film.isExpanded ? .left : .center
    cell.moreInfoTextView.textColor = film.isExpanded ?
      UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0) :
      .red
    cell.selectionStyle = .none
    return cell
  }
}

extension AuteurDetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  // 1
  guard let cell = tableView.cellForRow(at: indexPath) as? FilmTableViewCell else {
    return
  }
  
  var film = selectedAuteur.films[indexPath.row]

  // 2
  film.isExpanded = !film.isExpanded
  selectedAuteur.films[indexPath.row] = film

  // 3
  cell.moreInfoTextView.text = film.isExpanded ? film.plot : moreInfoText
  cell.moreInfoTextView.textAlignment = film.isExpanded ? .left : .center
  cell.moreInfoTextView.textColor = film.isExpanded ?
    UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0) :
    .red

  // 4
  tableView.beginUpdates()
  tableView.endUpdates()

  // 5
  tableView.scrollToRow(at: indexPath, at: .top, animated: true)
 }
}

