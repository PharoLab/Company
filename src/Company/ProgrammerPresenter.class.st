Class {
	#name : #ProgrammerPresenter,
	#superclass : #EmployeePresenter,
	#instVars : [
		'actuallyHoursNumber'
	],
	#category : #Company
}

{ #category : #layout }
ProgrammerPresenter >> defaultLayout [

	^ SpGridLayout build: [ :builder |
		  builder
			  beColumnNotHomogeneous;
			  column: 2 withConstraints: #beExpand;
			  add: 'Last Name';  add: lastNameText; nextRow;
			  add: 'Experience'; add: experienceNumber; nextRow;
			  add: 'Hourly Rate'; add: hourlyRateNumber; nextRow;
			  add: 'Min Hours Worked'; add: minHoursWorkedNumber; nextRow;
			  add: 'Actual Hours'; add: actuallyHoursNumber
			]
]

{ #category : #private }
ProgrammerPresenter >> editable: aBoolean [

	lastNameText editable: aBoolean.
	experienceNumber editable: aBoolean.
	hourlyRateNumber editable: aBoolean.
	minHoursWorkedNumber editable: aBoolean.
	actuallyHoursNumber editable: aBoolean.
]

{ #category : #initialization }
ProgrammerPresenter >> initializePresenters [
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
	actuallyHoursNumber := self newNumberInput
		              rangeMinimum: 1 maximum: minHoursWorkedNumber;
		              yourself.
]

{ #category : #initialization }
ProgrammerPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Programmer';
		initialExtent: 400 @ 200
]

{ #category : #'accessing - model' }
ProgrammerPresenter >> setModel: anEmployee [
	lastNameText text: anEmployee lastName.
	experienceNumber text: anEmployee experience.
	hourlyRateNumber number: anEmployee hourlyRate.
	minHoursWorkedNumber number: anEmployee minHoursWorked.
	actuallyHoursNumber number: anEmployee actuallyHours.
]
