Class {
	#name : #TestProgrammer,
	#superclass : #TestCase,
	#category : #CompanyTests
}

{ #category : #tests }
TestProgrammer >> testActualHoursIsMoreOrEqual [
	|programmer|
	
	programmer := Programmer basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; actuallyHours: 42; hourlyRate: 10.
	
	self assert: programmer weekWage equals: 400. 
	
	
]

{ #category : #tests }
TestProgrammer >> testActualHoursIsSmaller [
	|programmer|
	
	programmer := Programmer basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; actuallyHours: 35; hourlyRate: 10.
	self assert: programmer weekWage equals: 300. 
	
	
]

{ #category : #tests }
TestProgrammer >> testLevelUp [
	|programmer|
	
	programmer := Programmer basicNew lastName: 'Bloomberg'; experience: 5; minHoursWorked: 40; actuallyHours: 42; hourlyRate: 10.
	
	programmer levelUp.
	
	self assert: programmer experience equals: 6.
]

{ #category : #tests }
TestProgrammer >> testPassNegativeExperience [
	|programmer|
	
	programmer := Programmer basicNew lastName: 'Bloomberg'; experience: -5; minHoursWorked: 40; actuallyHours: 42; hourlyRate: 10.
	
	self assert: programmer experience equals: 5.
]

{ #category : #tests }
TestProgrammer >> testPassNegativeHourRate [
	|programmer|
	
	programmer := Programmer basicNew lastName: 'Bloomberg'; experience: 5; minHoursWorked: 40; actuallyHours: 42; hourlyRate: -10.
	
	self assert: programmer hourlyRate equals: 10.
]
