'From Cuis7.1 [latest update: #6883] on 9 December 2024 at 8:07:35 pm'!
'Description '!
!provides: 'ActiveRecord' 1 152!
!requires: 'ODBC' 1 9 nil!
!requires: 'TypeCheck' 1 1 nil!
SystemOrganization addCategory: #ActiveRecord!


!classDefinition: #ARBase category: #ActiveRecord!
Object subclass: #ARBase
	instanceVariableNames: 'row'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'ARBase class' category: #ActiveRecord!
ARBase class
	instanceVariableNames: 'adapter conn dbType columns logSQL tableName'!

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
	instanceVariableNames: ''
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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'Todo class' category: #ActiveRecord!
Todo class
	instanceVariableNames: ''!

!classDefinition: #DBAdapter category: #ActiveRecord!
Object subclass: #DBAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'DBAdapter class' category: #ActiveRecord!
DBAdapter class
	instanceVariableNames: 'connection logSQL tableColumns'!

!classDefinition: #MySQLAdapter category: #ActiveRecord!
DBAdapter subclass: #MySQLAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'MySQLAdapter class' category: #ActiveRecord!
MySQLAdapter class
	instanceVariableNames: ''!

!classDefinition: #PostgresAdapter category: #ActiveRecord!
DBAdapter subclass: #PostgresAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'PostgresAdapter class' category: #ActiveRecord!
PostgresAdapter class
	instanceVariableNames: ''!

!classDefinition: #SQLiteAdapter category: #ActiveRecord!
DBAdapter subclass: #SQLiteAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'SQLiteAdapter class' category: #ActiveRecord!
SQLiteAdapter class
	instanceVariableNames: ''!

!classDefinition: #Demo category: #ActiveRecord!
Object subclass: #Demo
	instanceVariableNames: 'number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'Demo class' category: #ActiveRecord!
Demo class
	instanceVariableNames: ''!

!classDefinition: #ActiveRecordError category: #ActiveRecord!
Error subclass: #ActiveRecordError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'ActiveRecordError class' category: #ActiveRecord!
ActiveRecordError class
	instanceVariableNames: ''!

!classDefinition: #ARBaseTests category: #ActiveRecord!
TestCase subclass: #ARBaseTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'ARBaseTests class' category: #ActiveRecord!
ARBaseTests class
	instanceVariableNames: ''!

!classDefinition: #DBAbstractTests category: #ActiveRecord!
TestCase subclass: #DBAbstractTests
	instanceVariableNames: 'descriptions dsn dbType falseValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'DBAbstractTests class' category: #ActiveRecord!
DBAbstractTests class
	instanceVariableNames: ''!

!classDefinition: #MySQLTests category: #ActiveRecord!
DBAbstractTests subclass: #MySQLTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'MySQLTests class' category: #ActiveRecord!
MySQLTests class
	instanceVariableNames: ''!

!classDefinition: #PostgresTests category: #ActiveRecord!
DBAbstractTests subclass: #PostgresTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'PostgresTests class' category: #ActiveRecord!
PostgresTests class
	instanceVariableNames: ''!

!classDefinition: #SQLiteTests category: #ActiveRecord!
DBAbstractTests subclass: #SQLiteTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActiveRecord'!
!classDefinition: 'SQLiteTests class' category: #ActiveRecord!
SQLiteTests class
	instanceVariableNames: ''!


!ARBase commentStamp: 'RMV 11/24/2024 15:22:16' prior: 0!
This is the superclass of all classes that represents database tables.
It adds "Active Record" functionality.!

!ApplicationRecord commentStamp: 'RMV 12/7/2024 05:34:57' prior: 0!
The purpose of this class is not yet clear to me, but it is present in Rails version 8.
For now it is just a subclass of ARBase that doesn't add any functionality and
classes that correspond to database tables are subclasses of ApplicationRecord instead of ARBase.!

!Dog commentStamp: 'RMV 11/24/2024 15:23:04' prior: 0!
This class is used to test the `tableName` method which should return "dogs".!

!GearShiftKnob commentStamp: 'RMV 11/24/2024 15:23:23' prior: 0!
This class is used to test the `tableName` method which should return "gear_shift_knobs".!

!Person commentStamp: 'RMV 11/24/2024 15:23:34' prior: 0!
This class is used to test the `tableName` method which should return "people".!

!Todo commentStamp: 'RMV 11/24/2024 15:24:04' prior: 0!
This class makes the database table "todos" accessible.!

!DBAdapter commentStamp: 'RMV 11/24/2024 15:27:02' prior: 0!
This is the superclass of all database-specific adapters.
It defines the methods that such adapters are required to implement.!

!MySQLAdapter commentStamp: 'RMV 11/24/2024 15:27:44' prior: 0!
This is a subclass of DBAdapter that implements the methods it requires in ways that are specific to MySQL.!

!PostgresAdapter commentStamp: 'RMV 11/24/2024 15:27:54' prior: 0!
This is a subclass of DBAdapter that implements the methods it requires in ways that are specific to Postgres.!

!SQLiteAdapter commentStamp: 'RMV 11/24/2024 15:28:01' prior: 0!
This is a subclass of DBAdapter that implements the methods it requires in ways that are specific to SQLite.!

