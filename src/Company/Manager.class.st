"
The Manager class.
"
Class {
	#name : #Manager,
	#superclass : #Employee,
	#instVars : [
		'subordinatesCount'
	],
	#category : #Company
}

{ #category : #adding }
Manager class >> addTo: aContainer [
	aContainer add: self create.
]

{ #category : #adding }
Manager class >> create [
	| lastname experience hourlyRate subordinatesCount | 
	lastname := UIManager default request: 'Input lastname for'.
	experience := UIManager default request: 'Input experience for'.
	hourlyRate := UIManager default request: 'Input hourly rate for'.
	subordinatesCount := UIManager default request: 'Input subordinates count for'.
	lastname isNil | experience isNil | hourlyRate isNil
		ifFalse: [ ^self newLastName: lastname asString andExperience: experience asNumber  		andHourlyRate: hourlyRate asNumber andMinHoursWorked: 40 
		andSubordinatesCount: subordinatesCount asNumber ].
]

{ #category : #'instance creation' }
Manager class >> newLastName:aName andExperience:aExperience 
andHourlyRate:aHourlyRate andMinHoursWorked:aMinHoursWorked
andSubordinatesCount: aSubordinatesCount [
	^self basicNew lastName: aName; experience: aExperience;
	 	hourlyRate: ((1 + (aSubordinatesCount / 100)) * aHourlyRate asFloat); minHoursWorked: aMinHoursWorked; subordinatesCount: aSubordinatesCount.
]

{ #category : #comparing }
Manager >> = aManager [
	^ ((self weekWage = aManager weekWage) & (self experience = aManager experience)
	& (self hourlyRate  = aManager hourlyRate) & (self lastName  = aManager lastName) & 
	(self minHoursWorked = aManager minHoursWorked) & 
	(self subordinatesCount = aManager subordinatesCount)).
]

{ #category : #accessing }
Manager >> actuallyHours [ 
	^ 'nil'
]

{ #category : #initialization }
Manager >> initialize [ 
	lastName := 'Johnson'.
	experience := 10.
	hourlyRate := 10.
	minHoursWorked := 40.
	subordinatesCount := 3.
]

{ #category : #printing }
Manager >> printOn: aStream [

	aStream nextPutAll: 'a Manager('.
	lastName  printOn: aStream .
	aStream nextPut: $,.
	experience printOn: aStream .
	aStream nextPut: $,.
	hourlyRate printOn: aStream .
	aStream nextPut: $,.
	minHoursWorked printOn: aStream .
	aStream nextPut: $,.
	subordinatesCount printOn: aStream .
	aStream nextPut: $).
]

{ #category : #accessing }
Manager >> subordinatesCount [
	^subordinatesCount.
]

{ #category : #accessing }
Manager >> subordinatesCount: aNumber [
	aNumber < 0 
		ifTrue: [ subordinatesCount := aNumber negated. ] 
		ifFalse: [ subordinatesCount := aNumber. ]. 
]

{ #category : #'as yet unclassified' }
Manager >> weekWage [
|wageWithoutAllowance|
	wageWithoutAllowance := (hourlyRate * minHoursWorked).
	^(wageWithoutAllowance + (wageWithoutAllowance * (subordinatesCount / 100))).
]
