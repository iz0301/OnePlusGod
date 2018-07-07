//
//  FormViewController.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 3/17/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit

class FormViewController : UITableViewController, UITextFieldDelegate {
    
    /**
     An array to hold the form items, use getter and setter methods when possible for error catching
     */
    var formItems : [[FormViewItem]] = [];
    /**
     An array to hold the section titles, use getter and setter methods when possible for error catching
     */
    var sectionTitles : [String] = [];
    
    @objc func hideInfo(){
        dismiss(animated: true, completion: nil);
    }
    
    // Set up viewcontroller
    init(){
        super.init(nibName: nil, bundle: nil);
        //TODO: move info button to somewhere else?
        /*let infoButton = UIButton(type: .infoLight);
         infoButton.addTarget(self, action: #selector(info), for: .touchUpInside);
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: infoButton);*/
        
        self.view.backgroundColor = .lightGray;
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.backgroundView?.backgroundColor = .blue;
            view.textLabel?.backgroundColor = .clear;
            view.textLabel?.textColor = .white;
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    // func to hide keyboard when swipe down:
    var lastPos = CGPoint.zero;
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentPos = scrollView.contentOffset
        if(currentPos.y < lastPos.y){
            dismissKeyboard();
        }
        lastPos = currentPos;
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        // Set up table:
        self.tableView.register(FormViewItemCell.self, forCellReuseIdentifier: "Identifier");
        self.tableView.allowsSelection = false;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.separatorInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20);
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)));
    }
    
    /**
     Sets the title for the specified section, if it doesnt exist, create it
     */
    func setSectionTitle(title: String, forSection: Int){
        if(forSection > (formItems.count - 1)){
            setNumberOfSections(number: forSection + 1);
        }
        sectionTitles[forSection] = title;
    }
    
    /**
     sets the number of sections in the form. Either adds new sections to the end, or removes them from the end.
     */
    func setNumberOfSections(number: Int){
        while(formItems.count < number){
            formItems.append([]);
            sectionTitles.append("");
        }
        while(formItems.count > number){
            formItems.remove(at: formItems.count - 1)
            sectionTitles.remove(at: formItems.count - 1);
        }
    }
    
    /**
     Returns the number of sections
     */
    func getNumberOfSections() -> Int {
        return formItems.count;
    }
    
    
    /**
     Returns the number of items in a section
     */
    func getNumberOfItems(inSection: Int) -> Int {
        return formItems[inSection].count;
    }
    
    /**
     Gets the item at the index path
     */
    func getItem(at: IndexPath) -> FormViewItem{
        return formItems[at.section][at.item];
    }
    
    /**
     Sets the number of form items in the section. Either adds items to the end or removes them.
     If section is out of bounds then create it.
     */
    func setNumberOfItems(number: Int, inSection: Int){
        if(inSection > (formItems.count - 1)){
            setNumberOfSections(number: inSection + 1);
        }
        while(formItems[inSection].count < number){
            formItems[inSection].append(FormViewItem.init(title: "", options: [""], keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .sentences, usePicker: false, value: ""));
        }
        while(formItems[inSection].count > number){
            formItems[inSection].remove(at: formItems[inSection].count - 1);
        }
    }
    
    /**
     Updates the FormViewItem values with values entered in text boxes, only updates for cells onscreen because values are updated when cells leave
     */
    func updateValues() {
        for sectionNum in 0...(formItems.count - 1){
            for itemNum in 0...(formItems[sectionNum].count - 1) {
                if let cell = self.tableView.cellForRow(at: IndexPath(item: itemNum, section: sectionNum)) {
                    formItems[sectionNum][itemNum].value = (cell as! FormViewItemCell).fieldView.text!;
                }
            }
        }
    }
    
    /**
     Sets an item for the from from a FormViewItem at the specified IndexPath. If index path is out of range, sections and items will be created up to the specified index
     */
    func setItemAtIndexPath(item: FormViewItem, indexPath: IndexPath){
        if(indexPath.section > (formItems.count - 1)) {
            setNumberOfSections(number: (indexPath.section + 1));
        }
        if(indexPath.item > (formItems[indexPath.section].count - 1)){
            setNumberOfItems(number: indexPath.item + 1, inSection: indexPath.section);
        }
        formItems[indexPath.section][indexPath.item] = item;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        // Dont know why we need this really, but it fixed a problem:
        self.tableView.reloadData();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        updateValues();
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator);
        self.tableView.reloadData();
        self.tableView.setNeedsDisplay();
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section];
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return formItems.count;
    }
    
    // Should return the number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formItems[section].count;
    }
    
    // Called when the table needs a cell, probably nothing needs changed here. Change stuff in NewsCell classs
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath as IndexPath) as! FormViewItemCell);
        cell.fieldView.delegate = self;
        cell.prepareToShow(formItem: formItems[indexPath.section][indexPath.item]);
        return cell;
    }
    
    //Called when the cell leaves
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let formCell = (cell as! FormViewItemCell);
        formCell.fieldView.resignFirstResponder();
        formItems[indexPath.section][indexPath.item].value = formCell.fieldView.text!;
    }
    
    /**
     Goes through a loop to find which text field, if any, is the first responder, then returns the index path for the cell to which the field belongs. If there is no first responder, then it returns an invalid index path (1 past the final indicies)
     */
    func indexPathOfFirstResponder() -> IndexPath {
        var sectionNumber = 0;
        var index = 0;
        loop: for itemGroup in formItems {
            index = 0;
            for _ in itemGroup {
                if(self.tableView.cellForRow(at: IndexPath(row: index, section: sectionNumber)) != nil){
                    if((self.tableView.cellForRow(at: IndexPath(row: index, section: sectionNumber)) as! FormViewItemCell).fieldView.isFirstResponder){
                        break loop;
                    }
                }
                index += 1;
            }
            sectionNumber += 1;
        }
        return IndexPath(item: index, section: sectionNumber);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var path = indexPathOfFirstResponder();
        var sectionNumber = path.section;
        var index = path.item;
        
        textField.resignFirstResponder();
        if(sectionNumber >= formItems.count){
            return true;
        }
        // if increasing the index would put it out of bounds, then make it the next section
        // count - 1 is the maximum allowable index
        if(index + 1 > formItems[sectionNumber].count - 1){
            //if increasing the section puts it out of bounds:
            if(sectionNumber + 1 > formItems.count - 1){
                return true;
            } else {
                index = 0;
                sectionNumber += 1;
            }
            //if incrasing the index doesnt put it out of bounds, then incrase it:
        } else {
            index += 1;
        }
        if(self.tableView.cellForRow(at: IndexPath(row: index, section: sectionNumber)) == nil){
            return true;
        }
        _ = (self.tableView.cellForRow(at: IndexPath(row: index, section: sectionNumber)) as! FormViewItemCell).fieldView.becomeFirstResponder();
        self.tableView.scrollToRow(at: IndexPath(row: index, section: sectionNumber), at: .middle, animated: true);
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let pick = textField.inputView as? FormOptionsView {
            textField.text = pick.selectedText();
        }
        return true;
    }
    
    
    /**
     Clears all the form inputs and resets the picker views
     */
    func clearAllInputs(){
        for sectionNum in 0...(formItems.count - 1){
            for itemNum in 0...(formItems[sectionNum].count - 1){
                formItems[sectionNum][itemNum].value = "";
                self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: false);
                if let cell = self.tableView.cellForRow(at: IndexPath(item: itemNum, section: sectionNum)) {
                    let formCell = cell as! FormViewItemCell;
                    formCell.optionsView.selectRow(0, inComponent: 0, animated: false);
                    formCell.fieldView.text = "";
                }
            }
        }
    }
    
    func emailResults(address: String) {
        var request = URLRequest(url: URL(string: AppDelegate.server + "/app/sendRequestEmail.php")!);
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type");
        request.httpMethod = "POST";
        var dataString = self.title! + ":NEWLINE:";
        for sectionNum in 0...(getNumberOfSections() - 1){
            for itemNum in 0...(getNumberOfItems(inSection: sectionNum) - 1) {
                let item = getItem(at: IndexPath(item: itemNum, section: sectionNum));
                dataString += item.title + ": " + item.value + ":NEWLINE:";
            }
        }
        request.httpBody = ("data=" + dataString + "&email=" + address).data(using: .utf8);
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            //dismiss "submitting..."
            self.dismiss(animated: true, completion: {() in
                DispatchQueue.main.async {
                    if(data != nil && String.init(data: data!, encoding: .utf8) == "Success"){
                        let alert = UIAlertController(title: "Complete!", message: "Your response has been submitted.", preferredStyle: .alert);
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (UIActionAlert) in
                            self.viewDidLoad();
                            self.view.becomeFirstResponder();
                            self.navigationController?.dismiss(animated: true, completion: nil);
                            self.navigationController?.popToViewController(self, animated: true);
                            self.tableView.reloadData();
                        }));
                        self.present(alert, animated: true, completion: nil);
                        self.clearAllInputs();
                        return;
                    }
                    if(error != nil && (error! as NSError).code == NSURLErrorCancelled){
                        self.viewDidLoad();
                        self.view.becomeFirstResponder();
                        self.navigationController?.dismiss(animated: true, completion: nil);
                        self.navigationController?.popToViewController(self, animated: true);
                        self.tableView.reloadData();
                        return;
                    }
                    let fail = UIAlertController(title: "Failed", message: "An error has occured and your response could not be submitted. Please try again later.", preferredStyle: .alert);
                    fail.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (UIActionAlert) in
                        self.viewDidLoad();
                        self.view.becomeFirstResponder();
                        self.navigationController?.dismiss(animated: true, completion: nil);
                        self.navigationController?.popToViewController(self, animated: true);
                        self.tableView.reloadData();
                    }));
                    self.present(fail, animated: true, completion: nil);
                }
            });
        });
        
        
        
        
        let submitting = UIAlertController(title: "Submitting...", message: "Please wait while your response is being submitted.", preferredStyle: .alert);
        submitting.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (UIActionAlert) in
            task.cancel();
        }));
        self.present(submitting, animated: true, completion: nil);
        task.resume();
    }
}

