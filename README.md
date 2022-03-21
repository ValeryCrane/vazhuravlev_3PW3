#  Alarms app

- The project has no storyboard, contains navigation controller and a tabBarController. Navigation bar has png images. Pressing bar items leads to screens.

- First screen has a StackView, second has TableView, third has a CollectionView.

- StackView is filled with custom made Alarm views and can be scrolled.

- There are custom Table View cells with an eye in a random place (200 cells or more).

- The issue with eyes is fixed. TV is filled with Alarm table view cells.

- CollectionView is filled with alarms, that can be scrolled horizontally.

- There is a plus Button in navigation bar, that opens Alarm creation Menu. This menu uses AlarmWorker class to store alarms and pass them to all three screens. Change in one alarm on one screen changes this alarm everywhere. Pressing an alarm allows to change it in editing menu.

- Using Clean architecture.

- Alarms work, we can choose sound. Alarms are saved in CoreData
