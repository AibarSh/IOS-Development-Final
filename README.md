# IOS-Development-Final
App Name: AshVelo

https://github.com/user-attachments/assets/610de00a-24a2-4cbf-aced-17573f341a70

About:
  AShVelo is an iOS application that allows bicycle enthusiasts and beginners to find bicycle models based on specific components. By leveraging the Bike Index API, users can search for bikes featuring their favorite forks, drivetrains, or frames, and save interesting finds to a local favorites list.
  
Installation:
  Clone the repo ( git clone https://github.com/yourusername/AShVelo.git )
  Open AShVelo.xcodeproj in Xcode 15+.  
  Ensure your deployment target is set to iOS 15.0 or higher.   
  Build and run on a simulator or physical device.
  
Instructions:
  1. Building Your Search

The app is designed to help you find bikes based on specific high-end components rather than just brands.

    Select Categories: On the main Search screen, you will see categories like Frame, Suspension, Wheels, and Groupset.

    Pick Parts: Tap a category to open the Component Picker. Select a specific manufacturer or model (e.g., "Fox 36" or "Shimano XT").

    View Selection: Once selected, the part name will appear on the main list next to the category. You can tap again to change your choice.

    Reset: Use the Reset button in the top corner to clear all selections and start a fresh build.

2. Finding Bikes (API Search)

Once you have selected at least one component, you are ready to search the global Bike Index database.

    Search: Tap the "Check Bikes" button.

    Loading: A spinner will appear while the app communicates with the API.

    Results: You will see a list of bikes that match your specific component criteria. Each result shows the bike's title and manufacturer.

3. Previewing Bike Details

To see the full specifications of a bike found in the search:

    Tap a Result: Click any bike in the results list to open the Bike Preview screen.

    View Details: Here you can see a large image of the bike, its model year, and its frame/model details.

    Theft Status: The app automatically checks the Bike Index "stolen" database.

        Status Clear: The bike is registered as safe.

        Reported Stolen: The bike has been flagged as stolen in the system.

4. Managing Your Favorites

If you find a bike you like and want to keep track of it:

    Save to Favorites: In the Results list, swipe left on any bike and tap the green Save button.

    View Saved Bikes: Go to the Current Bikes section from the main menu to see all your bookmarked bicycles.

    Delete: If you are no longer interested in a bike, swipe left on it in the Current Bikes list and tap Delete. This will remove it from your local storage.

💡 Quick Tips

    Keyword Power: The search is more effective if you pick multiple parts (e.g., "Specialized" + "SRAM").

    Local Storage: Your "Current Bikes" are saved on your phone. They will still be there even if you close the app or lose internet connection.

    Connectivity: You need an active internet connection to perform new searches, as the app fetches live data from the Bike Index servers.




