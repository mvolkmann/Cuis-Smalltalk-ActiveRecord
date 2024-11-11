'From Cuis7.1 [latest update: #6814] on 10 November 2024 at 8:09:56 pm'!
'Description '!
!provides: 'ActiveRecord' 1 49!
!requires: 'ODBC' 1 9 nil!
SystemOrganization addCategory: #ActiveRecord!


!classDefinition: #ARBase category: #ActiveRecord!
Object subclass: #ARBase
	instanceVariableNames: 'row'
	classVariableNames: 'Conn'
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'ARBase class' category: #ActiveRecord!
ARBase class
	instanceVariableNames: 'tableName'!

!classDefinition: #ApplicationRecord category: #ActiveRecord!
ARBase subclass: #ApplicationRecord
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'ApplicationRecord class' category: #ActiveRecord!
ApplicationRecord class
	instanceVariableNames: ''!

!classDefinition: #Dog category: #ActiveRecord!
ApplicationRecord subclass: #Dog
	instanceVariableNames: 'id breed name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'Dog class' category: #ActiveRecord!
Dog class
	instanceVariableNames: ''!

!classDefinition: #GearShiftKnob category: #ActiveRecord!
ApplicationRecord subclass: #GearShiftKnob
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'GearShiftKnob class' category: #ActiveRecord!
GearShiftKnob class
	instanceVariableNames: ''!

!classDefinition: #Person category: #ActiveRecord!
ApplicationRecord subclass: #Person
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'Person class' category: #ActiveRecord!
Person class
	instanceVariableNames: ''!

!classDefinition: #Todo category: #ActiveRecord!
ApplicationRecord subclass: #Todo
	instanceVariableNames: 'id description completed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'Todo class' category: #ActiveRecord!
Todo class
	instanceVariableNames: ''!


!ApplicationRecord commentStamp: 'RMV 11/10/2024 16:50:56' prior: 0!
The purpose of this class is not yet clear to be, but it is present in Rails version 8.
For now it is just a subclass of ARBase that doesn't add any functionality and
classes that correspond to database tables are subclasses of ApplicationRecord instead of ARBase.!

!ARBase methodsFor: 'deleting' stamp: 'RMV 11/6/2024 19:23:09'!
destroy
	"Delete the table row corresponding to the current object from the database
	and answer the ODBCResultSet."
	| queryString |
	
	queryString​ := 'delete from {1} where id={2}' format: {self class tableName. self id}.
	^​ Conn execute: queryString.! !

!ARBase methodsFor: 'deleting' stamp: 'RMV 11/10/2024 18:58:08'!
inspect
	"Answer string description of corresponding database record."
	| stream |
		
	stream := WriteStream on: (String new: 300).
	stream nextPutAll: '#<'.
	stream nextPutAll: self class name.
	stream nextPut: Character space.
	
	self class columns
		do: [:column |
			| name value |
			name := column name.
			value := self perform: name.
			stream nextPutAll: name.
			stream nextPutAll: ': '.
			value isString
				ifTrue: [
					stream nextPut: Character singleQuote.
					stream nextPutAll: value.
					stream nextPut: Character singleQuote.
				]
				ifFalse: [stream nextPutAll: value asString].
		]
		separatedBy: [
			stream nextPutAll: ', '.
		].

	stream nextPutAll: '>'.
	^ stream contents.! !

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

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/9/2024 19:22:43'!
all
	"Answer an ODBCResultSet containing all rows in the corresponding table."
	
	^ Conn execute: 'select * from ', self tableName.! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/9/2024 19:22:37'!
columns
	"Answer an array of ODBCColumn objects describing each column in the corresponding table."
	| queryString rs |
	
	"This query returns an empty ODBCResultSet for the corresponding table
	which can be used to get information about its columns."
	queryString​ := 'select * from {1} where 1=2' format: {self tableName}.

	rs := Conn execute: queryString.
	^ rs columns.! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/9/2024 19:22:16'!
count
	"Answer number of rows in corresponding table."
	| queryString rs column |
	
	column := 'count(*)'.
	queryString​ := 'select {1} from {2}' format: {column. self tableName}.
	rs := Conn execute: queryString.
	^ rs next at: (column asSymbol).! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/9/2024 19:22:48'!
