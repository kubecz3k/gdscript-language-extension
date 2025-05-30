class_name Promise extends RefCounted
# # # #
## Simple Promise implementation. 
## Sample usage:
## var promise: Promise = async_compute_value()
## await(promise.wait_for_fulfill()
## assert(promise.is_correct(), promise.get_error())
## var computed_value: float = promise.get_result() as float
## 
## author: Jakub Grzesik
## Orginally implemented for the needs of https://github.com/MSEP-one/msep.one with some input from Mariano Javier Suligoy https://github.com/marianognu

signal _fulfilled


var _error: String = ""
var _result: Variant = null
var _is_fulfilled: bool = false


## Checks if the Promise is still pending (not yet fulfilled or failed).
func is_pending() -> bool:
	return not _is_fulfilled


## Checks if the Promise has been fulfilled
func is_fulfilled() -> bool:
	return _is_fulfilled


## Checks if the Promise was fulfilled without an error, should be used after the Promise is fulfilled.
func is_correct() -> bool:
	return not has_error()


## Returns the result of the Promise, should be used after the Promise is fulfilled.
func get_result() -> Variant:
	return _result


## Checks if the Promise failed, should be used after the Promise is fulfilled.
func has_error() -> bool:
	return not _error.is_empty()


## Returns the error message if the Promise failed, should be used after the Promise is fulfilled.
func get_error() -> String:
	return _error


## Fails the Promise with a given error message and an optional result.
## This marks the Promise as fulfilled
## Can only be called once.
func fail(in_error: String, in_result: Variant = null) -> void:
	_error = in_error
	fulfill(in_result)


## Fulfills the Promise with a given result.
## This marks the Promise as fulfilled
## Can only be called once.
func fulfill(in_result: Variant) -> void:
	assert(not _is_fulfilled, "Promise object can be used only once")
	_is_fulfilled = true
	_result = in_result
	_fulfill_emit()


## Waits for the Promise to be fulfilled.
## If the Promise is already fulfilled, it returns immediately.
## Should be used together with await keyword
func wait_for_fulfill() -> void:
	if not _is_fulfilled:
		await(_fulfilled)


## Emits the _fulfilled signal and disconnects all existing connections.
## This prevents further signals from being emitted from this Promise instance.
func _fulfill_emit() -> void:
	_fulfilled.emit()
	for connection: Dictionary in _fulfilled.get_connections():
		_fulfilled.disconnect(connection["callable"])