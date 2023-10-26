Class {
	#name : #BundleOfEmployees,
	#superclass : #Object,
	#instVars : [
		'memory'
	],
	#category : #Company
}

{ #category : #'as yet unclassified' }
BundleOfEmployees class >> loadFromCodeFile: pathString [
	pathString asFileReference readStreamDo: [ :in | ^ Smalltalk compiler evaluate: in contents ].
]

{ #category : #'as yet unclassified' }
BundleOfEmployees class >> loadFromStonFile: pathString [ 
pathString asFileReference readStreamDo: [ :in | ^ (STON reader on: in) next ].
]

{ #category : #'as yet unclassified' }
BundleOfEmployees class >> pickFileAndLoad: pattern [
	| pathString |
	pathString := UIManager default
		              chooseFullFileNameMatching: { pattern }
		              label: 'Choose file to open'.
	pathString ifNil: [ ^ nil ].
	'*.ston' = pattern ifTrue: [ ^ self loadFromStonFile: pathString ].
	'*.stc' = pattern ifTrue: [ ^ self loadFromCodeFile: pathString ].
	^ self error: 'Unknown type of file: ' , pattern
]

{ #category : #adding }
BundleOfEmployees >> add: anEmployee [
	self checkAnObject: anEmployee.
	^ memory add: anEmployee.
]

{ #category : #adding }
BundleOfEmployees >> addAll: anEmployeeCollection [
	^ memory addAll: (anEmployeeCollection select: [ :x | x isKindOf: Employee ])
]

{ #category : #adding }
BundleOfEmployees >> addFirst: anEmployee [
	self checkAnObject: anEmployee.
	^ memory addFirst: anEmployee
]

{ #category : #accessing }
BundleOfEmployees >> at: anIndex [
	^ memory at: anIndex
]

{ #category : #accessing }
BundleOfEmployees >> at: anIndex put: anEmployee [
	self checkAnObject: anEmployee.
	^ memory at: anIndex put: anEmployee
]

{ #category : #'as yet unclassified' }
BundleOfEmployees >> checkAnObject: anObject [ [

	(anObject isKindOf: Employee) ifFalse: [
		^ self error: 'BundleOfEmployees contains only Employee instances' ]
]
]

{ #category : #enumerating }
BundleOfEmployees >> do: aBlock [
	memory do: aBlock
]

{ #category : #initialization }
BundleOfEmployees >> initialize [
	memory := OrderedCollection new.
]

{ #category : #'class factory' }
BundleOfEmployees >> ofType: aType [
	^ self class new addAll: (memory select: [ :x | x isMemberOf: aType ]); yourself.
]

{ #category : #printing }
BundleOfEmployees >> printToFile: pathString [
	pathString asFileReference writeStreamDo: [ :out |
		out nextPutAll: self printString ]
]

{ #category : #files }
BundleOfEmployees >> saveToFile: pathString [
	pathString asFileReference writeStreamDo: [ :out |
		out nextPutAll: (STON toString: self) ].
]

{ #category : #accessing }
BundleOfEmployees >> size [ 
	^ memory size
]

{ #category : #'as yet unclassified' }
BundleOfEmployees >> storeToFile: pathString [
	pathString asFileReference writeStreamDo: [ :out |
		out nextPutAll: self storeString ]
]
