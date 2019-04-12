import UIKit

// MARK: - ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var tableView: UITableView!
    
    // This is an array of saved images.
    var memes: [Meme]{ return appDelegate.memes}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topText + meme.bottomText
        cell.imageView?.image = meme.memedImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(detailController, animated: true)
    }
}