// Represents a news item, has a title and content as strings
struct FormViewItem {
    /**
     The title of the input. Shown as annotated text for a keybard input, as a label for picker
     */
    var title : String;
    
    /**
     The options to use for the picker, set to nil for keyboard input
     */
    var options : [String];
    
    /**
     The keyboard type to use in the input field. ignored for a picker
     */
    var keyboardType : UIKeyboardType;
    
    /**
     The autocorrection type to use in the input field. ignored for a picker
     */
    var autocorrectionType : UITextAutocorrectionType;
    
    /**
     The autocapitalization type to use for the input field. ignored for a picker
     */
    var autocapitalizationType : UITextAutocapitalizationType;
    
    /**
     Set to true to use a picker view for input, false to use keyboard
     */
    var usePicker : Bool;
    
    /**
     The value of the form item. This should be what the user selected/entered
     */
    var value : String;
}

/**
 Represents a cell for a form item. A single cell supports both a text entry and a picker view entry,
 but only uses one at a time. Both are supported so that cells can be reused to maximize performacne.
 FATAL ERROR: Still a bit buggy and values/selected rows occasionally swithc, maybe i fixed it tho
 */
private class FormViewItemCell : UITableViewCell {
    
    /**
     The title of the form item
     */
    var title : String = "";
    
