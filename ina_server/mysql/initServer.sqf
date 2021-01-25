  
  _database = "tadatabse"
  _protocol = "SQL_CUSTOM"
  _protocol_option = "inalife.ini" //Ici tu poura mettre ton ini si t'en fais un
  
  _result = parseSimpleArray ("extDB3" callExtension format["9:ADD_DATABASE:%1", _database]);
	if (_result select 0 isEqualTo 0) exitWith {diag_log format ["extDB3: Error Database: %1", _result]; false};
	diag_log "extDB3: Connected to Database";
	// Generate Randomized Protocol Name
	_random_number = round(random(999999));
	_extDB_SQL_CUSTOM_ID = str(_random_number);
	extDB_SQL_CUSTOM_ID = compileFinal _extDB_SQL_CUSTOM_ID;
	// extDB Load Protocol
	_result = parseSimpleArray ("extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%1:%2:%3:%4", _database, _protocol, _extDB_SQL_CUSTOM_ID, _protocol_options]);
	if ((_result select 0) isEqualTo 0) exitWith {diag_log format ["extDB3: Error Database Setup: %1", _result]; false};
	diag_log format ["extDB3: Initalized %1 Protocol", _protocol];
	// extDB3 Lock
	"extDB3" callExtension "9:LOCK";
	diag_log "extDB3: Locked";

	// Save Randomized ID
	uiNamespace setVariable ["extDB_SQL_CUSTOM_ID", _extDB_SQL_CUSTOM_ID];
	_return = true;





	//Ton code Ici
	// requete == [_query,2] call fnc_asyncCall









fnc_asyncCall = {
	private ["_queryStmt","_mode","_multiarr","_queryResult","_key","_return","_loop"];
		_queryStmt = [_this,0,"",[""]] call BIS_fnc_param;
		_mode = [_this,1,1,[0]] call BIS_fnc_param;
		_multiarr = [_this,2,false,[false]] call BIS_fnc_param;

		_key = EXTDB format ["%1:%2:%3",_mode,FETCH_CONST(extDB_SQL_CUSTOM_ID),_queryStmt];

		if (_mode isEqualTo 1) exitWith {true};

		_key = call compile format ["%1",_key];
		_key = (_key select 1);
		_queryResult = EXTDB format ["4:%1", _key];

		//Make sure the data is received
		if (_queryResult isEqualTo "[3]") then {
			for "_i" from 0 to 1 step 0 do {
				if (!(_queryResult isEqualTo "[3]")) exitWith {};
				_queryResult = EXTDB format ["4:%1", _key];
			};
		};

		if (_queryResult isEqualTo "[5]") then {
			_loop = true;
			for "_i" from 0 to 1 step 0 do { // extDB3 returned that result is Multi-Part Message
				_queryResult = "";
				for "_i" from 0 to 1 step 0 do {
					_pipe = EXTDB format ["5:%1", _key];
					if (_pipe isEqualTo "") exitWith {_loop = false};
					_queryResult = _queryResult + _pipe;
				};
			if (!_loop) exitWith {};
			};
		};
		_queryResult = call compile _queryResult;
		if ((_queryResult select 0) isEqualTo 0) exitWith {diag_log format ["extDB3: Protocol Error: %1", _queryResult]; []};
		_return = (_queryResult select 1);
		if (!_multiarr && count _return > 0) then {
			_return = (_return select 0);
		};

		_return;
};

