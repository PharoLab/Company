Class {
	#name : #RemoveEmployeePresenter,
	#superclass : #EmployeePresenter,
	#category : #Company
}

{ #category : #layout }
RemoveEmployeePresenter >> defaultLayout [

	^ SpGridLayout build: [ :builder |
		  builder
			  beColumnNotHomogeneous;
			  column: 2 withConstraints: #beExpand;
			  add: 'Last Name';  add: lastNameText
			]
]

{ #category : #private }
RemoveEmployeePresenter >> editable: aBoolean [

	lastNameText editable: aBoolean.
]

{ #category : #initialization }
RemoveEmployeePresenter >> initializePresenters [
	"presener with style - just added"
	nameLabel := self newLabel
		             label: 'Name';
		             addStyle: 'customLabel';
		             yourself.
	"stable part"
	lastNameText := self newTextInput.
]

{ #category : #initialization }
RemoveEmployeePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Dismiss';
		initialExtent: 300 @ 200
]

{ #category : #'accessing - model' }
RemoveEmployeePresenter >> setModel: anEmployee [
	lastNameText text: anEmployee lastName.
]