    /**
     The text view that handels the input of the cell
     */
    fileprivate var fieldView : FormSpecialTextField = FormSpecialTextField();
    
    /**
     View used for the picker input
     */
    fileprivate var optionsView : FormOptionsView = FormOptionsView(withOptions: []);
    
    /**
     Set to true to use a picker view for input, false to use keyboard
     */
    var usePicker : Bool = false;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: "Identifier");
        self.optionsView.frame.size.height = 216;
        fieldView.frame = self.frame;
        fieldView.frame.origin.x += 10;
        fieldView.frame.size.width -= 20;
        fieldView.autocorrectionType = .no;
        optionsView.associatedTextField = fieldView;
        self.addSubview(fieldView);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    /**
     Prepare to show the cell with all of the options set. Should call this function before using
     the cell in a table
     @param fromItem The form item to use in the cell
     */
    func prepareToShow(formItem: FormViewItem){
        usePicker = formItem.usePicker;
        title = formItem.title;
        
        optionsView.options = formItem.options;
        optionsView.options.insert("", at: 0);
        optionsView.associatedTextField = fieldView;
        
        fieldView.placeholder = title;
        fieldView.text = formItem.value;
        if(usePicker){
            optionsView.selectText(text: fieldView.text!);
            fieldView.inputView = optionsView;
            fieldView.tintColor = .clear;
        } else {
            fieldView.returnKeyType = .next;
            fieldView.inputView = nil;
            fieldView.tintColor = .blue;
            fieldView.keyboardType = formItem.keyboardType;
            fieldView.autocorrectionType = formItem.autocorrectionType;
            fieldView.autocapitalizationType = formItem.autocapitalizationType;
        }
    }
}

//a setup picker view thingy to be used as an input view for a textfield
private class FormOptionsView : UIPickerView, UIPickerViewDelegate,UIPickerViewDataSource {
    
    var options : [String] = [];
    
    var associatedTextField : UITextField?;
    
    init(withOptions: [ String ]){
        super.init(frame: CGRect.zero);
        self.options = withOptions;
        self.options.insert("", at: 0);
        self.dataSource = self;
        self.delegate = self;
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    /**
     Returns the text that is selected in the options view
     */
    func selectedText() -> String {
        if(selectedRow(inComponent: 0) < 0){
            return "";
        }
        if(selectedRow(inComponent: 0) > options.count - 1){
            return "";
        }
        return options[selectedRow(inComponent: 0)];
    }
    
    /**
     Moves the picker view to select the text if it is an option. If it isnt, it selects the blank row.
     */
    func selectText(text: String) {
        for i in 0...(options.count - 1) {
            if(options[i] == text){
                selectRow(i, inComponent: 0, animated: false);
                return;
            }
        }
        selectRow(0, inComponent: 0, animated: false);
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(row > options.count - 1){
            return "";
        }
        return options[row];
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        associatedTextField?.text = selectedText();
    }
}

/**
 A speical text field that will disable copy/paste if its input view is an options view
 */
private class FormSpecialTextField : UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if(!super.canPerformAction(action, withSender: sender)){
            return false;
        }
        //special properties for picker view:
        if (inputView as? FormOptionsView) != nil {
            if(action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(UIResponderStandardEditActions.cut(_:)) || action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.select(_:)) || action == #selector(UIResponderStandardEditActions.selectAll(_:)) || action == #selector(UIResponderStandardEditActions.delete(_:))){
                return false;
            }
        }
        return true;
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder();
        if (inputView as? FormOptionsView) != nil {
            (inputView as! FormOptionsView).selectText(text: text!);
        }
        return true;
    }
}
