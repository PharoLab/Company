Class {
	#name : #EmployeeListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'windowTitle',
		'employeeList',
		'detail'
	],
	#category : #Company
}

{ #category : #adding }
EmployeeListPresenter >> addEmployee [ 

	"| presenter |
	presenter := SpNotebookPresenter new 
		addPageTitle: 'Add Programmer' provider: [ ProgrammerPresenter new];
		addPageTitle: 'Add Manager' provider: [ ManagerPresenter new ];
		open.
	
	self updatePresenter"

	| presenter windowPresenter |
	"presenter := EmployeePresenter newApplication: self application."
	presenter := SpNotebookPresenter new 
		addPageTitle: 'Add Programmer' provider: [ ProgrammerPresenter new];
		addPageTitle: 'Add Manager' provider: [ ManagerPresenter new ];
		yourself.
	windowPresenter := presenter openModal.
	windowPresenter isOk ifFalse: [ ^ self ].
	[employeeList add: (Programmer new
			 lastName: ((presenter pageAt: 1) owner) lastName;
			 experience: presenter experience ;
			 minHoursWorked: presenter minHoursWorked;
			 hourlyRate: presenter hourlyRate;
			 actuallyHours: presenter actuallyHours
			)]
		on: Exception
		do: [employeeList add: (Manager new
			 lastName: ((presenter pageAt: 2) labelPresenterFor: ManagerPresenter );
			 experience: presenter experience;
			 hourlyRate: presenter hourlyRate;
			 subordinatesCount: presenter subordinatesCount
			)].
		
	self updatePresenter
	

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

{ #category : #accessing }
EmployeeListPresenter >> employeeList: anObject [

	employeeList items: anObject.
]

{ #category : #initialization }
EmployeeListPresenter >> initializePresenters [
	employeeList := self newTable
		 addColumn: (SpStringTableColumn title: 'Lastname' evaluated: #lastName) beSortable;
		 addColumn: (SpStringTableColumn title: 'Experience' evaluated: #experience) beSortable;
		 addColumn: (SpStringTableColumn title: 'Hourly Rate' evaluated: #hourlyRate) beSortable;
		 addColumn: (SpStringTableColumn title: 'Minimal Worked Hours' evaluated: #minHoursWorked) 		        beSortable;
		 addColumn: (SpStringTableColumn title: 'Subordinates Count' 
		 evaluated: #subordinatesCount );
		 addColumn: (SpStringTableColumn title: 'Actually Hours' 
		 evaluated: #actuallyHours);
		 yourself.
	detail := self instantiate: EmployeePresenter.
	detail editable: false.
]

{ #category : #initialization }
EmployeeListPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: windowTitle;
		initialExtent: 900 @ 700;
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
	"|list|
	list := OrderedCollection new.
   list add: Programmer new.
	list add: Manager new."
	employeeList items: OrderedCollection new.
]

{ #category : #accessing }
EmployeeListPresenter >> windowTitle [

	^ windowTitle
]

{ #category : #accessing }
EmployeeListPresenter >> windowTitle: anObject [

	windowTitle := anObject
]
