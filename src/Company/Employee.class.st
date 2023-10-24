"
The basic class of our company employees.
"
Class {
	#name : #Employee,
	#superclass : #Object,
	#instVars : [
		'lastName',
		'experience',
		'hourlyRate',
		'minHoursWorked'
	],
	#category : #Company
}

{ #category : #adding }
Employee class >> addTo: aContainer [
	aContainer add: self create.
]

{ #category : #'as yet unclassified' }
Employee class >> comparison: anEmployee1 with: anEmployee2 [
	anEmployee1 weekWage > anEmployee2 weekWage
		ifTrue: [ ^anEmployee1 ]  
		ifFalse: [ ^anEmployee2 ].
]

{ #category : #adding }
Employee class >> create [
	| lastname experience hourlyRate minHoursWorked | 
	lastname := UIManager default request: 'Input lastname for', self class.
	experience := UIManager default request: 'Input experience', self class.
	hourlyRate := UIManager default request: 'Input hourly rate', self class.
	minHoursWorked := UIManager default request: 'Input min hours worked', self class.
	lastname isNil | experience isNil | hourlyRate isNil | minHoursWorked isNil
		ifFalse: [ ^self newLastName: lastname asString andExperience: experience asNumber 
				andHourlyRate: hourlyRate asNumber andMinHoursWorked: minHoursWorked asNumber].
]

{ #category : #'instance creation' }
Employee class >> newLastName:aName andExperience:aExperience andHourlyRate:aHourlyRate andMinHoursWorked:aMinHoursWorked [
	"| employee |
	employee := self basicNew.
	employee lastName: aName.
	employee experience: aExperience.
	employee hourlyRate: aHourlyRate.
	employee minHoursWorked: aMinHoursWorked."
	
	^self basicNew lastName: aName; experience: aExperience;
	 	hourlyRate: aHourlyRate; minHoursWorked: aMinHoursWorked.
]

{ #category : #comparing }
Employee >> < anEmployee [
	^ self weekWage < anEmployee weekWage.
]

{ #category : #comparing }
Employee >> <= anEmployee [
	^ self weekWage <= anEmployee weekWage.
]

{ #category : #comparing }
Employee >> = anEmployee [
	self subclassResponsibility.
]

{ #category : #comparing }
Employee >> > anEmployee [
	^ self weekWage > anEmployee weekWage.
]

{ #category : #comparing }
Employee >> >= anEmployee [
	^ self weekWage >= anEmployee weekWage.
]

{ #category : #accessing }
Employee >> experience [
	^experience.
]

{ #category : #accessing }
Employee >> experience: aNumber [
	aNumber < 0 
		ifTrue: [ experience := aNumber negated. ] 
		ifFalse: [ experience := aNumber. ].
]

{ #category : #accessing }
Employee >> hourlyRate [
	^hourlyRate.
]

{ #category : #accessing }
Employee >> hourlyRate: aNumber [
	aNumber < 0 
		ifTrue: [ hourlyRate := aNumber negated. ] 
		ifFalse: [ hourlyRate := aNumber. ].
]

{ #category : #accessing }
Employee >> lastName [
	^lastName.
]

{ #category : #accessing }
Employee >> lastName: aName [
	lastName := aName.
]

{ #category : #'as yet unclassified' }
Employee >> levelUp [
	experience := experience + 1. 
]

{ #category : #accessing }
Employee >> minHoursWorked [
	^minHoursWorked.
]

{ #category : #accessing }
Employee >> minHoursWorked: aNumber [
	aNumber < 0 
		ifTrue: [ minHoursWorked := aNumber negated. ] 
		ifFalse: [ minHoursWorked := aNumber. ].
]

{ #category : #printing }
Employee >> printOn: aStream [
	self subclassResponsibility.
	 
	
]

{ #category : #'as yet unclassified' }
Employee >> weekWage [
	self subclassResponsibility.
]
