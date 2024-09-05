import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let networkingManager = NetworkingManager()
    
    var facts: [Fact] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

     override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableViewLayout()
        getFacts()
        
    }
    
    private func getFacts() {
        networkingManager.request(endpoint: CatsAPI.facts) { (result: Result<[Fact], NetworkingError>) in
            switch result {
                
            case .success(let facts):
                self.facts = facts
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(for: error)
                }
            }
        }
    }
    
    
    private func setUpTableViewLayout() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func showAlert(for error: NetworkingError) {
            let alertController = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            self.getFacts()
        }
            alertController.addAction(retryAction)
            
            present(alertController, animated: true, completion: nil)
        }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let fact = facts[indexPath.row]
        cell.textLabel?.text = fact.text
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
}
