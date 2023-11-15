Class {
	#name : #ManagerPresenter,
	#superclass : #EmployeePresenter,
	#instVars : [
		'subordinatesCountNumber'
	],
	#category : #Company
}

{ #category : #layout }
ManagerPresenter >> defaultLayout [

	^ SpGridLayout build: [ :builder |
		  builder
			  beColumnNotHomogeneous;
			  column: 2 withConstraints: #beExpand;
			  add: 'Last Name';  add: lastNameText; nextRow;
			  add: 'Experience'; add: experienceNumber; nextRow;
			  add: 'Hourly Rate'; add: hourlyRateNumber; nextRow;
			  add: 'Subordinates Count'; add: subordinatesCountNumber
			]
]

{ #category : #private }
ManagerPresenter >> editable: aBoolean [

	lastNameText editable: aBoolean.
	experienceNumber editable: aBoolean.
	hourlyRateNumber editable: aBoolean.
	subordinatesCountNumber editable: aBoolean.
]

{ #category : #initialization }
ManagerPresenter >> initializePresenters [
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
	subordinatesCountNumber := self newNumberInput
		              rangeMinimum: 1 maximum: 100000;
		              yourself.
]

{ #category : #initialization }
ManagerPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Manager';
		initialExtent: 400 @ 200
]

{ #category : #'accessing - model' }
ManagerPresenter >> setModel: anEmployee [
	lastNameText text: anEmployee lastName.
	experienceNumber text: anEmployee experience.
	hourlyRateNumber number: anEmployee hourlyRate.
	subordinatesCountNumber number: anEmployee subordinatesCount.
]
