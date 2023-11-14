"
The Programmer class.
"
Class {
	#name : #Programmer,
	#superclass : #Employee,
	#instVars : [
		'actuallyHours'
	],
	#category : #Company
}

{ #category : #adding }
Programmer class >> addTo: aContainer [
	aContainer add: self create.
]

{ #category : #adding }
Programmer class >> create [
	| lastname experience hourlyRate minHoursWorked actuallyHours | 
	lastname := UIManager default request: ('Input lastname for').
	experience := UIManager default request: ('Input experience for').
	hourlyRate := UIManager default request: ('Input hourly rate for').
	minHoursWorked := UIManager default request: ('Input min hours worked for').
	actuallyHours := UIManager default request: ('Input actually hours for').
	lastname isNil | experience isNil | hourlyRate isNil | minHoursWorked isNil
		ifFalse: [ ^self newLastName: lastname asString andExperience: experience asNumber  		andHourlyRate: hourlyRate asNumber andMinHoursWorked: minHoursWorked asNumber 
		andActuallyHours: actuallyHours asNumber ]. 
]

{ #category : #'instance creation' }
Programmer class >> newLastName:aName andExperience:aExperience 
andHourlyRate:aHourlyRate andMinHoursWorked:aMinHoursWorked
andActuallyHours: anActuallyHours [
	| realHourlyRate |
	realHourlyRate := 0.
	anActuallyHours < aMinHoursWorked 
		ifTrue: [ realHourlyRate := aHourlyRate * 0.75. ] 
		ifFalse: [ realHourlyRate := aHourlyRate. ].
	^self basicNew lastName: aName; experience: aExperience;
	 	hourlyRate: realHourlyRate; minHoursWorked: aMinHoursWorked; actuallyHours: anActuallyHours.
]

{ #category : #comparing }
Programmer >> = aProgrammer [
	^ ((self weekWage = aProgrammer weekWage) & (self experience = aProgrammer experience)
	& (self hourlyRate  = aProgrammer hourlyRate) & (self lastName  = aProgrammer lastName) & 
	(self minHoursWorked = aProgrammer minHoursWorked) & (self actuallyHours = aProgrammer actuallyHours)).
]

{ #category : #accessing }
Programmer >> actuallyHours [
	^actuallyHours.
]

{ #category : #accessing }
Programmer >> actuallyHours: aNumber [
	aNumber < 0 
		ifTrue: [ actuallyHours := aNumber negated. ] 
		ifFalse: [ actuallyHours := aNumber. ].
]

{ #category : #initialization }
Programmer >> initialize [ 
	lastName := 'Fred'.
	experience := 1.
	hourlyRate := 10.
	minHoursWorked := 35.
	actuallyHours  := 35.
]

{ #category : #'as yet unclassified' }
Programmer >> levelUp [
	experience := self experience + 1. 
]

{ #category : #printing }
Programmer >> printOn: aStream [

	aStream nextPutAll: 'a Programmer('.
	lastName  printOn: aStream .
	aStream nextPut: $,.
	experience printOn: aStream .
	aStream nextPut: $,.
	hourlyRate printOn: aStream .
	aStream nextPut: $,.
	minHoursWorked printOn: aStream .
	aStream nextPut: $,.
	actuallyHours printOn: aStream .
	aStream nextPut: $).
]

{ #category : #'as yet unclassified' }
Programmer >> weekWage [
actuallyHours < minHoursWorked 
		ifTrue: [ hourlyRate := hourlyRate * 0.75. ].
	^(hourlyRate * minHoursWorked).
]
