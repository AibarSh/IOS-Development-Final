//
//  SettingsViewController.swift
//  AShVelo
//
//  Created by Macbook Air on 12.12.2025.
//


import UIKit

enum AppTheme: String {
    case automatic = "Automatic"
    case dark = "Dark"
    case light = "Light"
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var myPopUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        updateThemeDisplay()
    }
    private func updateThemeDisplay() {
        let currentTheme = UserDefaults.standard.string(forKey: "SelectedTheme") ?? AppTheme.automatic.rawValue
        themeLabel.text = currentTheme
        applyTheme(theme: AppTheme(rawValue: currentTheme) ?? .automatic)
    }

    @IBAction func clearCacheTapped(_ sender: UIButton) {

        let alert = UIAlertController(title: "Clear Cache", message: "This will delete all stored temporary data and search history. Continue?", preferredStyle: .alert)
        
        let clearAction = UIAlertAction(title: "Clear Data", style: .destructive) { [weak self] _ in

             if let bundleID = Bundle.main.bundleIdentifier {
                 UserDefaults.standard.removePersistentDomain(forName: bundleID)
             }

            // 2. Clear image cache or database files (If you implemented them)
            // Example:
            // try? FileManager.default.removeItem(atPath: NSTemporaryDirectory())

            let successAlert = UIAlertController(title: "Success", message: "Cache has been cleared.", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(successAlert, animated: true)
        }
        
        alert.addAction(clearAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    func handleThemeSelection(theme: AppTheme) {
        // 1. Save the user's preference
        UserDefaults.standard.set(theme.rawValue, forKey: "SelectedTheme")
        
        // 2. Apply the theme immediately
        applyTheme(theme: theme)
        
        // 3. Update the UI label
        themeLabel.text = theme.rawValue
    }
    
    private func applyTheme(theme: AppTheme) {
        switch theme {
        case .automatic:
            view.window?.overrideUserInterfaceStyle = .unspecified // Follow system setting
        case .dark:
            view.window?.overrideUserInterfaceStyle = .dark
        case .light:
            view.window?.overrideUserInterfaceStyle = .light
        }
    }
    
    // NOTE: For the Menu Button in Storyboard, you will need to map the three menu items
    // (Automatic, Dark, Light) to call 'handleThemeSelection(theme:)' using their respective values.

    @IBAction func appInstructionsTapped(_ sender: UIButton) {
        let gitHubURLString = "https://github.com/yourusername/AShVelo/docs"
        
        if let url = URL(string: gitHubURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("ERROR! Wrong URL")
        }
    }
}