!Demo commentStamp: 'RMV 11/24/2024 15:21:29' prior: 0!
The purpose of this class is to verify that `self typeCheck` works in instance methods.!

!ActiveRecordError commentStamp: 'RMV 11/24/2024 15:24:30' prior: 0!
Instances of this class represent errors signaled by methods in the ActiveRecord package.!

!DBAbstractTests commentStamp: 'RMV 11/24/2024 15:25:33' prior: 0!
This is the superclass of classes that implement database-specific test classes.
It provides test methods that are identical regardless of the database type (MySQL, Postgres, SQLite, ...).!

!MySQLTests commentStamp: 'RMV 11/24/2024 15:25:54' prior: 0!
This tests all the ActiveRecord methods with a MySQL database.!

!PostgresTests commentStamp: 'RMV 11/24/2024 15:26:15' prior: 0!
This tests all the ActiveRecord methods with a Postgres database.!

!SQLiteTests commentStamp: 'RMV 11/24/2024 15:26:23' prior: 0!
This tests all the ActiveRecord methods with a SQLite database.!

!ARBase methodsFor: 'deleting' stamp: 'RMV 11/22/2024 18:32:53'!
destroy
	"Delete the table row corresponding to the current object from the database
	and answer the ODBCResultSet."
	| queryString |
	
	queryString​ := 'delete from {1} where id={2}' format: {self class tableName. self id}.
	^​ self class execute: queryString.! !

!ARBase methodsFor: 'private' stamp: 'RMV 11/6/2024 19:10:47'!
changed: zeroOrOne
	"This method is implemented in Object, but we need it to trigger doesNotUnderstand:."
	| message |

	message := Message selector: #changed argument: zeroOrOne. 
	^ self doesNotUnderstand: message! !

!ARBase methodsFor: 'private' stamp: 'RMV 12/3/2024 19:40:07'!
row
	^row! !

!ARBase methodsFor: 'private' stamp: 'RMV 11/6/2024 19:13:19'!
row: anODBCRow
	"Set the row instance variable of the current object to a given ODBCRow."

	row := anODBCRow! !

!ARBase methodsFor: 'accessing' stamp: 'RMV 12/3/2024 20:34:59'!
doesNotUnderstand: aMessage
	"Handle requests to get or set an instance variable
	and update the corresponding database row."
	| keyword keywords |

	keywords := aMessage keywords.
	
	"Only handle messages with a single keyword."
	keywords size > 1 ifTrue: [^super doesNotUnderstand: aMessage].
	
	keyword := keywords first asSymbol.
	"TODO: This will not be called if the keyword matches an existing selector (ex. changed:)."
	keyword endsWith: ':' ::
		ifTrue: [
			"Simulate setting an instance variable."
			| arg instVarName queryString tableName template |

			instVarName := keyword allButLast asSymbol.
			arg := aMessage arguments first.
			self class validateColumn: instVarName value: arg.
			row at: instVarName put: arg.
			
			"Update the database row. Later this will be done when a transaction is commited."
			tableName := self class tableName.
			template := 'update {1} set {2}={3} where id={4}'.
			arg := self class sqlString: arg.
			queryString := template format: {tableName. instVarName. arg. self id}.
			self class execute: queryString.
		]
		ifFalse: [
			self class validateColumn: keyword.

			"Simulate getting an instance variable."
			^ row at: keyword asSymbol ifAbsent: nil.
		].
! !

!ARBase methodsFor: 'accessing' stamp: 'RMV 12/3/2024 18:53:01'!
inspect
	"Answer string description of corresponding database record.
	The column names are output in alphabetical order."
	| columns keys stream |
		
	stream := WriteStream on: (String new: 300).
	stream nextPutAll: self class name.
	stream nextPut: Character space.
	
	columns := self class columns.
	keys := columns keys sort.
	
	keys do: [ :key |
		| value |
		value := self perform: key.
		stream nextPutAll: key.
		stream nextPutAll: ': '.
		stream nextPutAll: (self class sqlString: value).
	] separatedBy: [
		stream nextPutAll: ', '.
	].

	^ stream contents.! !

!ARBase methodsFor: 'updating' stamp: 'RMV 12/3/2024 20:24:42'!
update: assocSeq
	"Update an existing row in the corresponding table and the current object."
	| queryString stream |
	
	assocSeq validateAssocSeq.
	
	stream := WriteStream on: (String new: 200).
	stream nextPutAll: 'update '.
	stream nextPutAll: self class tableName.
	stream nextPutAll: ' set '.
	assocSeq
		do: [:assoc |
			| key value |
			key := assoc key.
			value := assoc value.
			stream nextPutAll: key.
			stream nextPutAll: '='.
			stream nextPutAll: (self class sqlString: value).
			self row at: key put: value.
		]
		separatedBy: [
			stream nextPutAll: ', '.
		].
	
	stream nextPutAll: ' where id='.
	stream nextPutAll: self id asString.
	
	queryString := stream contents.
	self class execute: queryString.	! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 12/1/2024 14:19:08'!
columns
	"Answer a Dictionary where keys are column names and values are their SQL types, computed lazily."

	^ adapter columns: tableName.
! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/22/2024 19:48:53'!
connection
	^ conn! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/22/2024 20:35:20'!
count
	"Answer number of rows in corresponding table."
	| queryString row rs column |
	
	column := 'count(*)'.
	queryString​ := 'select {1} from {2}' format: {column. self tableName}.
	rs := self execute: queryString.
	row := rs next.	
	^ row at: adapter countColumn.! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/17/2024 08:47:56'!
dbType
	^ dbType! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/22/2024 18:40:16'!
logSQL
	"Answer whether all SQL queries should be logged to the Transcript."

	^logSQL! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 11/24/2024 18:20:14'!
logSQL: aBoolean
	"Determines whether all SQL queries should be logged to the Transcript."

	TypeCheck check.

	logSQL := aBoolean.! !

!ARBase class methodsFor: 'accessing' stamp: 'RMV 12/7/2024 05:38:25'!
tableName
	"Answer table name that corresponds to current class, computed lazily.
	It is the snake_case, plural version of the current class name."

	tableName ifNil: [
		| words |
		words := self name asString camelToWords.
		words at: words size put: (words last asPlural).
		tableName := '_' join: words :: asLowercase.
	].

	^ tableName.
! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 11/24/2024 18:24:51'!
disconnect
	"Close the database connect if there is one."

	conn ifNotNil: [
		conn close.
		adapter := nil.
		columns := nil.
		conn := nil.
	]! !

