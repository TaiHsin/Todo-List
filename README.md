# Todo-List

## Notification Center


Todo List pratice with Notification Center to passing data between ViewControllers.

In TextViewController ViewDidLoad, we create notification observer with `Notification.Name` and identifier name `"SAVE"`. 
						

```
let notificationName = Notification.Name("SAVE")
NotificationCenter.default.addObserver(self, selector: #selector(getNotified(notification:)), name: notificationName, object: nil)
```
> *Notice, the Notification name string in addObserver argument should exactly same with post notification. This make sure once 
Also, declare method `getNotified` to execute  once the observer got the change will post notification to right observer with the same Notification name.*



Now we can declare post in ModifyViewController to post Notification once it's activated. The argument `name` should have the same string name (here is `"SAVE"`) with in addObserver's name argument in TextViewController.


Here we declare data with an array of dictionary to contain title value with key `"Title"` and textView.text value with key `"textKey"`. To pass data back, we use argument `userInfo` which is type of `[AnyHashable : Any]?`

```
let data = ["Title": self.title,"textkey": textView.text]        		             
NotificationCenter.default.post(name: Notification.Name("SAVE"), object: nil, userInfo: data) navigationController?.popViewController(animated: true)
```
					 

Now back to TextViewController we defined method that will execute when observer get notification. The method name should same as in observer's argument `selector` and add `@objc` in front of function declaration. 

```
@objc func getNotified(notification: Notification) {
    guard let textData = notification.userInfo as? [String: String] else { fatalError() }
        
    if textData["Title"] == "Add" {
  	textContent.append(textData["textkey"]!)
    } else {
      	textContent[indexPathRow] = textData["textkey"]!
    }
    todoTableView.reloadData()
}
```

In `getNotified()` method, we use notification.userInfo to get the data that has been pass back and use the first array of dictionary (with key "Title") to decide which value we want to parse. TextViewController will update or add motified text on table view cell depend on weather the title value is "Add" or "Edit".
