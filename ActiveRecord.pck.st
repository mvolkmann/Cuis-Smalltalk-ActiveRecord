'From Cuis7.1 [latest update: #6814] on 5 November 2024 at 6:43:54 pm'!
'Description '!
!provides: 'ActiveRecord' 1 18!
!requires: 'ODBC' 1 9 nil!
SystemOrganization addCategory: #ActiveRecord!


!classDefinition: #ARBase category: #ActiveRecord!
Object subclass: #ARBase
	instanceVariableNames: 'row'
	classVariableNames: 'Conn TableName'
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'ARBase class' category: #ActiveRecord!
ARBase class
	instanceVariableNames: ''!

!classDefinition: #Dog category: #ActiveRecord!
ARBase subclass: #Dog
	instanceVariableNames: 'id breed name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'Dog class' category: #ActiveRecord!
Dog class
	instanceVariableNames: ''!

!classDefinition: #Todo category: #ActiveRecord!
ARBase subclass: #Todo
	instanceVariableNames: 'id description completed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'Todo class' category: #ActiveRecord!
Todo class
	instanceVariableNames: ''!


!ARBase methodsFor: 'deleting' stamp: 'RMV 11/4/2024 18:30:22'!
destroy
	| queryString stmt |
	
	queryString​ := 'delete from {1} where id={2}' format: {self class tableName. self id}.
	stmt := Conn query: queryString.
	^​ stmt execute.! !

!ARBase methodsFor: 'private' stamp: 'RMV 11/3/2024 20:19:21'!
changed: zeroOrOne
	"This method is implemented in Object, but we need it to trigger doesNotUnderstand:."
	| message |
	message := Message selector: #changed argument: zeroOrOne. 
	^ self doesNotUnderstand: message! !

!ARBase methodsFor: 'accessing' stamp: 'RMV 11/3/2024 20:23:40'!
doesNotUnderstand: aMessage
	"handles requests to modify an instance variable"
	| keyword keywords |

	keywords := aMessage keywords.
	
	"Only handle messages with a single keyword."
	keywords size > 1 ifTrue: [^super doesNotUnderstand: aMessage].
	
	keyword := keywords first.
	"TODO: This will not be called if the keyword matches an existing selected (ex. changed:)."
	keyword endsWith: ':' ::
		ifTrue: [
			"Simulate setting an instance variable."
			| arg instVarName query tableName |
			instVarName := keyword allButLast asSymbol.
			"If the instance variable is not in the row Dictionary ..."
			row at: instVarName ifAbsent: [
				^super doesNotUnderstand: aMessage.
			].
			arg := aMessage arguments first.
			row at: instVarName put: arg.
			
			"Update the database row. Later this will be done when a transaction is commited."
			tableName := self class tableName.
			"TODO: This assumes the new value is a string."
			query := 'update {1} set {2}="{3}" where id={4}' format: {tableName. instVarName. arg. self id}.
			Conn query: query :: execute.
		]
		ifFalse: [
			"Simulate getting an instance variable."
			^ row at: keyword asSymbol ifAbsent: nil.
		].
! !

!ARBase methodsFor: 'accessing' stamp: 'RMV 11/3/2024 09:33:44'!
row: anODBCRow
	row := anODBCRow! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/3/2024 16:24:43'!
all
	| queryString rs stmt |
	
	self initialize.
	queryString​ := 'select * from ', self tableName.
	stmt := Conn query: queryString.
	rs := stmt execute.
	^ rs.! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/5/2024 18:40:10'!
find: idNumber
	| queryString row rs stmt |
	
	self initialize.
	queryString​ := 'select * from {1} where id={2}' format: {self tableName. idNumber}.
	queryString logAs: 'queryString'.
	self halt.
	stmt := Conn query: queryString.
	rs := stmt execute.
	row := rs next. "ODBCResultSet is a subclass of Stream."
	^ self newRow: row.! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/3/2024 09:15:04'!
disconnect
	Conn ifNotNil: [
		Conn close.
		Conn := nil.
	]! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/3/2024 16:29:47'!
establishConnection: dsnString	
	"TODO: Add support for getting username and password from '.odbc.ini'
	by capturing output of 'odbcinst -q -s -n dsnString'?"
	Conn ifNil: [ Conn := ODBCConnection dsn: dsnString user: '' password: '' ]
! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/5/2024 18:41:47'!
newRow
	"Creates a new row in table and assumes there is a id column with type autoincrement integer."
	| queryString stmt |
	queryString := 'insert into ', self tableName.
	stmt := Conn query: queryString.
	^ stmt execute.

	! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/5/2024 18:42:23'!
newRow: row
	| instance |
	instance := self new.
	instance row: row.
	^instance.! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/3/2024 16:24:30'!
tableName
	^ self name asPlural asLowercase.
! !

!Object methodsFor: '*ActiveRecord' stamp: 'RMV 11/5/2024 18:37:07'!
logAs: aString
    ('{1} = {2}' format: {aString. self}) print! !

!ODBCColumn methodsFor: '*ActiveRecord' stamp: 'RMV 11/4/2024 19:02:41'!
dataType
	"answer the receiver's data type"
	^ dataType! !
