/*
    File: fn_initPlayer.sqf
    ====================
    Author: Joaquine
    ====================
    Description :

*/
params ["_player"];
private _uid = getPlayerUID _player;
diag_log format ["UID : %1", _uid];
if ((([(format["existPlayer:%1",_uid]),2] call DB_fnc_extDBSync))) then {
		diag_log "Un enregistrement GG";
	} else {
		diag_log "Pas d'enregistrement"
	};