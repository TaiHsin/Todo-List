# Todo-List

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


Reference: iOS: Three ways to pass data from Model to Controller    
https://medium.com/@stasost/ios-three-ways-to-pass-data-from-model-to-controller-b47cc72a4336
