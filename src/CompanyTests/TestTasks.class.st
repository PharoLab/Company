Class {
	#name : #TestTasks,
	#superclass : #TestCase,
	#category : #CompanyTests
}

{ #category : #tests }
TestTasks >> testCreatingManagersCollectionFromGeneral [
	|collection result manager1 manager2 programmer1 programmer2|
	programmer1 := Programmer basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; actuallyHours: 42; hourlyRate: 10.
	programmer2 := Programmer basicNew lastName: 'James'; experience: 8; minHoursWorked: 40; actuallyHours: 35; hourlyRate: 20.
	manager1 := Manager basicNew lastName: 'Williams'; experience: 15; minHoursWorked: 40; hourlyRate: 40; subordinatesCount: 0.
	manager2 := Manager basicNew lastName: 'Brown'; experience: 25; minHoursWorked: 40; hourlyRate: 60; subordinatesCount: 5.
	
	collection := (OrderedCollection with: programmer1 with: programmer2 with: manager1 with: manager2).
	
	result := Tasks createManagersCollection:  collection.
	
	result do: [ :employee |
		self assert: (employee class) equals: Manager.
		 ].
]

{ #category : #tests }
TestTasks >> testCreatingProgrammersCollectionFromGeneral [
	|collection result manager1 manager2 programmer1 programmer2|
	programmer1 := Programmer basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; actuallyHours: 42; hourlyRate: 10.
	programmer2 := Programmer basicNew lastName: 'James'; experience: 8; minHoursWorked: 40; actuallyHours: 35; hourlyRate: 20.
	manager1 := Manager basicNew lastName: 'Williams'; experience: 15; minHoursWorked: 40; hourlyRate: 40; subordinatesCount: 0.
	manager2 := Manager basicNew lastName: 'Brown'; experience: 25; minHoursWorked: 40; hourlyRate: 60; subordinatesCount: 5.
	
	collection := (OrderedCollection with: programmer1 with: programmer2 with: manager1 with: manager2).
	
	result := Tasks createProgrammersCollection:  collection.
	
	result do: [ :employee |
		self assert: (employee class) equals: Programmer.
		 ].
]

{ #category : #tests }
TestTasks >> testTheHighestPaid [
	|manager programmer collection result|
	manager := Manager basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; hourlyRate: 20; subordinatesCount: 0.
	programmer := Programmer basicNew lastName: 'Smith'; experience: 5; minHoursWorked: 40; actuallyHours: 35; hourlyRate: 10.
	collection := (OrderedCollection with: manager with: programmer).
	
	result := (Tasks findHighestWage: collection).
	
	self assert: result equals: manager.
]
