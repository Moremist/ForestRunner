import UIKit

class StartViewController: UIViewController {

    
    @IBOutlet weak var pressToStartButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            UIView.animate(withDuration: 0.5) {
                self.pressToStartButton.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.pressToStartButton.alpha = 1
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let blurView = UIVisualEffectView(frame: self.view.frame)
        blurView.alpha = 1
        blurView.effect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        self.view.addSubview(blurView)
        UIView.animate(withDuration: 3) {
            blurView.alpha = 0
        }
    }
    
    @IBAction func pressToStartButtonPressed(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "gameVC") as? GameViewController else {
            fatalError()
        }
        present(vc, animated: false)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
}
