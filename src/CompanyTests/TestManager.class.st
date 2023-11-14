Class {
	#name : #TestManager,
	#superclass : #TestCase,
	#category : #CompanyTests
}

{ #category : #tests }
TestManager >> testAreManagersEqual [
	|manager1 manager2|
	
	manager1 := Manager basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; hourlyRate: 20; subordinatesCount: 0.
	manager2 := Manager basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; hourlyRate: 20; subordinatesCount: 0.
	
	self assert: manager1 equals: manager2. 
]

{ #category : #tests }
TestManager >> testIsManagerGetLessSalary [
	|manager1 manager2|
	
	manager1 := Manager basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; hourlyRate: 20; subordinatesCount: 0.
	manager2 := Manager basicNew lastName: 'James'; experience: 5; minHoursWorked: 40; hourlyRate: 20; subordinatesCount: 2.
	
	self assert: manager1 < manager2. 
]

{ #category : #tests }
TestManager >> testIsManagerGetMoreSalary [
	|manager1 manager2|
	
	manager1 := Manager basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; hourlyRate: 20; subordinatesCount: 0.
	manager2 := Manager basicNew lastName: 'James'; experience: 5; minHoursWorked: 40; hourlyRate: 20; subordinatesCount: 2.
	
	self assert: manager2 > manager1. 
]

{ #category : #tests }
TestManager >> testLevelUp [
	|manager|
	
	manager := Manager basicNew lastName: 'Smith'; experience: 20; minHoursWorked: 40; hourlyRate: 20; subordinatesCount: 2.
	
	manager levelUp.
	
	self assert: manager experience equals: 21.
]

{ #category : #tests }
TestManager >> testPassNegativeHourRate [
	|manager|
	
	manager := Manager basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; hourlyRate: -20; subordinatesCount: 2.
	
	self assert: manager hourlyRate equals: 20.
]

{ #category : #tests }
TestManager >> testSubordinatesIsBiggerThanZero [
	|manager|
	
	manager := Manager basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; hourlyRate: 20; subordinatesCount: 2.
	self assert: manager weekWage equals: 816. 
]

{ #category : #tests }
TestManager >> testSubordinatesIsEqualZero [
	|manager|
	
	manager := Manager basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; hourlyRate: 20; subordinatesCount: 0.
	self assert: manager weekWage equals: 800. 
]