find: idNumber
	"Answer new instance of this class that represents the table row with a given id."
	| queryString row rs |
	
	queryString​ := 'select * from {1} where id={2}' format: {self tableName. idNumber}.
	rs := Conn execute: queryString.
	row := rs next. "ODBCResultSet is a subclass of Stream."
	^ self newRow: row.! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/9/2024 19:36:48'!
findWhere: conditionArray
	"Answer new instances of this class that represent matching table rows."
	| queryString rs size stream |
	
	size := conditionArray size.
	queryString​ := 'select * from {1} where id={2}' format: {self tableName}.
	
	stream := WriteStream on: (String new: 200).
	stream nextPutAll: 'select * from '.
	stream nextPutAll: self tableName.
	stream nextPutAll: ' where '.
	conditionArray withIndexDo: [:condition :index |
		stream nextPutAll: condition.
		index < size ifTrue: [ stream nextPutAll: ' and ' ].
	].
	queryString := stream contents.
	queryString logAs: 'queryString'.
	
	rs := Conn execute: queryString.
	^ rs asTable collect: [:row | self newRow: row].! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/10/2024 20:08:27'!
first
	"Answer new instance of this class that represents the first record in the corresponding table."
	| queryString row rs |
	
	queryString​ := 'select * from {1} limit 1' format: {self tableName}.
	rs := Conn execute: queryString.
	row := rs next. "ODBCResultSet is a subclass of Stream."
	^ self newRow: row.! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/10/2024 20:09:42'!
last
	"Answer new instance of this class that represents the first record in the corresponding table."
	| queryString row rs |
	
	queryString​ := 'select * from {1} order by id desc limit 1' format: {self tableName}.
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

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/6/2024 20:07:39'!
establishConnection: dsnString	
	"Open a connection to the database for a given DSN if not already open."
	"TODO: Add support for getting username and password from '.odbc.ini'
	by capturing output of 'odbcinst -q -s -n dsnString'?"

	Conn ifNil: [ Conn := ODBCConnection dsn: dsnString user: '' password: '' ].
	^ Conn.
! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/10/2024 16:51:46'!
create: assocArray
	"Create a new row in the corresponding table and answer an ODBCResultSet containing it.
	This assumes the table has an id column with type autoincrement integer."
	| column columns dict names queryString rs size stream values |
	
	dict := assocArray asDictionary.
	
	"Get all the columns except the id column."
	columns := self columns reject: [:col | col name = #id].
	
	size := columns size.
	names := columns collect: [:col | col name].
	values := columns collect: [:col |
		| type value |
		value := dict at: col name.
		value ifNil: [
			"Use a default value of the correct type."
			type := col dataType.
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
	
	Conn execute: queryString.
	column := 'last_insert_rowid()'.
	rs := Conn execute: 'select ', column. "TODO: This is specific to SQLite!!"
	^ rs next at: column asSymbol.
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

!ARBase class methodsFor: 'private' stamp: 'RMV 11/10/2024 16:23:03'!
tableName
	"Answer table name that corresponds to current class, computed lazily."

	tableName ifNil: [
		| words |
		words := self name asString camelToWords.
		words at: words size put: (words last asPlural).
		tableName := '_' join: words :: asLowercase.
	].

	^ tableName.
! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/10/2024 16:22:36'!
tableName: aString
	tableName := aString
! !

!Object methodsFor: '*ActiveRecord' stamp: 'RMV 11/5/2024 18:37:07'!
logAs: aString
    ('{1} = {2}' format: {aString. self}) print! !

!String methodsFor: '*ActiveRecord' stamp: 'RMV 11/10/2024 14:20:11'!
camelToWords
	"Answer OrderedCollection of words in CamelCase text."
	| stream word words |

	words := OrderedCollection new.
	stream := self readStream.
	word := stream next asString.
	
	stream do: [:char |
		char isLowercase
			ifTrue: [word := word, char asString]
			ifFalse: [
				words add: word.
				word := char asString.
			]
	].
	words add: word.
	^ words.! !

!ODBCColumn methodsFor: '*ActiveRecord' stamp: 'RMV 11/4/2024 19:02:41'!
dataType
	"answer the receiver's data type"
	^ dataType! !
