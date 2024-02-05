# Image Gallery App

## Project file
The project uses XcodeGen, to use it you need to install it on the system (in the brew install xcodegen console). <br />

GitHub XcodeGen <br />
https://pages.github.com/](https://github.com/yonaskolb/XcodeGen

To create an ".xcodeproj" file,  use the console command "xcodegen" from project diretory.<br />
This is creates a file with parameters from project.yml. 
All project settings are made in the project.yml file

## Architecture
The project uses the MVVM + C architecture. 

Each module is located in the UI group and consists of:

Factory - assembles the module.<br />
ViewModel - handles events and changes screen states.<br />
ViewController - will display the contents of the screen and its current state.<br />
Coordinator - makes transitions between modules.<br />

The interaction of ViewModel with ViewController is carried out through closures. The controller calls the model view methods directly.

## UI and layout
The project uses SnapKit. 
For the initial setup/layout of views, we write separate methods: 
```
setupViews()
layoutViews()
```

### Groupe "Base" 
store modules, extenstions for reusable in project.

### Groupe "Models"
storing requesits and responce models.

Example:<br />
Basic Controller Classes<br />
BaseViewController for simple and composite screens.

### Groupe "Services"

### MobileApi
MobileApi - enum which contains requests to the backend. <br />
The Moya library is used as a wrapper to help generate queries.

### MobileService
MobileService is a service containing methods/requests for the backend.

### AppData 
is responsible for storing selected images and serves as a call to UserDefaults

### Navigation
Navigation transitions are performed only through the Coordinator.

PresentationRouter<br />
Present a ViewController.
```
present(controller: someController)
```
Dismiss presented by ViewController.
```
dismiss()
```
Show different alerts without actions
```
func showErrorAlert(title: String, message: String)
```

## Implemented:
- network layer and error handling,
- obtaining image data upon request,
- display a list of pictures,
- display of picture details,
- logic for adding to favorites and displaying favorites on the UI,
- pagination,
- horizontal scrolling of pictures,
- downloading and saving files.

## Description of technical specifications

### Objective: 
Develop an image gallery app that allows users to browse and favorite images fetched from an API.<br />
The app should demonstrate your proficiency in iOS development, including user interface design, data retrieval, and basic data persistence.
### Requirements:
The app should have two screens: 

### a. Image Gallery Screen:
1. Display a grid of thumbnail images fetched from the provided API (details below).<br />
2. Each thumbnail should be tappable and lead to the Image Detail Screen.<br />
3. Implement pagination to load more images as the user scrolls to the bottom of the screen. 

### b. Image Detail Screen:
4. Show the selected image in a larger view with additional details, such as the image title and description.<br />
5. Allow the user to mark the image as a favorite by tapping a heart-shaped button.<br />
6. Implement basic swipe gestures to navigate between images in the detail view.<br />
7. Use the Unsplash API (https://unsplash.com/developers) to fetch the images.
•	Register for a free API access key.
•	Use the "List Photos" endpoint to retrieve a list of curated photos.
•	Fetch the images in pages of 30 images per request.

8. Implement basic data persistence to store the user's favorite images locally.<br />
9. Provide a mechanism to save and retrieve the list of favorite images.<br />
10. Display a visual indicator on the thumbnail images in the gallery screen for the user's favorite images.<br />
11. Design the user interface with attention to usability and aesthetics.<br />
– Ensure a clean and intuitive layout, considering different device sizes and orientations.

12. Use appropriate UI components and image caching techniques for smooth scrolling and image loading.
### Technical Guidelines:
  • Use Swift as the programming language.<br />
  • Support iOS 13 and above.<br />
  • Use UIKit for building the user interface.<br />
  • Utilize URLSession or a suitable third-party library for network requests.<br />
  • Follow modern iOS design patterns and best practices.<br />
  • Structure the codebase with appropriate separation of concerns and modularity.<br />
  • Implement proper error handling and data parsing.<br />
  • Demonstrate proficiency in asynchronous programming.<br />
– Basic unit tests are encouraged but not mandatory.<br />

### Submission:
13. Provide a GitHub repository URL with the completed project.<br />
14. Include a README file with any necessary instructions or explanations.<br />

Mention any assumptions made or additional features implemented beyond the stated requirements.

