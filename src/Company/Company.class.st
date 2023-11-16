Class {
	#name : #Company,
	#superclass : #Object,
	#instVars : [
		'name',
		'memory'
	],
	#category : #Company
}

{ #category : #'as yet unclassified' }
Company class >> loadFromCodeFile: pathString [
	pathString asFileReference readStreamDo: [ :in | ^ Smalltalk compiler evaluate: in contents ].
]

{ #category : #'as yet unclassified' }
Company class >> loadFromStonFile: pathString [ 
pathString asFileReference readStreamDo: [ :in | ^ (STON reader on: in) next ].
]

{ #category : #'instance creation' }
Company class >> newName: aName [
	
	^self basicNew name: aName; memory: OrderedCollection new.
]

{ #category : #'as yet unclassified' }
Company class >> pickFileAndLoad: pattern [
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
Company >> add: anEmployee [
	self checkAnObject: anEmployee.
	^ memory add: anEmployee.
]

{ #category : #adding }
Company >> addAll: anEmployeeCollection [
	^ memory addAll: (anEmployeeCollection select: [ :x | x isKindOf: Employee ])
]

{ #category : #adding }
Company >> addDefaultEmployees [
	self add: (Programmer newLastName: 'Dolishnii' andExperience:1 andHourlyRate:30  	andMinHoursWorked:36  andActuallyHours:40). 
	self add: (Programmer newLastName: 'Dzysiuk' andExperience:1 andHourlyRate:32 andMinHoursWorked:40  	andActuallyHours:40). 
	self add: (Programmer newLastName: 'Naida' andExperience:1 andHourlyRate:36 andMinHoursWorked:32  	andActuallyHours:37).
	self add: (Manager newLastName: 'Manager' andExperience:5 andHourlyRate:90 andMinHoursWorked:40  	andSubordinatesCount: 3). 
]

{ #category : #adding }
Company >> addFirst: anEmployee [
	self checkAnObject: anEmployee.
	^ memory addFirst: anEmployee
]

{ #category : #accessing }
Company >> at: anIndex [
	^ memory at: anIndex
]

{ #category : #accessing }
Company >> at: anIndex put: anEmployee [
	self checkAnObject: anEmployee.
	^ memory at: anIndex put: anEmployee
]

{ #category : #'as yet unclassified' }
Company >> changeWage: aNumber [
	memory := memory do: [ :employee | employee hourlyRate: employee hourlyRate * aNumber ].
]

{ #category : #'as yet unclassified' }
Company >> checkAnObject: anObject [ [

	(anObject isKindOf: Employee) ifFalse: [
		^ self error: 'BundleOfEmployees contains only Employee instances' ]
]
]

{ #category : #'as yet unclassified' }
Company >> checkSubordinatesCount [
	|programmersCount managerList|
	programmersCount := (memory select: [ :employee | employee isKindOf: Programmer ]) size.
	managerList := memory select: [ :employee | employee isKindOf: Manager ].
	"^managerList allSatisfy: [ :manager | manager subordinatesCount = programmersCount ]."
	^((managerList inject: 0 into: [ :sum :employee | sum + employee subordinatesCount ]) = programmersCount).
]

{ #category : #'as yet unclassified' }
Company >> dismiss: aLastName [
	memory := memory select: [ :e | e lastName ~= aLastName ].

]

{ #category : #enumerating }
Company >> do: aBlock [
	memory do: aBlock
]

{ #category : #'as yet unclassified' }
Company >> findHighestPaidEmployee [
	"find the highest paid employee"
	|theLargestWage|
	theLargestWage := (memory at: 1) weekWage.
	
	memory do: [ :employee |
		employee weekWage > theLargestWage ifTrue: [ 
			theLargestWage := employee weekWage. ] ].
	
	^memory select: [ :employee |
		employee weekWage = theLargestWage ].
]

{ #category : #'as yet unclassified' }
Company >> findWhoDoNotFollowNorm [
	|programmersList|
	
	programmersList := memory select: [ :employee | employee isKindOf: Programmer].
	^programmersList select: [ :programmer | 
		programmer actuallyHours < programmer minHoursWorked ].
]

{ #category : #'as yet unclassified' }
Company >> followNorm [
	|programmersList|
	
	programmersList := memory select: [ :employee | employee isKindOf: Programmer ].
	^programmersList allSatisfy: [ :programmer | 
		programmer actuallyHours >= programmer minHoursWorked ].
]

{ #category : #initialization }
Company >> initialize [
	memory := OrderedCollection new.
	name := 'Collection'.
]

{ #category : #accessing }
Company >> memory [

	^ memory
]

{ #category : #accessing }
Company >> memory: anObject [

	memory := anObject
]

{ #category : #accessing }
Company >> name [

	^ name
]

{ #category : #accessing }
Company >> name: aName [

	name := aName
]

{ #category : #'class factory' }
Company >> ofType: aType [
	^ self class new addAll: (memory select: [ :x | x isMemberOf: aType ]); yourself.
]

{ #category : #printing }
Company >> printOn: aStream [

	aStream nextPutAll: 'a Company('.
	name  printOn: aStream .
	aStream nextPut: $,.
	memory printOn: aStream .
	aStream nextPut: $).
]

{ #category : #printing }
Company >> printToFile: pathString [
	pathString asFileReference writeStreamDo: [ :out |
		out nextPutAll: self printString ]
]

{ #category : #files }
Company >> saveToFile: pathString [
	pathString asFileReference writeStreamDo: [ :out |
		out nextPutAll: (STON toString: self) ].
]

{ #category : #accessing }
Company >> size [ 
	^ memory size
]

{ #category : #'as yet unclassified' }
Company >> storeToFile: pathString [
	pathString asFileReference writeStreamDo: [ :out |
		out nextPutAll: self storeString ]
]

{ #category : #accessing }
Company >> totalWeekWage [
	^memory inject: 0 into: [ :sum :employee | sum + employee weekWage ].
]
