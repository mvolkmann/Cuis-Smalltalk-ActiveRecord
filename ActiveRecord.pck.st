'From Cuis7.1 [latest update: #6817] on 18 November 2024 at 6:22:03 pm'!
'Description '!
!provides: 'ActiveRecord' 1 83!
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
	instanceVariableNames: 'dbType columns tableName'!

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

!classDefinition: #DatabaseTests category: #ActiveRecord!
TestCase subclass: #DatabaseTests
	instanceVariableNames: 'descriptions dsn dbType'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'DatabaseTests class' category: #ActiveRecord!
DatabaseTests class
	instanceVariableNames: ''!

!classDefinition: #MySQLTests category: #ActiveRecord!
DatabaseTests subclass: #MySQLTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'MySQLTests class' category: #ActiveRecord!
MySQLTests class
	instanceVariableNames: ''!

!classDefinition: #PostgresTests category: #ActiveRecord!
DatabaseTests subclass: #PostgresTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'PostgresTests class' category: #ActiveRecord!
PostgresTests class
	instanceVariableNames: ''!

!classDefinition: #SQLiteTests category: #ActiveRecord!
DatabaseTests subclass: #SQLiteTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'SQLiteTests class' category: #ActiveRecord!
SQLiteTests class
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

!ARBase methodsFor: 'deleting' stamp: 'RMV 11/17/2024 08:16:45'!
inspect
	"Answer string description of corresponding database record."
	| stream |
		
	stream := WriteStream on: (String new: 300).
	stream nextPutAll: '#<'.
	stream nextPutAll: self class name.
	stream nextPut: Character space.
	
	self class columns
		associationsDo: [:assoc |
			| name value |
			name := assoc key.
			value := assoc value.
			value := self perform: name.
			stream nextPutAll: name.
			stream nextPutAll: ': '.
			stream nextPutAll: (self class sqlString: value).
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

!ARBase methodsFor: 'accessing' stamp: 'RMV 11/13/2024 08:37:35'!
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
			arg := aMessage arguments first.
			self class validateColumn: instVarName value: arg.
			row at: instVarName put: arg.
			
			"Update the database row. Later this will be done when a transaction is commited."
			tableName := self class tableName.
			arg := self class sqlString: arg.
			query := 'update {1} set {2}="{3}" where id={4}' format: {tableName. instVarName. arg. self id}.
			Conn execute: query.
		]
		ifFalse: [
			self class validateColumn: keyword.

			"Simulate getting an instance variable."
			^ row at: keyword asSymbol ifAbsent: nil.
		].
! !

!ARBase methodsFor: 'accessing' stamp: 'RMV 11/6/2024 19:13:19'!
row: anODBCRow
	"Set the row instance variable of the current object to a given ODBCRow."

	row := anODBCRow! !

!ARBase methodsFor: 'updating' stamp: 'RMV 11/18/2024 05:45:08'!
update: assocArray
	"Update an existing row in the corresponding table and answer an ODBCResultSet describing it."
	| queryString stream |
	
	self class validateAssocArray: assocArray.
	
	stream := WriteStream on: (String new: 200).
	stream nextPutAll: 'update '.
	stream nextPutAll: self class tableName.
	stream nextPutAll: ' set '.
	assocArray
		do: [:assoc |
			stream nextPutAll: assoc key.
			stream nextPutAll: ' = '.
			stream nextPutAll: (self class sqlString: (assoc value)).
		]
		separatedBy: [
			stream nextPutAll: ', '.
		].
	
	stream nextPutAll: ' where id = '.
	stream nextPutAll: self id asString.
	
	queryString := stream contents.
	^ Conn execute: queryString.	! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/17/2024 19:59:57'!
