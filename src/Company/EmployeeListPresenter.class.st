Class {
	#name : #EmployeeListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'windowTitle',
		'employeeList',
		'detail',
		'company',
		'companyFilter'
	],
	#category : #Company
}

{ #category : #adding }
EmployeeListPresenter >> addManager [

	| presenter windowPresenter|
	presenter := ManagerPresenter newApplication: self application.
	windowPresenter := presenter openModal.
	windowPresenter isOk ifFalse: [ ^ self ].
	(self company memory) add: (Manager new
			 lastName: presenter lastName;
			 experience: presenter experience;
			 hourlyRate: presenter hourlyRate;
			 subordinatesCount: presenter subordinatesCount
		).
		
	self updatePresenter
	

]

{ #category : #adding }
EmployeeListPresenter >> addProgrammer [
	| presenter windowPresenter|
	presenter := ProgrammerPresenter newApplication: self application.
	windowPresenter := presenter openModal.
	windowPresenter isOk ifFalse: [ ^ self ].
	(self company memory) add: (Programmer new
			 lastName: presenter lastName;
			 experience: presenter experience;
			 hourlyRate: presenter hourlyRate;
			 actuallyHours: presenter actuallyHours
		).
		
	self updatePresenter
	

]

{ #category : #'as yet unclassified' }
EmployeeListPresenter >> checkNorm [

	| presenter windowPresenter|
	company followNorm ifTrue:
	[ 
		presenter := SpTextPresenter newApplication: self application.
		presenter text: 'Sure, all programmers complie the norms'.
	]
	ifFalse: [ 
		presenter := SpTextPresenter newApplication: self application.
		presenter text: 'No, not everyone complies the norms'.
		companyFilter memory: company findWhoDoNotFollowNorm.
		 ].
	
		windowPresenter := presenter openModal.
		windowPresenter isOk ifFalse: [ ^ self ].
		
		self updateFilterPresenter.
	

]

{ #category : #testing }
EmployeeListPresenter >> clickEmployeeAtIndex: anIndex [ 
	employeeList clickAtIndex: anIndex
]

{ #category : #accessing }
EmployeeListPresenter >> company [
	^company.
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

{ #category : #'add-remove' }
EmployeeListPresenter >> dismissEmployee [

	| presenter windowPresenter|
	presenter := RemoveEmployeePresenter newApplication: self application.
	windowPresenter := presenter openModal.
	windowPresenter isOk ifFalse: [ ^ self ].
	self company dismiss: presenter lastName.
		
	self updatePresenter
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
company := Company new.
companyFilter := company veryDeepCopy.
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
		initialExtent: 900 @ 900;
		toolbar: (self newToolbar
				 add: (self newToolbarButton
						  label: 'Add Manager';
						  icon: (self iconNamed: #smallAdd);
						  action: [ self addManager ];
						  yourself);
				add: (self newToolbarButton
						  label: 'Add Programmer';
						  icon: (self iconNamed: #smallAdd);
						  action: [ self addProgrammer ];
						  yourself);
				add: (self newToolbarButton
						  label: 'Dismiss Employee';
						  icon: (self iconNamed: #changeRemove);
						  action: [ self dismissEmployee ];
						  yourself);
				add: (self newToolbarButton
						  label: 'Check whether programmers follow norm';
						  icon: (self iconNamed: #glamorousHelp);
						  action: [ self checkNorm ];
						  yourself);
				add: (self newToolbarButton
						  label: 'Reset filters';
						  icon: (self iconNamed: #glamorousRestart);
						  action: [ self updatePresenter];
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

{ #category : #'as yet unclassified' }
EmployeeListPresenter >> updateFilterPresenter [
	employeeList items: companyFilter memory.
]

{ #category : #initialization }
EmployeeListPresenter >> updatePresenter [
	employeeList items: company memory.
]

{ #category : #accessing }
EmployeeListPresenter >> windowTitle [

	^ windowTitle
]

{ #category : #accessing }
EmployeeListPresenter >> windowTitle: anObject [

	windowTitle := anObject
]
