# Unit 4 Final Assessment

# Overview

Create an app that animates a Snowman through various transformations.  Allow the user to save animation settings and chose which setting they want to animate it with.  Implement a pause button that enables the user to pause and resume animationes.

# Gifs

![gif1](https://github.com/C4Q/AC-iOS-Unit4FinalAssessment/blob/master/snowmangifone.gif)

![gif2](https://github.com/C4Q/AC-iOS-Unit4FinalAssessment/blob/master/snowmangiftwo.gif)

![gif3](https://github.com/C4Q/AC-iOS-Unit4FinalAssessment/blob/master/snowmangifthree.gif)


# What's inside

The project above contains a small amount of starter code.  

1. You have an AppDelegate that loads a tab bar controller its first View Controller is an `AnimationViewController`.  Its second View Controller is a Navigation Controller with a `SettingsViewController` as its root.
2. The first View Controller `AnimationViewController` has a blank implementation.  
3. The second View Controller `SettingsViewController` has a TableView with a data source of [[AnimationProperty]].  This table view represents where the user will select the animation settings they want to use. 
4. The Assets folder contains an image of a snowman (<a href="https://www.freepik.com/free-vector/christmas-background-design_963811.htm">Designed by Freepik</a>)

# Detailed overview

You app should consist of Two View Controllers

### `AnimationViewController` 

`AnimationViewController` should contain:

- A UIImageView of the snowman.  This is the view that you will animate
- A PickerView that contains all of the saved settings the user can select
- A UIButton that the user can press to start / pause / resume the animation

### `SettingsViewController`

The `SettingsViewController` should be comprised of a TableView.  Its tableview should use a custom tableViewCell that has:

- A UILabel with the name of the animation property (e.g "Width Multiplier") and its current value
- A UIStepper (configured with an `AnimationProperty`) that the user can increment and decrement to control that setting


The `SettingsViewController`'s top Navigation bar should have a bar button item at the top right.  Clicking the BarButtonItem should save the current Setting to File Manager.  You will need to create a new custom object to model this Animation Setting.

For full credit you must implement the following dimensions to animate

- Width
- Height
- Horizontal Position
- Vertical Position
- Rotating along the X-Axis

Horizontal position and vertical position can be either relative to the center, or relative to the top left of the frame.

# Endpoints

No endpoints needed!


# Rubric

Criteria | Points
:---|:---
App uses AutoLayout correctly for all iPhones in portrait | 4 Points
Variable Naming and Readability | 4 Points
App uses MVC Design Patterns | 4 Points
Settings Table View controller is correctly populated with properties | 4 Points
Settings Table View uses a custom table view cell appropriately | 4 Points
Settings can be saved from the SettingsViewController to FileManager and the | 4 Points
AnimationViewController loads saved settings into a PickerView and updates as you add additional settings | 4 Points
Pressing the play button causes the view to perform the appropriate animation | 8 Points
The user can pause and resume the animation | 4 Points
Extra Credit: Add 2 additional animations dimensions  | 2 points


A total of 40 points, with 2 points extra credit.


https://developer.apple.com/library/content/qa/qa1673/_index.html