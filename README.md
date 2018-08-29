# Todo-List
Use four ways of passing data between ViewController in Todo List project.

## Key Value Observing (KVO)

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

--
ref. Playing with Key-Value Observing (KVO) (Swift3).     
https://medium.com/@ericamillado/playing-with-key-value-observing-kvo-swift3-146da9c070a6
 



