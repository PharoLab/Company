Class {
	#name : #TestCompany,
	#superclass : #TestCase,
	#category : #CompanyTests
}

{ #category : #tests }
TestCompany >> testAdd [

	| bundle |
	bundle := Company new.
	self assert: bundle size equals: 0.
	bundle
		add: Programmer new;
		add: Manager new.
	self assert: bundle size equals: 2.
]

{ #category : #tests }
TestCompany >> testAddFirst [

	| bundle programmer manager |
	programmer := Programmer new.
	manager := Manager new.
	bundle := Company new addAll: { Manager new . Programmer new }; yourself.
	bundle addFirst: programmer.
	self assert: (bundle at: 1) equals: programmer.
	self assert: (bundle size) equals: 3.
	bundle addFirst: manager.
	self assert: (bundle at: 1) equals: manager.
	self assert: (bundle size) equals: 4.
]

{ #category : #tests }
TestCompany >> testAt [

	| bundle programmer manager |
	bundle := Company new.
	programmer := Programmer new.
	manager := Manager new.
	bundle add: programmer; add: manager.
	self assert: (bundle at: 1) equals: programmer.
	self assert: (bundle at: 2) equals: manager.
	self should: [ bundle at: 5 ] raise: Error.
]

{ #category : #tests }
TestCompany >> testAtPut [
	| bundle programmer manager |
	programmer  := Programmer new.
	manager  := Manager new.
	bundle := Company new addAll: { Programmer new . Manager new }; yourself.
	self assert: (bundle at: 1 put: manager) equals: manager.
	self assert: (bundle at: 1) equals: manager.
	self assert: (bundle at: 2 put: programmer) equals: programmer.
	self should: [ bundle at: 5 put: 10] raise: Error.
]

{ #category : #tests }
TestCompany >> testChangeWage [
	|company|
	company := Company new.
	company add: Programmer new.
	company add: Manager new.
	self assert: (company memory at:1) hourlyRate equals: 10.
	self assert: (company memory at:2) hourlyRate equals: 10.
	company changeWage: 1.1.
	self assert: (company memory at:1) hourlyRate equals: 11.
	self assert: (company memory at:1) hourlyRate equals: 11.
]

{ #category : #tests }
TestCompany >> testCheckSubordinatesCount [
	|company|
	company := Company new.
	company add: Programmer new.
	company add: Manager new.
	self assert: company checkSubordinatesCount equals: false.
	company add: Programmer new.
	company add: Programmer new.
	self assert: company checkSubordinatesCount equals: true.
	

]

{ #category : #tests }
TestCompany >> testDismiss [
	|company|
	company := Company new.
	company add: Programmer new.
	company add: Manager new.
	self assert: (company memory at:1) lastName equals: 'Fred'.
	self assert: company memory size equals: 2.
	company dismiss: 'Fred'.
	self assert: company memory size equals: 1.
	self assert: 
		(company memory allSatisfy: [ :employee | employee lastName ~= 'Fred' ]) 
		equals: true.
	
]

{ #category : #tests }
TestCompany >> testFollowNorm [
	|company|
	company := Company new.
	company add: (Programmer newLastName: '1' andExperience:1  andHourlyRate:1  andMinHoursWorked:40  	andActuallyHours:39). 
	company add: (Programmer newLastName: '2' andExperience:1  andHourlyRate:1  andMinHoursWorked:40  	andActuallyHours:40). 
	company add: (Programmer newLastName: '3' andExperience:1  andHourlyRate:1  andMinHoursWorked:40  	andActuallyHours:41). 
		
	self assert: company followNorm equals: false.
	company dismiss: '1'.
	self assert: company followNorm equals: true.
	
]

{ #category : #tests }
TestCompany >> testInitialize [

	self assert: Company new size equals: 0
]

{ #category : #tests }
TestCompany >> testNewName [
	|company|
	company := Company new.
	self assert: company name equals: 'Collection'.
	company := Company newName: 'Test'.
	self assert: company name equals: 'Test'.
]

{ #category : #tests }
TestCompany >> testTotalWeekWage [
	|company|
	company := Company new.
	company add: Programmer new.
	company add: Manager new.
	self assert: (company memory at:1) weekWage + (company memory at:2) weekWage 
		equals: company totalWeekWage.
	
]
