# Todo-List

Use four ways to pass data between ViewController in Todo list project

* Delegate
* Notification Center
* Key Value Observing
* Closure

---

## Delegate


Todo List project practice with delegation way to pass data between ViewController.

Create DataModeDelegate protocol definition with method name didRecieveDataUpdate to update data in TextViewController. The argument type is an array of string to store parameter title and text. 

```
protocol DataModelDelegate: AnyObject {
    func didRecieveDataUpdate(data: [String])
}

```
> *The AnyObject keyword in the protocol definition limits protocol adoption to class type (and not structures or enums)*


Now create weak delegate in ModifyViewController

```
weak var delegate: DataModelDelegate? 

```

Here use button action `saveText()` as callback method to call the method in protocol to pass the data.

```
@IBAction func saveText(_ sender: UIButton) {
	guard let title = self.title else { fatalError() }
   data = [title, textView.text]
   delegate?.didRecieveDataUpdate(data: data)
   navigationController?.popViewController(animated: true)
}
```

At the TextViewController we can get the data by conforming protocol method and deal with passed data to update todoTableView.

```
extension TextViewController: DataModelDelegate {

    func didRecieveDataUpdate(data: [String]) {
        if data[0] == "Add" {
            textContent.append(data[1])
        } else {
            textContent[indexPathRow] = data[1]
        }
        todoTableView.reloadData()
    }
}

```
To determine the text data is from add or edit. which means, to update the table view cell or create new cell. We also pass the tilt from ModifyViewController as determine key.





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




## Key Value Observing


Like Notification Center to pass data, KVO also need to have register addObserver and detetmine which property want to observe in other class.   


First we create an instance of ModifyViewController class in TextViewController.

```
var modifyViewController = ModifyViewController()
```

In swtich ViewController method we declare KVO addObserver method to observe `text` property in ModifyViewController. 

Argument `forKeyPath` must inplement the string of observible property's name. `Options` new means once the value has change with new value will notify observer to execute method. 

```
func switchViewController() {
	modifyViewController = ModifyViewController.modifyViewControllerForText(selectedText)
	self.show(modifyViewController, sender: nil)
	
	modifyViewController.addObserver(self, forKeyPath: "text", options: .new, context: nil)
}

```

In ModifyViewController, we create a property `text` with empty string for observe.
Here use text to store `textView.text` string when button tapped. At the mean time, the text value has been change so the observer will get notification and execure the defined method. 

```
@objc dynamic var text = ""

@IBAction func saveText(_ sender: UIButton) {
	text = textView.text
   	textView.text = ""
   	navigationController?.popViewController(animated: true)
}    
```

>*The observable properties must has to inherit from `NSObject` and has dynamic properties* 


The execute method `observeValue()` had defined in TextViewController. 

```
override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
	if keyPath == "text" {
   		guard let change = change, let modifiedText = change[NSKeyValueChangeKey.newKey] as? String else { return }
            
   		if tag == nil {
   			textContent.append(modifiedText)
   		} else {
   			textContent[tag!] = modifiedText
   		}
   		todoTableView.reloadData()
   	}
}
```

Changed observed value of `text` property will pass in `chage` dictionary

```
change: [NSKeyValueChangeKey : Any]?
```
In method, we use guard let to unwrap optional value and use key `"NSKeyValueChangeKey.newKey"` to get the passed data. 

> *newKey is depend on addObserver method's `options` argument input. If the argument is .new then here we use newKey, oldKey for .old argument.*

Here we also use `tagIndex` that stored `indexPath.row` data to decide data should be update or create new cell to table view.


Reference: [Playing with Key-Value Observing (KVO) (Swift3)](https://medium.com/@ericamillado/playing-with-key-value-observing-kvo-swift3-146da9c070a6)
 

## Closure

Todo List project practice with closure to pass data between ViewController.

Here we create a callback as a ModifyViewController closure property named `dataPassing`

```
var dataPassing: ((_ data: String) -> Void)?
```

Inside `saveText` method, we can pass data through `dataPassing` property

```
@IBAction func saveText(_ sender: UIButton) {
   textContent = textView.text
   guard let dataPassing = dataPassing else { return }
   dataPassing(textContent)
   textView.text = ""
   navigationController?.popViewController(animated: true)
}
```
> *Due to `saveText` is a Button function, we use closure property to pass data instead of completion handler.	
> `textView.text = ""` is to reset `textView` after save button action activated.*

```
let modifyViewController = ModifyViewController.modifyViewControllerForText(selectedText)
self.show(modifyViewController, sender: nil)

modifyViewController.dataPassing = { [weak self] (data) in
	if self?.tagIndex == nil {
	
   		self?.textContent.append(data)
   	} else {
   		guard let tagIndex = self?.tagIndex else { return }
      	self?.textContent[tagIndex] = data
   	}
   	self?.todoTableView.reloadData()
}
``` 

In TextViewController, we use this callback closure property when the view is ready to switch to ModifyViewController. We use `tagIndex` which stored `indexPath.row` to determine passed back data should update table view or create new cell. 


Reference: [iOS: Three ways to pass data from Model to Controller](https://medium.com/@stasost/ios-three-ways-to-pass-data-from-model-to-controller-b47cc72a4336)

