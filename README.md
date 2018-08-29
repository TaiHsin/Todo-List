# Todo-List 

## Delegation

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



