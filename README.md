# Todo-List

Todo List with four way of passing data between ViewControllers

1. Delegate
2. Notification Center
    Create notification observer with Notification.Name("SAVE") and declare function (getNotified) that will execute once the observer got the notification in the TextViewController. The NotificationCenter.default.post in ModifyViewController will send the data of navigation title and modified text content back when the save button has been touched. Funcion getNotified in TextViewController will update or add motified text on table view cell depend on weather the send back navigation title is "Add" or "Edit".
    
3. KVO
4. Closure
