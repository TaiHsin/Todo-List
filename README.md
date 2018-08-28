# Todo-List

Todo List with four way of passing data between ViewControllers

1. Delegation   
I create a DataModelDelegate protocol and method (didRecieveDataUpdate) with argument type String of array in protocol for delegate to pass data. In ModifyViewController, declare delegate to create instance of DataModelDelegate and use weak to prevent retain cycle. Use button action (saveText) as callback method to call the method (didRecieveDataUpdate) to pass the data. We can get the data by confroming TextViewController to protocol by method (didRecieveDataUpdate) and deal with passed data to update todoTableView. I also pass navigation title to determine I shold add text or update edited text.

2. Notification Center
3. KVO
4. Closure
