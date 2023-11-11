Class {
	#name : #EmployeeListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'employeeList',
		'detail'
	],
	#category : #Company
}

{ #category : #adding }
EmployeeListPresenter >> addEmployee [ 
    "empty for now"

]

{ #category : #testing }
EmployeeListPresenter >> clickEmployeeAtIndex: anIndex [ 
	employeeList clickAtIndex: anIndex
]

{ #category : #initialization }
EmployeeListPresenter >> connectPresenters [

	employeeList whenSelectionChangedDo: [ :selectedItemMode |
		selectedItemMode isEmpty ifFalse: [
			detail setModel: selectedItemMode selectedItem ] ]
	
]

{ #category : #layout }
EmployeeListPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: employeeList;
		  add: detail;
		  yourself
]

{ #category : #accessing }
EmployeeListPresenter >> detail [
	^ detail
]

{ #category : #accessing }
EmployeeListPresenter >> employeeList [

	^ employeeList 
]

{ #category : #initialization }
EmployeeListPresenter >> initializePresenters [

	employeeList := self newTable
		 addColumn: (SpStringTableColumn title: 'Lastname' evaluated: #lastName) beSortable;
		 addColumn: (SpStringTableColumn title: 'Experience' evaluated: #experience) beSortable;
		 addColumn: (SpStringTableColumn title: 'Hourly Rate' evaluated: #hourlyRate) beSortable;
		 addColumn: (SpStringTableColumn title: 'Minimal Worked Hours' evaluated: #minHoursWorked) beSortable;
		 "addColumn: (SpStringTableColumn title: 'Subordinates Count' evaluated: #subordinatesCount) beSortable;
		 addColumn: (SpStringTableColumn title: 'Actually Hours' evaluated: #actuallyHours) beSortable;"
		 yourself.
	detail := self instantiate: EmployeePresenter.
	detail editable: false.
]

{ #category : #initialization }
EmployeeListPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Company';
		initialExtent: 700 @ 700;
		toolbar: (self newToolbar
				 add: (self newToolbarButton
						  label: 'Add employee';
						  icon: (self iconNamed: #smallAdd);
						  action: [ self addEmployee ];
						  yourself);
				 yourself)
]

{ #category : #layout }
EmployeeListPresenter >> listAboveLayout [
^ SpBoxLayout newTopToBottom
add: detail;
add: employeeList;
yourself
]

{ #category : #layout }
EmployeeListPresenter >> listOnlyLayout [
^ SpBoxLayout newTopToBottom
add: employeeList;
yourself
]

{ #category : #initialization }
EmployeeListPresenter >> updatePresenter [
	|list|
	list := OrderedCollection new.
   list add: Programmer new.
	list add: Manager new.
	employeeList items: list.
]
