'From Cuis7.1 [latest update: #6814] on 6 November 2024 at 8:04:23 pm'!
'Description '!
!provides: 'ActiveRecord' 1 34!
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


!ARBase methodsFor: 'deleting' stamp: 'RMV 11/6/2024 19:23:09'!
destroy
	"Delete the table row corresponding to the current object from the database
	and answer the ODBCResultSet."
	| queryString |
	
	queryString​ := 'delete from {1} where id={2}' format: {self class tableName. self id}.
	^​ Conn execute: queryString.! !

!ARBase methodsFor: 'private' stamp: 'RMV 11/6/2024 19:10:47'!
changed: zeroOrOne
	"This method is implemented in Object, but we need it to trigger doesNotUnderstand:."
	| message |

	message := Message selector: #changed argument: zeroOrOne. 
	^ self doesNotUnderstand: message! !

!ARBase methodsFor: 'accessing' stamp: 'RMV 11/6/2024 19:23:45'!
doesNotUnderstand: aMessage
	"Handle requests to get or set an instance variable
	and update the corresponding database row."
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
			Conn execute: query.
		]
		ifFalse: [
			"Simulate getting an instance variable."
			^ row at: keyword asSymbol ifAbsent: nil.
		].
! !

!ARBase methodsFor: 'accessing' stamp: 'RMV 11/6/2024 19:13:19'!
row: anODBCRow
	"Set the row instance variable of the current object to a given ODBCRow."

	row := anODBCRow! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/6/2024 19:18:37'!
all
	"Answer an ODBCResultSet containing all rows in the corresponding table."
	
	self initialize.
	^ Conn execute: 'select * from ', self tableName.! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/6/2024 19:20:24'!
columns
	"Answer an array of ODBCColumn objects describing each column in the corresponding table."
	| queryString rs |
	
	self initialize.

	"This query returns an empty ODBCResultSet for the corresponding table
	which can be used to get information about its columns."
	queryString​ := 'select * from {1} where 1=2' format: {self tableName}.

	rs := Conn execute: queryString.
	^ rs columns.! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/6/2024 19:21:17'!
find: idNumber
	"Answer new instance of this class that represents the table row with a given id."
	| queryString row rs |
	
	self initialize.
	queryString​ := 'select * from {1} where id={2}' format: {self tableName. idNumber}.
	rs := Conn execute: queryString.
	row := rs next. "ODBCResultSet is a subclass of Stream."
	^ self newRow: row.! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/6/2024 20:03:56'!
connection
	^ Conn! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/6/2024 18:48:42'!
disconnect
	"Close the database connect if there is one."

	Conn ifNotNil: [
		Conn close.
		Conn := nil.
	]! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/6/2024 18:49:35'!
establishConnection: dsnString	
	"Open a connection to the database for a given DSN if not already open."
	"TODO: Add support for getting username and password from '.odbc.ini'
	by capturing output of 'odbcinst -q -s -n dsnString'?"

	Conn ifNil: [ Conn := ODBCConnection dsn: dsnString user: '' password: '' ]
! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/6/2024 19:28:53'!
newRow
	"Create a new row in the corresponding table and answer an ODBCResultSet containing it.
	This assumes the table has an id column with type autoincrement integer."
	| columns names queryString size stream values |
	
	"Get all the columns except the id column."
	columns := self columns reject: [:column | column name = #id].
	
	size := columns size.
	names := columns collect: [:column | column name].
	values := columns collect: [:column |
		| type |
		type := column dataType.
		type caseOf: {
			['Double'] -> [0].
			['Integer'] -> [0].
			['VarChar'] -> ['""'].
		} otherwise: [nil].
	].
	
	stream := WriteStream on: (String new: 200).
	stream nextPutAll: 'insert into '.
	stream nextPutAll: self tableName.
	stream nextPutAll: ' ('.
	names withIndexDo: [:colName :index |
		stream nextPutAll: colName.
		index < size ifTrue: [ stream nextPutAll: ', ' ].
	].
	stream nextPutAll: ') values ('.
	values withIndexDo: [:value :index |
		stream nextPutAll: value asString.
		index < size ifTrue: [ stream nextPutAll: ', ' ].
	].
	stream nextPutAll: ')'.
	queryString := stream contents.
	queryString logAs: 'queryString'.
	
	"TODO: Why does this return an ODBCResultSet with rowCount 1, but next returns nil?"
	^ Conn execute: queryString.
	! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/6/2024 18:51:47'!
newRow: row
	"Create and answer a new instance of this class with a row instance variable."
	| instance |

	instance := self new.
	instance row: row.
	^instance.! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/6/2024 20:00:44'!
newRowWith: assocArray
	"Create a new row in the corresponding table and answer an ODBCResultSet containing it.
	This assumes the table has an id column with type autoincrement integer."
	| columns dict names queryString size stream values |
	
	dict := assocArray asDictionary.
	
	"Get all the columns except the id column."
	columns := self columns reject: [:column | column name = #id].
	
	size := columns size.
	names := columns collect: [:column | column name].
	values := columns collect: [:column |
		| type value |
		value := dict at: column name.
		value ifNil: [
			"Use a default value of the correct type."
			type := column dataType.
			value := type caseOf: {
				['Double'] -> [0].
				['Integer'] -> [0].
				['VarChar'] -> [''].
			} otherwise: [nil].
		].
		value isKindOf: String :: ifTrue: ['"', value, '"'] ifFalse: [value].
	].
	
	stream := WriteStream on: (String new: 200).
	stream nextPutAll: 'insert into '.
	stream nextPutAll: self tableName.
	stream nextPutAll: ' ('.
	names withIndexDo: [:colName :index |
		stream nextPutAll: colName.
		index < size ifTrue: [ stream nextPutAll: ', ' ].
	].
	stream nextPutAll: ') values ('.
	values withIndexDo: [:value :index |
		stream nextPutAll: value asString.
		index < size ifTrue: [ stream nextPutAll: ', ' ].
	].
	stream nextPutAll: ')'.
	queryString := stream contents.
	queryString logAs: 'queryString'.
	
	"TODO: Why does this return an ODBCResultSet with rowCount 1, but next returns nil?"
	^ Conn execute: queryString.
	! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/6/2024 18:52:12'!
tableName
	"Answer the table name the corresponds to the current class."

	^ self name asPlural asLowercase.
! !

!Object methodsFor: '*ActiveRecord' stamp: 'RMV 11/5/2024 18:37:07'!
logAs: aString
    ('{1} = {2}' format: {aString. self}) print! !

!ODBCColumn methodsFor: '*ActiveRecord' stamp: 'RMV 11/4/2024 19:02:41'!
dataType
	"answer the receiver's data type"
	^ dataType! !
