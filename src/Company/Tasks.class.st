Class {
	#name : #Tasks,
	#superclass : #Object,
	#category : #Company
}

{ #category : #adding }
Tasks class >> addToCollection: aCollection [
	"add objects to a colection"
	|numOfProgrammers numOfManagers|
	numOfProgrammers := (UIManager default request: ('Enter the quantity of programmers')) asInteger.
	numOfProgrammers timesRepeat: [ 
		Programmer addTo: aCollection.
	].
	numOfManagers  := (UIManager default request: ('Enter the quantity of managers')) asInteger.
	numOfManagers timesRepeat: [ 
		Manager addTo: aCollection.
	].
	
]

{ #category : #'as yet unclassified' }
Tasks class >> createManagersCollection: aCollection [
	|resultCollection|
	resultCollection := OrderedCollection new.
	
	resultCollection := aCollection select: [ :employee |
		(employee isKindOf: Manager)
	].
	
	^resultCollection.
]

{ #category : #'as yet unclassified' }
Tasks class >> createProgrammersCollection: aCollection [
	|resultCollection|
	resultCollection := OrderedCollection new.
	
	resultCollection := aCollection select: [ :employee |
		(employee isKindOf: Programmer)
	].
	
	^resultCollection.
]

{ #category : #'as yet unclassified' }
Tasks class >> findHighestWage: aCollection [
	"find the highest paid employee"
	|employeeWithTheLargestWage|
	employeeWithTheLargestWage := (aCollection at: 1).
	
	aCollection do: [ :employee |
		employee > employeeWithTheLargestWage ifTrue: [ 
			employeeWithTheLargestWage := employee. ] ].
	
	^employeeWithTheLargestWage.
	
]
