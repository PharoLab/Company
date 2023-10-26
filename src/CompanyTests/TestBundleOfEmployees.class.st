Class {
	#name : #TestBundleOfEmployees,
	#superclass : #TestCase,
	#category : #CompanyTests
}

{ #category : #tests }
TestBundleOfEmployees >> testAdd [

	| bundle |
	bundle := BundleOfEmployees new.
	self assert: bundle size equals: 0.
	bundle
		add: Programmer new;
		add: Manager new.
	self assert: bundle size equals: 2.
]

{ #category : #tests }
TestBundleOfEmployees >> testAddFirst [

	| bundle programmer manager |
	programmer := Programmer new.
	manager := Manager new.
	bundle := BundleOfEmployees new addAll: { Manager new . Programmer new }; yourself.
	bundle addFirst: programmer.
	self assert: (bundle at: 1) equals: programmer.
	self assert: (bundle size) equals: 3.
	bundle addFirst: manager.
	self assert: (bundle at: 1) equals: manager.
	self assert: (bundle size) equals: 4.
]

{ #category : #tests }
TestBundleOfEmployees >> testAt [

	| bundle programmer manager |
	bundle := BundleOfEmployees new.
	programmer := Programmer new.
	manager := Manager new.
	bundle add: programmer; add: manager.
	self assert: (bundle at: 1) equals: programmer.
	self assert: (bundle at: 2) equals: manager.
	self should: [ bundle at: 5 ] raise: Error.
]

{ #category : #tests }
TestBundleOfEmployees >> testAtPut [
	| bundle programmer manager |
	programmer  := Programmer new.
	manager  := Manager new.
	bundle := BundleOfEmployees new addAll: { Programmer new . Manager new }; yourself.
	self assert: (bundle at: 1 put: manager) equals: manager.
	self assert: (bundle at: 1) equals: manager.
	self assert: (bundle at: 2 put: programmer) equals: programmer.
	self should: [ bundle at: 5 put: 10] raise: Error.
]

{ #category : #tests }
TestBundleOfEmployees >> testInitialize [

	self assert: BundleOfEmployees new size equals: 0
]