!ARBase class methodsFor: 'connecting' stamp: 'RMV 12/9/2024 20:07:05'!
establishConnection: dsnSymbol dbType: dbtypeSymbol
	"Open a connection to the database for a given DSN if not already open."
	"TODO: Add support for getting username and password from '.odbc.ini'
	by capturing output of 'odbcinst -q -s -n dsnString'?"
	| envVar |
	
	TypeCheck check.
	
	envVar := 'DYLD_LIBRARY_PATH'.
	self getenv: envVar :: ifNil: [
		ActiveRecordError signal: ('environment variable {1} is not set' format: {envVar})
	]. 
	
	dbType := dbtypeSymbol.
	adapter := dbType caseOf: {
		[#MySQL] -> [MySQLAdapter].
		[#Postgres] -> [PostgresAdapter].
		[#SQLite] -> [SQLiteAdapter].
	} otherwise: [self unsupportedDBType].

	logSQL := false.
	
	conn ifNotNil: [
		conn dsn = dsnSymbol ifFalse: [
			self disconnect.
			conn := nil.
		]
	].

	conn ifNil: [
		[ conn := ODBCConnection dsn: dsnSymbol user: '' password: '' ]
			on: ODBCError
			do: [:ex |
				| message |
				message := 'failed to connect to {1} database for {2}' format: { dbtypeSymbol. dsnSymbol }.
				ActiveRecordError signal: message.
			]
	].

	adapter connection: conn.
	adapter logSQL: logSQL.! !

!ARBase class methodsFor: 'creating' stamp: 'RMV 12/1/2024 14:50:00'!
create: assocColl
	"Create a new row in the corresponding table and answer an ODBCResultSet containing it.
	This assumes the table has an id column with type autoincrement integer."
	| cols dict names queryString stream values |
	
	assocColl validateAssocSeq.
	
	dict := assocColl asDictionary.
	
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
	
	^ adapter insertAndGetId: queryString.
	! !

!ARBase class methodsFor: 'deleting' stamp: 'RMV 11/22/2024 18:32:08'!
destroyAll
	"Delete all rows from corresponding table and answer number of rows deleted."
	| rs |
	
	[ rs := self execute: 'delete from ', tableName ] on: UnhandledError do: [:ex |
		"This happens when there are no rows in the table."
		"We can ignore it."
	].

	^ rs ifNil: 0 ifNotNil: [rs asTable size].
! !

!ARBase class methodsFor: 'deleting' stamp: 'RMV 11/24/2024 18:20:14'!
destroyBy: anAssociation
	"Deletes all matching rows in the corresponding table."
	| column queryString value |
	
	TypeCheck check.
	
	column := anAssociation key.
	value := self sqlString: anAssociation value.
	queryString​ := 'delete from {1} where {2}={3}'
		format: {self tableName. column. value}.
	^​ self execute: queryString.
! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/22/2024 18:30:47'!
all
	"Answer a collection of instances of this class that represent all the rows in the corresponding table."
	|rs|

	rs := self execute: 'select * from ', self tableName.
	^ rs asTable collect: [:row | self newRow: row].! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 12/1/2024 14:58:14'!
falseValue
	^ adapter falseValue! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/24/2024 18:20:14'!
find: idNumber
	"Answer new instance of this class that represents the table row with a given id."
	| queryString row rs |
	
	TypeCheck check.
	
	queryString​ := 'select * from {1} where id={2}' format: {self tableName. idNumber}.
	rs := self execute: queryString.
	row := rs next. "ODBCResultSet is a subclass of Stream."
	^ row ifNil: nil ifNotNil: [self newRow: row].! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/24/2024 18:20:14'!
findBy: anAssociation
	"Answer collection of new instances of this class that represents matching table rows."
	| column queryString rs value |

	TypeCheck check.

	column := anAssociation key.
	value := self sqlString: anAssociation value.
	queryString​ := 'select * from {1} where {2}={3}'
		format: {self tableName. column. value}.
	rs := self execute: queryString.
	^ rs asTable collect: [:row | self newRow: row].! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 12/2/2024 10:31:33'!
findWhere: conditionSeq
	"Answer new instances of this class that represent matching table rows."
	| queryString rs size stream |
	
	conditionSeq validateAssocSeq.
	
	size := conditionSeq size.
	queryString​ := 'select * from {1} where id={2}' format: {self tableName}.
	
	stream := WriteStream on: (String new: 200).
	stream nextPutAll: 'select * from '.
	stream nextPutAll: self tableName.
	stream nextPutAll: ' where '.
	conditionSeq withIndexDo: [:condition :index |
		stream nextPutAll: condition key.
		stream nextPut: $=.
		stream nextPutAll: (Todo sqlString: condition value).
		index < size ifTrue: [ stream nextPutAll: ' and ' ].
	].
	queryString := stream contents.
	
	rs := self execute: queryString.
	^ rs asTable collect: [:row | self newRow: row].! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/22/2024 18:31:07'!
first
	"Answer new instance of this class that represents the first record in the corresponding table."
	| queryString row rs |
	
	queryString​ := 'select * from {1} limit 1' format: {self tableName}.
	rs := self execute: queryString.
	row := rs next. "ODBCResultSet is a subclass of Stream."
	^ self newRow: row.! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 11/22/2024 18:31:10'!
last
	"Answer new instance of this class that represents the first record in the corresponding table."
	| queryString row rs |
	
	queryString​ := 'select * from {1} order by id desc limit 1' format: {self tableName}.
	rs := self execute: queryString.
	row := rs next. "ODBCResultSet is a subclass of Stream."
	^ self newRow: row.! !

!ARBase class methodsFor: 'retrieving' stamp: 'RMV 12/1/2024 14:58:21'!
trueValue
	^ adapter trueValue! !

!ARBase class methodsFor: 'updating' stamp: 'RMV 12/3/2024 20:37:48'!
updateAll: assocSeq
	"Update all rows in the corresponding table."
	| queryString stream |

	assocSeq validateAssocSeq.

	stream := WriteStream on: (String new: 200).
	stream nextPutAll: 'update '.
	stream nextPutAll: self tableName.
	stream nextPutAll: ' set '.
	assocSeq
		do: [:assoc |
			stream nextPutAll: assoc key.
			stream nextPutAll: ' = '.
			stream nextPutAll: (self sqlString: (assoc value)).
		]
		separatedBy: [
			stream nextPutAll: ', '.
		].
	
	queryString := stream contents.
	self execute: queryString.! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/24/2024 18:20:14'!
execute: sqlString
	"Answer result set from executing a SQL query."
	
	TypeCheck check.

	logSQL ifTrue: [ 'executing SQL: ', sqlString :: print ].
	conn ifNil: [ActiveRecordError signal: 'database connection (conn) not set']. 
	^ conn execute: sqlString.! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/24/2024 18:20:14'!
newRow: anODBCRow
	"Create and answer a new instance of this class with a row instance variable."
	| instance |

	TypeCheck check.

	instance := self new.
	instance row: anODBCRow.
	^instance.! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/10/2024 20:23:06'!
quoteIfString: value
	^ value isString
		ifTrue: ['''{1}''' format: {value}]
		ifFalse: [value]! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/22/2024 19:49:20'!
reset
	conn := nil.
	columns := nil.! !

!ARBase class methodsFor: 'private' stamp: 'RMV 12/3/2024 19:52:45'!
sqlString: value
	"Answer string representation of value and include quotes if already a string."
	^ value isString
		ifTrue: ['''{1}''' format: {value}]
		ifFalse: [value asString]! !

!ARBase class methodsFor: 'private' stamp: 'RMV 12/3/2024 06:19:26'!
sqlTypeDefault: typeString

	TypeCheck check.

	^​ typeString caseOf: {
		[#boolean] -> ['f'].
		[#Double] -> [0].
		[#int] -> [0].
		[#Integer] -> [0].
		[#integer] -> [0].
		[#LongVarChar] -> [''].
		[#text] -> [''].
		[#tinyint] -> [0].
		[#VarChar] -> [''].
	} otherwise: [nil].! !

!ARBase class methodsFor: 'private' stamp: 'RMV 11/18/2024 20:31:06'!
unsupportedDBType
	ActiveRecordError signal: 'unsupported database type ', dbType! !

!ARBase class methodsFor: 'private' stamp: 'RMV 12/3/2024 06:05:26'!
validateColumn: aSymbol
	"Raises an error if aSymbol is not the name of a column in the corresponding table.
	Otherwise returns its type."

	TypeCheck check.

	^ self columns at: aSymbol ifAbsent: [
		| message |
		message := 'table {1} does not have column {2}' format: {self tableName. aSymbol}.
		ActiveRecordError signal: message.
	]! !

!ARBase class methodsFor: 'private' stamp: 'RMV 12/3/2024 06:26:13'!
validateColumn: aSymbol value: anObject
	"Raises an error if aSymbol is not the name of a column in the corresponding table.
	Otherwise returns its type."
	| message template type valid |

	TypeCheck check.

	type := self validateColumn: aSymbol.	
	valid := type caseOf: {
		[#boolean] -> [anObject = self falseValue or: [anObject = self trueValue]].
		[#Double] -> [anObject isFloat or: [anObject isInteger]].
		[#int] -> [anObject isInteger].
		[#Integer] -> [anObject isInteger].
		[#integer] -> [anObject isInteger].
		[#LongVarChar] -> [anObject isString].
		[#text] -> [anObject isString].
		[#tinyint] -> [anObject isInteger].
		[#VarChar] -> [anObject isString]
	} otherwise: [
		template := 'table {1} column {2} has unsupported type {3}'.
		ActiveRecordError signal: (template format: {self tableName. aSymbol. type}).
	].

	valid ifFalse: [
		template := '{1} is invalid value for table {2} column {3} type {4}'.
		message := template format: {anObject. self tableName. aSymbol. type}.
		ActiveRecordError signal: message.
	].

	^type.! !

!Todo methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 19:12:55'!
isCompleted
	^ self completed = self class trueValue! !

!DBAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 13:52:30'!
columns
	"Answer a Dictionary where keys are column names and values are their SQL types, computed lazily."
	self subclassResponsibility! !

!DBAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:35:42'!
columns: tableNameString
	"Answer a Dictionary where keys are column names in a given table
	and values are their SQL types, computed lazily."

	self subclassResponsibility! !

!DBAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:30:52'!
connection: anODBCConnection
	connection := anODBCConnection! !

!DBAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 11/22/2024 20:33:10'!
countColumn
	"Answer name of column that holds the count of records in a table."

	self subclassResponsibility.! !

!DBAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:31:12'!
execute: sqlString
	"Answer result set from executing a SQL query."
	
	TypeCheck check.

	logSQL ifTrue: [ 'executing SQL: ', sqlString :: print ].
	connection ifNil: [ActiveRecordError signal: 'database connection not set']. 
	^ connection execute: sqlString.! !

!DBAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:52:35'!
falseValue
	"Answer value that represents false in this database."

	self subclassResponsibility! !

!DBAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:46:58'!
insertAndGetId: queryString
	"Create a new row in the corresponding table and answer an ODBCResultSet containing it.
	This assumes the table has an id column with type autoincrement integer."
	
	self subclassResponsibility
! !

!DBAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:34:23'!
logSQL: aBoolean
	logSQL := aBoolean! !

!DBAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:54:31'!
trueValue
	"Answer value that represents true in this database."

	self subclassResponsibility! !

!MySQLAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:23:37'!
columns: tableNameString
	"Answer a Dictionary where keys are column names and values are their SQL types, computed lazily."

	tableColumns ifNil: [ tableColumns := Dictionary new ].
	
	^ tableColumns at: tableNameString ifAbsentPut: [
		| columnDict queryString rs template |

		template​ := 'select column_name, data_type from information_schema.columns where table_name = ''{1}'''.
		queryString​ := template format: { tableNameString}.
		rs := self execute: queryString.

		columnDict := Dictionary new.
		rs asTable do: [:row |
			columnDict at: (row at: #COLUMN_NAME) put: (row at: #DATA_TYPE)
		].
		columnDict.
	].! !

!MySQLAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 11/22/2024 19:31:20'!
countColumn
	"Answer name of column that holds the count of records in a table."

	^ 'count(*)' asSymbol! !

!MySQLAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:52:54'!
falseValue
	"Answer value that represents false in this database."

	^0! !

!MySQLAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:48:04'!
insertAndGetId: queryString
	"Create a new row in the corresponding table and answer an ODBCResultSet containing it.
	This assumes the table has an id column with type autoincrement integer."
	| column id rs |
	
	rs := self execute: queryString.
	column := 'last_insert_id()'.
	rs := self execute: 'select ', column.
	id := rs next at: column asSymbol.
	^id.
! !

!MySQLAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:54:45'!
trueValue
	"Answer value that represents false in this database."

	^1! !

!PostgresAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:23:53'!
columns: tableNameString
	"Answer a Dictionary where keys are column names and values are their SQL types, computed lazily."

	tableColumns ifNil: [ tableColumns := Dictionary new ].
	
	^ tableColumns at: tableNameString ifAbsentPut: [
		| columnDict queryString rs template |

		template := 'select column_name, data_type from information_schema.columns where table_name = ''{1}'''.
		queryString​ := template format: {tableNameString}.
		rs := self execute: queryString.

		columnDict := Dictionary new.
		rs asTable do: [:row |
			columnDict at: (row at: #column_name) put: (row at: #data_type)
		].
		columnDict.
	].! !

!PostgresAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 11/22/2024 19:31:46'!
countColumn
	"Answer name of column that holds the count of records in a table."

	^ #count! !

!PostgresAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:53:17'!
falseValue
	"Answer value that represents false in this database."

	^'0' "tests fail with 'f'"! !

!PostgresAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:48:30'!
insertAndGetId: queryString
	"Create a new row in the corresponding table and answer an ODBCResultSet containing it.
	This assumes the table has an id column with type autoincrement integer."
	| id rs |
	
	rs := self execute: queryString, ' returning id'.
	id := rs next at: #id.
	^id.
! !

!PostgresAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:55:06'!
trueValue
	"Answer value that represents false in this database."

	^'1' "tests fail with 't'"! !

!SQLiteAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:24:03'!
columns: tableNameString
	"Answer a Dictionary where keys are column names and values are their SQL types, computed lazily."

	tableColumns ifNil: [ tableColumns := Dictionary new ].
	
	^ tableColumns at: tableNameString ifAbsentPut: [
		| columnDict queryString rs |
	
		"This query returns an empty ODBCResultSet for the corresponding table
		which can be used to get information about its columns."
		queryString​ := 'select * from {1} where 1=2' format: {tableNameString}.
		rs := self execute: queryString.

		columnDict := Dictionary new.
		rs columns do: [:column |
			columnDict at: column name put: column dataType
		].
		columnDict.
	].! !

!SQLiteAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 11/22/2024 19:31:57'!
countColumn
	"Answer name of column that holds the count of records in a table."

	^ 'count(*)' asSymbol! !

!SQLiteAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:53:26'!
falseValue
	"Answer value that represents false in this database."

	^0! !

!SQLiteAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:49:07'!
insertAndGetId: queryString
	"Create a new row in the corresponding table and answer an ODBCResultSet containing it.
	This assumes the table has an id column with type autoincrement integer."
	| column id rs |
	
	rs := self execute: queryString.
	column := 'last_insert_rowid()'.
	rs := self execute: 'select ', column.
	id := rs next at: column asSymbol.
	^id.
! !

!SQLiteAdapter class methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 14:55:14'!
trueValue
	"Answer value that represents false in this database."

	^1! !

!Demo methodsFor: 'as yet unclassified' stamp: 'RMV 11/25/2024 18:56:55'!
number
	"Answer the number instance variable."

	^number! !

!Demo methodsFor: 'as yet unclassified' stamp: 'RMV 11/25/2024 18:56:59'!
number: aNumber
	"Set the number instance variable."

	TypeCheck check.
	number := aNumber.! !

!Demo class methodsFor: 'as yet unclassified' stamp: 'RMV 12/5/2024 15:09:06'!
average: numberArray
	^ self memoize: [
		| sum |
		'computing average' print.
		sum := numberArray fold: [:acc :n | acc + n].
		sum / numberArray size.
	].! !

!ARBaseTests methodsFor: 'tests' stamp: 'RMV 12/4/2024 06:14:10'!
testQuoteIfString
	| number text |
	
	number := 123.	
	self assert: (Todo quoteIfString: number) equals: number.
	
	text := 'some text'.
	self assert: (Todo quoteIfString: text) equals: ('''', text, '''').! !

!ARBaseTests methodsFor: 'tests' stamp: 'RMV 12/4/2024 06:12:35'!
testSQLString
	| number text |
	
	number := 123.	
	self assert: (Todo sqlString: number) equals: number asString.
	
	text := 'some text'.
	self assert: (Todo quoteIfString: text) equals: ('''', text, '''').! !

!ARBaseTests methodsFor: 'tests' stamp: 'RMV 12/4/2024 06:10:14'!
testTableName
	
	self assert: (Dog tableName) equals: 'dogs'.
	self assert: (GearShiftKnob tableName) equals: 'gear_shift_knobs'.
	self assert: (Person tableName) equals: 'people'.
	self assert: (Todo tableName) equals: 'todos'.! !

!ARBaseTests methodsFor: 'tests' stamp: 'RMV 12/4/2024 06:14:39'!
testUnsupportedDBType

	self
		should: [Todo unsupportedDBType]
		raise: ActiveRecordError
		withExceptionDo: [:exception |
			self assert: (exception messageText beginsWith: 'unsupported database type ')
		].
	
	self
		should: [Todo unsupportedDBType]
		raise: ActiveRecordError
		"withMessageText: ['unsupported database type ', Todo dbType]."! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/4/2024 06:00:16'!
setUp	

	dsn ifNil: [Error signal: 'dsn not set'].
	dbType ifNil: [Error signal: 'dbType not set'].

	"Clear the cached connection. This is important when switching to a different database."
	Todo reset.

	Todo establishConnection: dsn dbType: dbType.
	
	"Delete all rows in the todos table."
	Todo destroyAll.
	self assert: Todo count equals: 0.
	
	"Create three new rows."
	descriptions := #('cut grass' 'buy milk' 'study Smalltalk').
	descriptions withIndexDo: [:description :index |
		Todo create: {
			#description -> description.
			#completed -> (index even ifTrue: [Todo trueValue] ifFalse: [Todo falseValue])
		}
	].
	self assert: Todo count equals: descriptions size.! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/16/2024 19:03:46'!
tearDown

	Todo disconnect.
	! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/3/2024 20:35:16'!
testAccessors
	| id newCompleted newDescription todo |

	todo := Todo first.
	id := todo id.

	newDescription := 'learn Smalltalk'.
	newCompleted := Todo trueValue.
	todo description: newDescription.
	todo completed: newCompleted.

	todo := Todo find: id.
	self assert: todo description equals: newDescription.
	self assert: todo completed equals: newCompleted.! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/2/2024 10:20:15'!
testAll
	| todos |
		
	todos := Todo all.
	self assert: todos size equals: 3.
	
	todos withIndexDo: [:todo :index |
		self assert: todo description equals: (descriptions at: index).
	].
! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/3/2024 18:59:58'!
testChanged
	| todo |

	todo := Todo first.
	self
		should: [todo changed: 1]
		raise: ActiveRecordError
		withMessageText: 'table todos does not have column changed'.
! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/18/2024 05:39:34'!
testColumnGetter
	| todo |
		
	todo := Todo first.
	self assert: todo description equals: descriptions first.! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/18/2024 19:19:09'!
testColumns
	self subclassResponsibility! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/1/2024 16:36:33'!
testConnection

	self assert: Todo connection ~= nil.! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/21/2024 18:48:08'!
testCount
	"The class method #count is tested in the setup method."! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/21/2024 18:48:40'!
testCreate
	"The class method #create: is tested in the setup method."! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/21/2024 18:48:54'!
testDbType
	self subclassResponsibility! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/21/2024 18:55:27'!
testDeleteRowByColumnValue
	| todos |
	
	Todo destroyBy: #description->descriptions first.
	todos := Todo all.
	self assert: todos size equals: 2.! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/18/2024 05:39:50'!
testDeleteRowForInstance
	| id todo |

	todo := Todo last.
	self assert: todo description equals: descriptions last.
	id := todo id.
	todo destroy.
	self assert: (Todo find: id) = nil.! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/3/2024 18:37:09'!
testDestroy
	| id todo |

	todo := Todo first.
	id := todo id.
	todo destroy.
	todo := Todo find: id.
	self assert: todo = nil.
! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/21/2024 18:47:44'!
testDestroyAll
	"The class method #destroyAll is tested in the setup method."! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/22/2024 18:49:55'!
testDestroyBy
	| rs |

	Todo destroyBy: #description->'buy milk'.
	rs := Todo findBy: #description->'buy milk'.
	self assert: rs size equals: 0.
	self assert: (Todo count) equals: 2.
	! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/3/2024 19:04:07'!
testDoesNotUnderstand
	| message todo |

	message := 'someName'.
	todo := Todo first.
	self
		should: [todo doesNotUnderstand: message]
		raise: ActiveRecordError
		withMessageText: 'table todos does not have column someName'.
! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/21/2024 18:47:16'!
testEstablishConnection
	"The class method #establishConnect is tested in the setup method."! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/1/2024 16:38:44'!
testExecute
	"The class method #execute: is tested in the setup method."! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/1/2024 16:40:00'!
testFalseValue
	self subclassResponsibility! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/4/2024 06:01:01'!
testFind
	| description id todo todos |

	"Find the todo with a specific description."
	description := 'buy milk'.
	todos := Todo findBy: #description->description.
	todo := todos first.
	
	"Find the same todo using its id."
	id := todo id.
	todo := Todo find: id.

	self assert: todo description equals: description.
	self assert: todo isCompleted.
	! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/2/2024 10:24:09'!
testFindBy
	"The class method #findBy is tested in the testFind method."! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/4/2024 06:02:04'!
testFindWhere
	| description todo todos |

	todos := Todo findWhere: {#completed->Todo falseValue}.
	self assert: todos size equals: 2.

	description := 'buy milk'.
	todos := Todo findWhere: {#description->description. #completed->Todo trueValue}.
	self assert: todos size equals: 1.
	
	todo := todos first.
	self assert: todo description equals: description.
	self assert: todo isCompleted.
	! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/18/2024 20:23:06'!
testFirst
	| todo |
		
	todo := Todo first.
	self assert: todo description equals: descriptions first.! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/3/2024 18:54:42'!
testInspect
	| completed expected todo |

	todo := Todo first.
	completed := Todo sqlString: todo completed.
	expected := 'Todo completed: {1}, description: ''{2}'', id: {3}' format: {completed. todo description. todo id}.
	self assert: todo inspect equals: expected.
! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/18/2024 20:24:07'!
testLast
	| todo |
		
	todo := Todo last.
	self assert: todo description equals: descriptions last.! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/2/2024 10:36:14'!
testNewRow
	"The newRow: class method is tested in many other tests including
	testAll, testFind, testFindBy, testFindWhere, testFirst, and testLast."! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 11/21/2024 18:46:53'!
testReset
	"The class method #reset is tested in the setup method."! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/3/2024 19:40:12'!
testRow
	| newRow todo |

	todo := Todo first.
	newRow := 'some value'.
	todo row: newRow.
	self assert: todo row equals: newRow.! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/2/2024 20:09:10'!
testSQLTypeDefault
	"The class method #sqlTypeDefault: doesn't really need a unit test."! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/2/2024 20:11:58'!
testTrueValue
	self subclassResponsibility! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/3/2024 20:22:32'!
testUpdate
	| id newCompleted newDescription todo |

	todo := Todo first.
	id := todo id.
	
	newDescription := 'learn Smalltalk'.
	newCompleted := Todo trueValue.
	todo update: { #description->newDescription. #completed->newCompleted }.
	
	todo := Todo find: id.
	self assert: todo description equals: newDescription.
	self assert: todo completed equals: newCompleted.
! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/3/2024 20:37:25'!
testUpdateAll
	| todos |
	
	Todo updateAll: {#completed->Todo trueValue}.
	todos := Todo all.
	self assert: todos size equals: 3.
	todos do: [:todo | self assert: todo completed equals: Todo trueValue].! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/3/2024 06:05:21'!
testValidateColumn
	| message |
	
	Todo validateColumn: #id.
	Todo validateColumn: #description.
	Todo validateColumn: #completed.

	message := 'table todos does not have column wrong'.
	self
		should: [Todo validateColumn: #wrong]
		raise: ActiveRecordError
		withMessageText: [message].! !

!DBAbstractTests methodsFor: 'tests' stamp: 'RMV 12/3/2024 06:25:03'!
testValidateColumnValue
	| message type |

	Todo validateColumn: #id value: 19.
	type := Todo validateColumn: #description value: 'some description'.
	Todo validateColumn: #completed value: Todo trueValue.
	Todo validateColumn: #completed value: Todo falseValue.

	message := '19 is invalid value for table todos column description type ', type.
	self
		should: [Todo validateColumn: #description value: 19]
		raise: ActiveRecordError
		withMessageText: [message].! !

!DBAbstractTests class methodsFor: 'as yet unclassified' stamp: 'RMV 11/19/2024 20:56:11'!
isAbstract
	^true! !

!MySQLTests methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 16:42:51'!
setUp

	dsn := #MySQLTodosDSN.
	dbType := #MySQL.
	super setUp.! !

!MySQLTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/18/2024 19:17:54'!
testColumns
	| cols |
	
	cols := Todo columns.
	self assert: (cols at: 'id') equals: 'int'.
	self assert: (cols at: 'description') equals: 'text'.
	self assert: (cols at: 'completed') equals: 'tinyint'.! !

!MySQLTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/21/2024 18:50:42'!
testDbType

	self assert: (Todo dbType) equals: 'MySQL'.! !

!MySQLTests methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 16:42:27'!
testFalseValue

	self assert: Todo falseValue equals: 0! !

!MySQLTests methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 16:43:17'!
testTrueValue

	self assert: Todo trueValue equals: 1! !

!MySQLTests class methodsFor: 'as yet unclassified' stamp: 'RMV 11/19/2024 20:55:50'!
isAbstract
	^false! !

!PostgresTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/24/2024 13:03:05'!
setUp
	dsn := #PostgresTodosDSN.
	dbType := #Postgres.
	super setUp.! !

!PostgresTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/18/2024 19:18:21'!
testColumns
	| cols |
	
	cols := Todo columns.
	self assert: (cols at: 'id') equals: 'integer'.
	self assert: (cols at: 'description') equals: 'text'.
	self assert: (cols at: 'completed') equals: 'boolean'.! !

!PostgresTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/21/2024 18:50:38'!
testDbType

	self assert: (Todo dbType) equals: 'Postgres'.! !

!PostgresTests methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 16:44:15'!
testFalseValue

	self assert: Todo falseValue equals: '0'! !

!PostgresTests methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 16:44:30'!
testTrueValue

	self assert: Todo trueValue equals: '1'! !

!PostgresTests class methodsFor: 'as yet unclassified' stamp: 'RMV 11/19/2024 20:55:55'!
isAbstract
	^false! !

!SQLiteTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/24/2024 13:02:53'!
setUp
	dsn := #SQLiteTodosDSN.
	dbType := #SQLite.
	super setUp.! !

!SQLiteTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/18/2024 20:39:32'!
testColumns
	| cols |
	
	cols := Todo columns.
	self assert: (cols at: #id) equals: #Integer.
	self assert: (cols at: #description) equals: #VarChar.
	self assert: (cols at: #completed) equals: #Double.! !

!SQLiteTests methodsFor: 'as yet unclassified' stamp: 'RMV 11/21/2024 18:50:32'!
testDbType

	self assert: (Todo dbType) equals: 'SQLite'.! !

!SQLiteTests methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 16:44:02'!
testFalseValue

	self assert: Todo falseValue equals: 0! !

!SQLiteTests methodsFor: 'as yet unclassified' stamp: 'RMV 12/1/2024 16:43:51'!
testTrueValue

	self assert: Todo trueValue equals: 1! !

!SQLiteTests class methodsFor: 'as yet unclassified' stamp: 'RMV 11/19/2024 20:56:03'!
isAbstract
	^false! !

!Object methodsFor: '*ActiveRecord' stamp: 'RMV 12/9/2024 19:18:19'!
getenv: aString
	"Answer value of environment variable with the given name or nil if not found."

	<cdecl: char* 'getenv' (char*) module: 'libSystem.dylib'>
	^self externalCallFailed! !

!CharacterSequence methodsFor: '*ActiveRecord' stamp: 'RMV 11/24/2024 11:02:32'!
substringFromFirstUpper
	| index |
	index := self findFirst: [:char | char isUppercase].
	^ index > 0 ifTrue: [self copyFrom: index to: self size] ifFalse: nil.
! !

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

!ODBCConnection methodsFor: '*ActiveRecord' stamp: 'RMV 11/24/2024 13:07:54'!
dsn
	^dsn! !