columns
	"Answer a Dictionary where keys are column names and values are their SQL types, computed lazily."

	columns ifNil: [
		| queryString rs |
		
		columns := Dictionary new.

		dbType caseOf: {
			[#MySQL] -> [
				queryString​ := 'select column_name, data_type from information_schema.columns where table_name = ''{1}''' format: {self tableName}.
				rs := Conn execute: queryString.
				rs asTable do: [:row |
					columns at: (row at: #COLUMN_NAME) put: (row at: #DATA_TYPE)
				].
			].
			[#Postgres] -> [
				queryString​ := 'select column_name, data_type from information_schema.columns where table_name = ''{1}''' format: {self tableName}.
				rs := Conn execute: queryString.
				rs asTable do: [:row |
					columns at: (row at: #column_name) put: (row at: #data_type)
				].
			].
			[#SQLite]->[
				"This query returns an empty ODBCResultSet for the corresponding table
				which can be used to get information about its columns."
				queryString​ := 'select * from {1} where 1=2' format: {self tableName}.

				rs := Conn execute: queryString.
				rs columns do: [:column |
					columns at: column name put: column dataType
				].
			]
		} otherwise: [self unsupportedDBType].
	].

	^ columns.
! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/18/2024 18:21:32'!
count
	"Answer number of rows in corresponding table."
	| queryString row rs column |
	
	column := 'count(*)'.
	queryString​ := 'select {1} from {2}' format: {column. self tableName}.
	rs := Conn execute: queryString.
	row := rs next.
	
	dbType caseOf: {
		[#MySQL] -> [^ row at: (column asSymbol)].
		[#Postgres] -> [^ row at: #count].
		[#SQLite] -> [^ row at: (column asSymbol)].
	} otherwise: [self unsupportedDBType].! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/10/2024 16:23:03'!
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

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/6/2024 20:03:56'!
connection
	^ Conn! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/17/2024 08:47:56'!
dbType
	^ dbType! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/6/2024 18:48:42'!
disconnect
	"Close the database connect if there is one."

	Conn ifNotNil: [
		Conn close.
		Conn := nil.
	]! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/17/2024 07:40:01'!
establishConnection: dsnString	
	"TODO: Delete this and always use establishConnect:dbType: ?"
	"Open a connection to the database for a given DSN if not already open."
	"TODO: Add support for getting username and password from '.odbc.ini'
	by capturing output of 'odbcinst -q -s -n dsnString'?"

	Conn ifNil: [ Conn := ODBCConnection dsn: dsnString user: '' password: '' ].
	Conn sqlGetInfoString: 1 :: logAs: 'establishConnect infoString'.
	^ Conn.
! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/17/2024 07:45:26'!
establishConnection: dsnString	 dbType: dbTypeSymbol
	"Open a connection to the database for a given DSN if not already open."
	"TODO: Add support for getting username and password from '.odbc.ini'
	by capturing output of 'odbcinst -q -s -n dsnString'?"

	dbType := dbTypeSymbol.
	Conn ifNil: [ Conn := ODBCConnection dsn: dsnString user: '' password: '' ].
	Conn sqlGetInfoString: 1 :: logAs: 'establishConnect infoString'.
	^ Conn.
! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/17/2024 05:09:58'!
reset
	Conn := nil.
	columns := nil.! !

!ARBase class methodsFor: 'creating' stamp: 'RMV 11/18/2024 05:43:41'!
create: assocArray
	"Create a new row in the corresponding table and answer an ODBCResultSet containing it.
	This assumes the table has an id column with type autoincrement integer."
	| cols column dict id names queryString rs stream values |
	
	self validateAssocArray: assocArray.
	
	dict := assocArray asDictionary.
	
	"Raise error if any keys are not valid column names
	or any values are not valid for their column type."
	dict associationsDo: [:assoc |
		self validateColumn: assoc key value: assoc value
	].
	
	cols := self columns.
	names := cols keys reject: [:columnName | columnName = 'id'].
	values := names collect: [:columnName |
		| value |
		value := dict at: columnName ifAbsent: [self sqlTypeDefault: (cols at: columnName)].
		self sqlString: value.
	].
	
	stream := WriteStream on: (String new: 200).
	stream nextPutAll: 'insert into '.
	stream nextPutAll: self tableName.
	stream nextPutAll: ' ('.
	names
		do: [:colName | stream nextPutAll: colName]
		separatedBy: [stream nextPutAll: ', '].
	stream nextPutAll: ') values ('.
	values
		do: [:value | stream nextPutAll: value asString]
		separatedBy: [stream nextPutAll: ', '].
	stream nextPutAll: ')'.
	queryString := stream contents.
	
	dbType caseOf: {
		[#MySQL] -> [
			rs := Conn execute: queryString.
			column := 'last_insert_id()'.
			rs := Conn execute: 'select ', column.
			id := rs next at: column asSymbol.
		].
		[#Postgres] -> [
			rs := Conn execute: queryString, ' returning id'.
			id := rs next at: #id.
		].
		[#SQLite] -> [
			rs := Conn execute: queryString.
			column := 'last_insert_rowid()'.
			rs := Conn execute: 'select ', column.
			id := rs next at: column asSymbol.
		]
	} otherwise: [self unsupportedDBType].
	
	^ id.
	! !

!ARBase class methodsFor: 'deleting' stamp: 'RMV 11/16/2024 10:35:44'!
destroyAll
	"Delete all rows from corresponding table and answer number of rows deleted."
	| rs |
	
	[ rs := Conn execute: 'delete from ', tableName ] on: UnhandledError do: [:ex |
		"This happens when there are no rows in the table."
		"We can ignore it."
	].

	^ rs ifNil: 0 ifNotNil: [rs asTable size].
! !

!ARBase class methodsFor: 'deleting' stamp: 'RMV 11/16/2024 11:07:03'!
destroyBy: anAssociation
	"Deletes all matching rows in the corresponding table."
	| column queryString value |
	
	self validateAssoc: anAssociation.
	
	column := anAssociation key.
	value := self sqlString: anAssociation value.
	queryString​ := 'delete from {1} where {2}={3}'
		format: {self tableName. column. value}.
	^​ Conn execute: queryString.
! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/11/2024 20:06:25'!
all
	"Answer a collection of instances of this class that represent all the rows in the corresponding table."
	|rs|

	rs := Conn execute: 'select * from ', self tableName.
	^ rs asTable collect: [:row | self newRow: row].! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/18/2024 05:41:34'!
falseValue
	^ dbType caseOf: {
		[#MySQL] -> [0].
		[#Postgres] -> ['0']. "tests fail with 'f'"
		[#SQLite] -> [0]
	} otherwise: [self unsupportedDBType]! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/16/2024 11:04:15'!
find: idNumber
	"Answer new instance of this class that represents the table row with a given id."
	| queryString row rs |
	
	queryString​ := 'select * from {1} where id={2}' format: {self tableName. idNumber}.
	rs := Conn execute: queryString.
	row := rs next. "ODBCResultSet is a subclass of Stream."
	^ row ifNil: nil ifNotNil: [self newRow: row].! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/16/2024 11:07:16'!
findBy: anAssociation
	"Answer collection of new instances of this class that represents matching table rows."
	| column queryString rs value |

	self validateAssoc: anAssociation.

	column := anAssociation key.
	value := self sqlString: anAssociation value.
	queryString​ := 'select * from {1} where {2}={3}'
		format: {self tableName. column. value}.
	rs := Conn execute: queryString.
	^ rs asTable collect: [:row | self newRow: row].! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/10/2024 20:15:55'!
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
	
	rs := Conn execute: queryString.
	^ rs asTable collect: [:row | self newRow: row].! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/10/2024 20:08:27'!
first
	"Answer new instance of this class that represents the first record in the corresponding table."
	| queryString row rs |
	
	queryString​ := 'select * from {1} limit 1' format: {self tableName}.
	rs := Conn execute: queryString.
	row := rs next. "ODBCResultSet is a subclass of Stream."
	^ self newRow: row.! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/10/2024 20:09:42'!
last
	"Answer new instance of this class that represents the first record in the corresponding table."
	| queryString row rs |
	
	queryString​ := 'select * from {1} order by id desc limit 1' format: {self tableName}.
	rs := Conn execute: queryString.
	row := rs next. "ODBCResultSet is a subclass of Stream."
	^ self newRow: row.! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/18/2024 05:41:22'!
trueValue
	^ dbType caseOf: {
		[#MySQL] -> [1].
		[#Postgres] -> ['1']. "tests fail with 't'"
		[#SQLite] -> [1]
	} otherwise: [self unsupportedDBType]! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/17/2024 09:05:40'!
unsupportedDBType
	Error signal: 'unsupported database type ', dbType! !

!ARBase class methodsFor: 'updating' stamp: 'RMV 11/18/2024 05:44:28'!
updateAll: assocArray
	"Update all rows in the corresponding table and answer an ODBCResultSet describing it."
	| queryString stream |

	self validateAssocArray: assocArray.

	stream := WriteStream on: (String new: 200).
	stream nextPutAll: 'update '.
	stream nextPutAll: self tableName.
	stream nextPutAll: ' set '.
	assocArray
		do: [:assoc |
			stream nextPutAll: assoc key.
			stream nextPutAll: ' = '.
			stream nextPutAll: (self sqlString: (assoc value)).
		]
		separatedBy: [
			stream nextPutAll: ', '.
		].
	
	queryString := stream contents.	
	^ Conn execute: queryString.	! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/17/2024 08:14:37'!
newRow
	"Create a new row in the corresponding table and answer an ODBCResultSet containing it.
	This assumes the table has an id column with type autoincrement integer."
	| names queryString stream values |
	
	"Get all the column names except the id column."
	names := columns keys reject: [:column | column name = #id].	
	
	"Get all the default column values."
	values := columns values collect: [:dataType | self sqlTypeDefault: dataType].
	
	stream := WriteStream on: (String new: 200).
	stream nextPutAll: 'insert into '.
	stream nextPutAll: self tableName.
	stream nextPutAll: ' ('.
	names
		do: [:column | stream nextPutAll: column]
		separatedBy: [stream nextPutAll: ', ' ].
	stream nextPutAll: ') values ('.
	values
		do: [:value | stream nextPutAll: value asString]
		separatedBy: [stream nextPutAll: ', ' ].
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

!ARBase class methodsFor: 'private' stamp: 'RMV 11/10/2024 20:23:06'!
quoteIfString: value
	^ value isString
		ifTrue: ['''{1}''' format: {value}]
		ifFalse: [value]! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/12/2024 18:54:23'!
sqlString: value
	"Answer string representation of value and include quotes if already a string."
	^ value isString
		ifTrue: ['''{1}''' format: {value}]
		ifFalse: [value asString]! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/18/2024 05:44:00'!
sqlTypeDefault: sqlTypeString
	^​ sqlTypeString caseOf: {
		['boolean'] -> ['f'].
		['Double'] -> [0].
		['Integer'] -> [0].
		['tinyint'] -> [0].
		['VarChar'] -> [''].
	} otherwise: [nil].! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/12/2024 20:47:36'!
validateColumn: aSymbol
	"Raises an error if aSymbol is not the name of a column in the correponding table.
	Otherwise returns the ODBCColumn."

	^ self columns at: aSymbol ifAbsent: [
		Error signal: ('table {1} does not have column {2}' format: {self tableName. aSymbol}).
	]! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/17/2024 08:50:29'!
validateColumn: aSymbol value: anObject
	| column template type valid |

	column := self validateColumn: aSymbol.
	type := columns at: aSymbol.
	
	valid := type caseOf: {
		[#boolean] -> [anObject isKindOf: Boolean].
		[#Double] -> [anObject isFloat or: [anObject isInteger]].
		[#Integer] -> [anObject isInteger].
		[#LongVarChar] -> [anObject isString].
		[#text] -> [anObject isString].
		[#VarChar] -> [anObject isString]
	} otherwise: [
		template := 'table {1} column {2} has unsupported type {3}'.
		Error signal: (template format: {self tableName. aSymbol. type}).
	].

	valid ifFalse: [
		template := '{1} is invalid value for table {2} column {3} type {4}'.
		Error signal: (template format: {anObject. self tableName. aSymbol. type}).
	].
! !

!DatabaseTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/18/2024 18:17:13'!
setUp	

	"Clear the cached connection. This is important when switching to a different database."
	Todo reset.
	dsn logAs: dsn.

	Todo establishConnection: dsn dbType: dbType.
	
	"Delete all rows in the todos table."
	Todo destroyAll.
	self assert: Todo count equals: 0.
	
	"Create three new rows."
	descriptions := #('cut grass' 'buy milk' 'study Smalltalk').
	descriptions do: [:description | Todo create: {#description -> description}].
	self assert: Todo count equals: 3.! !

!DatabaseTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/16/2024 19:03:46'!
tearDown

	Todo disconnect.
	! !

!DatabaseTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/18/2024 05:39:34'!
testColumnGetter
	| todo |
		
	todo := Todo first.
	self assert: todo description equals: descriptions first.! !

!DatabaseTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/18/2024 05:39:45'!
testDeleteRowByColumValue
	| todos |
	
	Todo destroyBy: #description->descriptions first.
	todos := Todo all.
	self assert: todos size equals: 2.! !

!DatabaseTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/18/2024 05:39:50'!
testDeleteRowForInstance
	| id todo |

	todo := Todo last.
	self assert: todo description equals: descriptions last.
	id := todo id.
	todo destroy.
	self assert: (Todo find: id) = nil.! !

!DatabaseTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/17/2024 08:58:55'!
testTableName
	
	self assert: (Todo tableName) equals: 'todos'! !

!DatabaseTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/18/2024 05:39:54'!
testUpdateColumn
	| completed todo todos |
	
	todos := Todo findBy: #description -> 'buy milk'.
	self assert: todos size equals: 1.
	todo := todos first.
	
	completed := Todo trueValue.
	todo update: {#completed -> completed}.

	todo := Todo find: todo id.
	self assert: todo completed equals: completed.! !

!MySQLTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/18/2024 18:14:12'!
setUp
	dsn := 'MySQLTodosDSN'.
	dbType := 'MySQL'.
	super setUp.! !

!PostgresTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/18/2024 18:14:29'!
setUp
	dsn := 'PostgresTodosDSN'.
	dbType := 'Postgres'.
	super setUp.! !

!SQLiteTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/18/2024 18:14:36'!
setUp
	dsn := 'SQLiteTodosDSN'.
	dbType := 'SQLite'.
	super setUp.! !

!Object methodsFor: '*ActiveRecord' stamp: 'RMV 11/5/2024 18:37:07'!
logAs: aString
    ('{1} = {2}' format: {aString. self}) print! !

!Object methodsFor: '*ActiveRecord' stamp: 'RMV 11/16/2024 19:14:01'!
validateAssoc: anObject
	"Raise error if anObject is not an Association object."

	anObject isKindOf: Association ::
		ifFalse: [Error signal: 'requires Association object'].! !

!Object methodsFor: '*ActiveRecord' stamp: 'RMV 11/16/2024 19:14:08'!
validateAssocArray: anObject
	"Raise error if anObject is not an Array of Association objects."

	anObject isArray ifFalse: [Error signal: 'requires Array'].

	anObject allSatisfy: [:element | element isKindOf: Association] ::
		ifFalse: [Error signal: 'requires Array of Association objects'].! !

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
