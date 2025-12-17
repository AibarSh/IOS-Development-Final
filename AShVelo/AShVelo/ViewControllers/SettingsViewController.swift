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

    @IBOutlet weak var themeSelectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
//        setupThemeMenu()
        updateThemeDisplay()
    }
    private func updateThemeDisplay() {
        let currentTheme = UserDefaults.standard.string(forKey: "SelectedTheme") ?? AppTheme.automatic.rawValue
        applyTheme(theme: AppTheme(rawValue: currentTheme) ?? .automatic)
    }
    
//    private func setupThemeMenu() {
//        let currentThemeStr = UserDefaults.standard.string(forKey: "SelectedTheme") ?? AppTheme.automatic.rawValue
//        
//        let handler: UIActionHandler = { [weak self] action in
//            let selectedTheme: AppTheme = AppTheme(rawValue: action.title) ?? .automatic
//            self?.handleThemeSelection(theme: selectedTheme)
//        }
//
//        let actions = [AppTheme.automatic, AppTheme.light, AppTheme.dark].map { theme in
//            UIAction(
//                title: theme.rawValue,
//                state: theme.rawValue == currentThemeStr ? .on : .off,
//                handler: handler
//            )
//        }
//
//        let menu = UIMenu(title: "Select Theme", children: actions)
//        themeSelectionButton.menu = menu
//        themeSelectionButton.showsMenuAsPrimaryAction = true
//        themeSelectionButton.changesSelectionAsPrimaryAction = true
//    }
    @IBAction func clearCacheTapped(_ sender: UIButton) {

        let alert = UIAlertController(title: "Clear Cache", message: "This will delete all stored temporary data and search history. Continue?", preferredStyle: .alert)
        
        let clearAction = UIAlertAction(title: "Clear Data", style: .destructive) { [weak self] _ in

             if let bundleID = Bundle.main.bundleIdentifier {
                 UserDefaults.standard.removePersistentDomain(forName: bundleID)
             }

            let successAlert = UIAlertController(title: "Success", message: "Cache has been cleared.", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(successAlert, animated: true)
        }
        
        alert.addAction(clearAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    func handleThemeSelection(theme: AppTheme) {
        
        UserDefaults.standard.set(theme.rawValue, forKey: "SelectedTheme")
        applyTheme(theme: theme)
        
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
 
    @IBAction func appInstructionsTapped(_ sender: UIButton) {
        let gitHubURLString = "https://github.com/AibarSh/IOS-Development-Final/blob/main/README.md"
        
        if let url = URL(string: gitHubURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("ERROR! Wrong URL")
        }
    }
}
