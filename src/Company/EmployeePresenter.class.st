Class {
	#name : #EmployeePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'nameLabel',
		'lastNameText',
		'experienceNumber',
		'hourlyRateNumber',
		'minHoursWorkedNumber'
	],
	#category : #Company
}

{ #category : #transmission }
EmployeePresenter >> defaultInputPort [
^ self inputModelPort
]

{ #category : #layout }
EmployeePresenter >> defaultLayout [

	^ SpGridLayout build: [ :builder |
		  builder
			  beColumnNotHomogeneous;
			  column: 2 withConstraints: #beExpand;
			  add: 'Last Name';  add: lastNameText; nextRow;
			  add: 'Experience'; add: experienceNumber; nextRow;
			  add: 'Hourly Rate'; add: hourlyRateNumber; nextRow;
			  add: 'Min Hours Worked'; add: minHoursWorkedNumber]
]

{ #category : #private }
EmployeePresenter >> editable: aBoolean [

	lastNameText editable: aBoolean.
	experienceNumber editable: aBoolean.
	hourlyRateNumber editable: aBoolean.
	minHoursWorkedNumber editable: aBoolean.
]

{ #category : #initialization }
EmployeePresenter >> initializeDialogWindow: aDialogPresenter [

	aDialogPresenter centered.
	aDialogPresenter
		addButton: 'Cancel' do: [ :presenter | presenter close ];
		addButton: 'Save Employee' do: [ :presenter | presenter	beOk;	close ]
]

{ #category : #initialization }
EmployeePresenter >> initializePresenters [
	"presener with style - just added"
	nameLabel := self newLabel
		             label: 'Name';
		             addStyle: 'customLabel';
		             yourself.
	"stable part"
	lastNameText := self newTextInput.
	experienceNumber := self newNumberInput
							 rangeMinimum: 0 maximum: 80;yourself.
	hourlyRateNumber  := self newNumberInput
		              rangeMinimum: 1 maximum: 100000;
		              yourself.
	minHoursWorkedNumber := self newNumberInput
		              rangeMinimum: 1 maximum: 168;
		              yourself.
]

{ #category : #initialization }
EmployeePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Employee';
		initialExtent: 400 @ 200
]

{ #category : #transmission }
EmployeePresenter >> inputModelPort [
^ SpModelPort newPresenter: self
]

{ #category : #'accessing - model' }
EmployeePresenter >> setModel: anEmployee [
	lastNameText text: anEmployee lastName.
	experienceNumber text: anEmployee experience.
	hourlyRateNumber number: anEmployee hourlyRate.
	minHoursWorkedNumber number: anEmployee minHoursWorked.

]
