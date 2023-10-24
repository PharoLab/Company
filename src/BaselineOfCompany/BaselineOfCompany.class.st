Class {
	#name : #BaselineOfCompany,
	#superclass : #BaselineOf,
	#category : #BaselineOfCompany
}

{ #category : #baselines }
BaselineOfCompany >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec 
			package: 'Company';
			package: 'CompanyTests' with: [ spec requires: #('Company') ] ]
	
]

{ #category : #accessing }
BaselineOfCompany >> projectClass [ 
	^MetacelloCypressBaselineProject.
]
