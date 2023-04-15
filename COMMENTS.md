# memory_game

Comments of this repo

## Architecture

### BLoC (/blocs)
The repo follows the BLoC (Business Logic Components) architectural pattern based on separated components, this
pattern allow a good separation of concepts, and the ability to easily modify and scale the solution without problems.

In the subject of this solution in particular only a single BLoC was used and needed => GameBloc

This BLoC is responsible for managing the whole logic of the game and handling several events:

- **GameStart** Event: Responsible to start the game and pushing to game screen => emits the **Game** state
- **GameTimeOut** Event: Responsible to end the game due to timeout => emits the **GameFinished** state
- **GameRestart*** Event: Responsible to restart the game or send to home screen => emits the **Game** state or
**GameStop** state depending on restart parameter value
- **GameChange** Event: Responsible to handle all changes that happen on the game (i.e. when user presses a card ) =>
emits the **Game** state or **GameFinished** state when every cards are matched

### Constants (/constants)
Simple **constants.dart** file, responsible to gather all raw strings and static parameters in the app

### Models (/models)
**FlipCard**: Model class that handles several properties like:

- id: general identifier of the object
- value: actual value displayed when the user checks the card (in a list of FlipCard object, there should always be 2
 with the same value)
- isShow: boolean stating if the card is showing to the user in the game screen
- isCompleted: boolean stating if the card has found his match in the game

### Pages (/pages)
The repo contains in total 4 widget pages that listen and consume BLoC states and render the proper UI

- **HomePage**: First Page to be rendered by App and responsible to handle to transition to GameChooseDifficultyPage
or choose the SelectedTheme Dialog, this dialog presents the possibilities of enum **GameTheme** that will be saved
in a SharedPreferences key, and this will be used by **FlipCardWidget** in order to render the proper svg image of
the user choosed theme
- **GameChooseDifficultyPage**: Page responsible to render a radio list chooser for the user to select the amount of
columns that should be rendered in the game, this value is an enum **GameDifficulty** with extensions to better help
manage his behaviour, and this value is passed to the **GameBloc** that will generate the cards and align the Game
Screen acoording to user preferences
- **GamePage**: Page responsible to handle the main logic of the game, consumes the **Game** state and receives some
properties from him to render on the UI: a list of **FlipCard** to display with the GridView, an int with the number
of columns to display on the GridView, the number of moves the user already did, and the number of remaining pairs
left to sucessfully finish the game
- **GameResultPage**: Page responsible to handle the end of the game, regardless of the result, consumes the
**GameFinished** state and manages the result of the game with the result parameter that is inside this same state

### Widgets (/widgets)
General widgets folder where we should place all extracted widgets that could be reused across the app

## Testing
The testing part was taking into account for this app aswell, being accomplished a total of **84.5%** 
code coverage (check in file coverage/html/index.html), which seems to me reasonable and a stable metric to push 
the code.

The BLoC was tested using the **bloc_test** library and several dependencies were mocked in other to proceed with the
 tests.